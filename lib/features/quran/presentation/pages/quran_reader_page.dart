import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../app/di/register_dependencies.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_loading_indicator.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../audio/presentation/cubit/audio_cubit.dart';
import '../../../audio/presentation/cubit/audio_state.dart';
import '../../../audio/presentation/widgets/quran_audio_dock.dart';
import '../../../hifz/domain/entities/hifz_entities.dart';
import '../../../hifz/domain/services/hifz_display_masker.dart';
import '../../../hifz/presentation/pages/hifz_hub_page.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/cubit/settings_state.dart';
import '../../domain/entities/quran_entities.dart';
import '../../domain/services/reading_mode_service.dart';
import '../cubit/quran_reader_cubit.dart';
import '../cubit/quran_reader_state.dart';
import '../widgets/khatmah_planner_sheet.dart';
import '../widgets/reader_settings_sheet.dart';
import '../widgets/reading_mode_dnd_sheets.dart';
import '../widgets/verse_action_bottom_sheet.dart';

/// Phase 3 & Phase 4 Quran Reader screen supporting:
/// - Two modes: Mushaf Page View (Madani layout, swipe between pages) & Verse List View
/// - Authentic `UthmanicHafs` Mushaf font (never substituted with UI fonts)
/// - Navigation by Surah, Juz, and Page + Jump to Page dialog
/// - Arabic Search (normalized for matching only, never altering displayed text)
/// - Tap a verse -> bottom sheet with Tafsir, Translation, Word-by-Word, Colored Bookmark, Note, Share
/// - Automatic saving & restoring of reading position in Drift
/// - Khatmah planner & Reading settings (font size, line spacing, night mode, keep screen awake)
/// - Phase 4 Audio Dock: verse-by-verse & full-surah playback, live active verse highlight & auto-scroll
class QuranReaderPage extends StatefulWidget {
  const QuranReaderPage({
    super.key,
    this.initialPageNumber,
    this.initialVerseKey,
    this.openTafsirOnLoad = false,
  });

  final int? initialPageNumber;
  final String? initialVerseKey;
  final bool openTafsirOnLoad;

  @override
  State<QuranReaderPage> createState() => _QuranReaderPageState();
}

class _QuranReaderPageState extends State<QuranReaderPage>
    with WidgetsBindingObserver {
  late final QuranReaderCubit _cubit;
  late final AudioCubit _audioCubit;
  late final ReadingModeService _readingModeService;
  late PageController _pageController;
  final Map<String, GlobalKey> _verseCardKeys = {};
  bool _isProgrammaticPageTurn = false;
  bool _isReadingModeActive = false;

  // Phase 12: Non-destructive display-layer Hifz Hide Mode state
  HifzHideMode _hifzHideMode = HifzHideMode.none;
  int _hifzRandomHidePercent = 50;
  final Set<String> _tappedRevealedVerses = {};
  final Map<String, int> _wordByWordRevealedCounts = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cubit = getIt<QuranReaderCubit>();
    _audioCubit = getIt<AudioCubit>();
    _readingModeService = getIt<ReadingModeService>();
    _pageController = PageController(initialPage: 0);

    _cubit.initialize().then((_) async {
      if (!mounted) return;
      if (widget.initialPageNumber != null) {
        await _cubit.goToPage(widget.initialPageNumber!);
      }
      if (!mounted) return;
      final restoredPageIndex = (_cubit.state.currentPageNumber - 1).clamp(
        0,
        603,
      );
      if (_pageController.hasClients &&
          _pageController.page?.round() != restoredPageIndex) {
        _isProgrammaticPageTurn = true;
        _pageController.jumpToPage(restoredPageIndex);
        _isProgrammaticPageTurn = false;
      }
      _applyWakelockSetting();

      int defaultReciterId = 6;
      bool autoStartReadingMode = false;
      try {
        final s = context.read<SettingsCubit>().state.settings;
        defaultReciterId = s.defaultReciterId;
        autoStartReadingMode = s.autoStartReadingMode;
      } catch (_) {}

      await _audioCubit.initialize(
        defaultReciterId: defaultReciterId,
        chapters: _cubit.state.chapters,
      );

      if (autoStartReadingMode && mounted) {
        await _enterReadingMode();
      }

      if (widget.openTafsirOnLoad &&
          widget.initialVerseKey != null &&
          mounted) {
        final match = _cubit.state.currentPageVerses
            .where((v) => v.verseKey == widget.initialVerseKey)
            .firstOrNull;
        if (match != null) {
          final surahName = _cubit.state.currentChapter?.nameArabic ?? '';
          _openVerseBottomSheet(context, match, surahName);
        }
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Never leave the phone in DND when the app is paused/backgrounded/detached.
    if (_isReadingModeActive &&
        (state == AppLifecycleState.paused ||
            state == AppLifecycleState.detached)) {
      _exitReadingMode(showFlushToast: false);
    }
  }

  Future<void> _toggleReadingMode() async {
    if (_isReadingModeActive) {
      await _exitReadingMode(showFlushToast: true);
    } else {
      await _enterReadingMode();
    }
  }

  Future<void> _enterReadingMode() async {
    final outcome = await _readingModeService.enterReadingMode();
    if (!mounted) return;
    setState(() {
      _isReadingModeActive = outcome.isActive;
    });
    try {
      await WakelockPlus.enable();
    } catch (_) {}

    if (outcome.needsAndroidPolicyPermission && mounted) {
      final settingsCubit = context.read<SettingsCubit>();
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => AndroidDndPermissionSheet(
          readingModeService: _readingModeService,
          selectedFilter: settingsCubit.state.settings.readingModeDndFilter,
          onFilterChanged: settingsCubit.updateReadingModeDndFilter,
          onPermissionGranted: () {
            _readingModeService.enterReadingMode();
          },
        ),
      );
    } else if (outcome.shouldShowIosFocusTip && mounted) {
      try {
        await context.read<SettingsCubit>().markIosFocusTipShown();
      } catch (_) {}
      if (!mounted) return;
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => const IosFocusModeTipSheet(),
      );
    }
  }

  Future<void> _exitReadingMode({required bool showFlushToast}) async {
    final flushed = await _readingModeService.exitReadingMode();
    if (mounted) {
      setState(() {
        _isReadingModeActive = false;
      });
      _applyWakelockSetting();
      if (showFlushToast && flushed.isNotEmpty) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.readingModeHeldNotificationsToast(flushed.length),
            ),
          ),
        );
      }
    }
  }

  void _applyWakelockSetting() {
    try {
      final keepAwake = _isReadingModeActive ||
          context.read<SettingsCubit>().state.settings.keepScreenAwake;
      WakelockPlus.toggle(enable: keepAwake);
    } catch (_) {
      // Ignore in test environments without platform channels or SettingsCubit provider
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_isReadingModeActive) {
      _readingModeService.exitReadingMode();
    }
    try {
      WakelockPlus.disable();
    } catch (_) {}
    _pageController.dispose();
    _audioCubit.close();
    _cubit.close();
    super.dispose();
  }

  void _jumpControllerToPage(int pageNumber) {
    final targetIndex = (pageNumber - 1).clamp(0, 603);
    if (_pageController.hasClients &&
        _pageController.page?.round() != targetIndex) {
      _isProgrammaticPageTurn = true;
      _pageController.jumpToPage(targetIndex);
      _isProgrammaticPageTurn = false;
    }
  }

  void _handleActiveAudioVerseChanged(String? activeVerseKey) {
    if (activeVerseKey == null) return;
    final parts = activeVerseKey.split(':');
    if (parts.isEmpty) return;
    final surahNum = int.tryParse(parts.first);
    if (surahNum != null && surahNum != _cubit.state.currentSurahNumber) {
      _cubit.goToSurah(surahNum).then((_) {
        _jumpControllerToPage(_cubit.state.currentPageNumber);
      });
    }

    // Auto-scroll to the active verse card in Verse List View
    final key = _verseCardKeys[activeVerseKey];
    final keyContext = key?.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.3,
      );
    }
  }

  void _openVerseBottomSheet(
    BuildContext context,
    QuranVerse verse,
    String surahName,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider<QuranReaderCubit>.value(
        value: _cubit,
        child: VerseActionBottomSheet(
          verse: verse,
          surahName: surahName,
        ),
      ),
    );
  }

  void _openKhatmahSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider<QuranReaderCubit>.value(
        value: _cubit,
        child: const KhatmahPlannerSheet(),
      ),
    );
  }

  void _openReaderSettingsSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const ReaderSettingsSheet(),
    );
  }

  void _openHifzHubPage(BuildContext context) {
    final state = _cubit.state;
    final versesMap = <String, QuranVerse>{
      for (final v in state.currentPageVerses) v.verseKey: v,
    };
    final chapter = state.currentChapter;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => HifzHubPage(
          availableVersesByKey: versesMap,
          audioCubit: _audioCubit,
          initialSurahNumber: state.currentSurahNumber,
          initialSurahName: chapter?.nameArabic ?? 'الفاتحة',
          initialSurahVersesCount:
              chapter?.versesCount ?? state.currentPageVerses.length,
        ),
      ),
    );
  }

  void _openHifzHideModeSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.hifzHideModeTitle,
                      style: Theme.of(ctx).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    for (final mode in HifzHideMode.values)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          _hifzHideMode == mode
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_off_rounded,
                          color:
                              _hifzHideMode == mode ? AppColors.lantern : null,
                        ),
                        title: Text(_hideModeLabel(l10n, mode)),
                        onTap: () {
                          setState(() {
                            _hifzHideMode = mode;
                            _tappedRevealedVerses.clear();
                            _wordByWordRevealedCounts.clear();
                          });
                          setSheetState(() {});
                        },
                      ),
                    if (_hifzHideMode == HifzHideMode.randomPercent) ...[
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.hifzHideModeRandom),
                          Text('$_hifzRandomHidePercent%'),
                        ],
                      ),
                      Slider(
                        value: _hifzRandomHidePercent.toDouble(),
                        min: 20,
                        max: 80,
                        divisions: 6,
                        onChanged: (val) {
                          setState(() {
                            _hifzRandomHidePercent = val.round();
                          });
                          setSheetState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _hideModeLabel(AppLocalizations l10n, HifzHideMode mode) {
    return switch (mode) {
      HifzHideMode.none => l10n.hifzHideModeNone,
      HifzHideMode.hideAll => l10n.hifzHideModeAll,
      HifzHideMode.firstWordOnly => l10n.hifzHideModeFirstWord,
      HifzHideMode.randomPercent => l10n.hifzHideModeRandom,
      HifzHideMode.hideUntilTapped => l10n.hifzHideModeUntilTapped,
      HifzHideMode.revealWordByWord => l10n.hifzHideModeWordByWord,
    };
  }

  String _displayVerseText(QuranVerse verse) {
    return HifzDisplayMasker.formatMaskedVerseText(
      verse: verse,
      mode: _hifzHideMode,
      randomHidePercent: _hifzRandomHidePercent,
      isVerseTapped: _tappedRevealedVerses.contains(verse.verseKey),
      revealedWordCount: _wordByWordRevealedCounts[verse.verseKey] ?? 0,
    );
  }

  void _handleVerseTap(
    BuildContext context,
    QuranVerse verse,
    String surahTitle,
  ) {
    if (_hifzHideMode == HifzHideMode.hideUntilTapped) {
      setState(() {
        if (_tappedRevealedVerses.contains(verse.verseKey)) {
          _tappedRevealedVerses.remove(verse.verseKey);
        } else {
          _tappedRevealedVerses.add(verse.verseKey);
        }
      });
      return;
    }
    if (_hifzHideMode == HifzHideMode.revealWordByWord) {
      final totalWords = HifzDisplayMasker.extractWords(verse).length;
      final current = _wordByWordRevealedCounts[verse.verseKey] ?? 0;
      setState(() {
        _wordByWordRevealedCounts[verse.verseKey] =
            current >= totalWords ? 0 : current + 1;
      });
      return;
    }
    _openVerseBottomSheet(context, verse, surahTitle);
  }

  void _openJumpToPageDialog(BuildContext context, AppLocalizations l10n) {
    final controller = TextEditingController(
      text: '${_cubit.state.currentPageNumber}',
    );
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.readerJumpToPage),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: l10n.readerJumpToPageHint,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final parsed = int.tryParse(controller.text.trim());
              Navigator.of(dialogContext).pop();
              if (parsed != null) {
                final clamped = parsed.clamp(1, 604);
                _jumpControllerToPage(clamped);
                _cubit.goToPage(clamped);
              }
            },
            child: Text(l10n.readerJumpAction),
          ),
        ],
      ),
    );
  }

  void _openNavigationSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider<QuranReaderCubit>.value(
        value: _cubit,
        child: _NavigationIndexSheet(
          onSelectPage: (page) {
            Navigator.of(context).pop();
            _jumpControllerToPage(page);
            _cubit.goToPage(page);
          },
          onSelectSurah: (surahId) {
            Navigator.of(context).pop();
            _cubit.goToSurah(surahId).then((_) {
              _jumpControllerToPage(_cubit.state.currentPageNumber);
            });
          },
          onSelectJuz: (juz) {
            Navigator.of(context).pop();
            _cubit.goToJuz(juz).then((_) {
              _jumpControllerToPage(_cubit.state.currentPageNumber);
            });
          },
        ),
      ),
    );
  }

  void _openSearchSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider<QuranReaderCubit>.value(
        value: _cubit,
        child: _ArabicSearchSheet(
          onSelectVerse: (verse) {
            Navigator.of(context).pop();
            _jumpControllerToPage(verse.pageNumber);
            _cubit.goToPage(verse.pageNumber);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<QuranReaderCubit>.value(value: _cubit),
        BlocProvider<AudioCubit>.value(value: _audioCubit),
      ],
      child: BlocListener<AudioCubit, AudioState>(
        listenWhen: (previous, current) =>
            previous.activeVerseKey != current.activeVerseKey,
        listener: (context, audioState) {
          _handleActiveAudioVerseChanged(audioState.activeVerseKey);
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settingsState) {
            final readerFontSize = settingsState.settings.readerFontSize;
            final readerLineSpacing = settingsState.settings.readerLineSpacing;

            return BlocBuilder<AudioCubit, AudioState>(
              builder: (context, audioState) {
                return BlocBuilder<QuranReaderCubit, QuranReaderState>(
                  builder: (context, state) {
                    final currentChapter = state.currentChapter;
                    final surahTitle =
                        currentChapter?.nameArabic.isNotEmpty == true
                            ? currentChapter!.nameArabic
                            : l10n.quranShellTitle;
                    final surahVersesCount = currentChapter?.versesCount ??
                        state.currentPageVerses.length;

                    return Scaffold(
                      appBar: AppBar(
                        titleSpacing: 8,
                        title: InkWell(
                          onTap: () => _openNavigationSheet(context, l10n),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    surahTitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                const Flexible(
                                  flex: 0,
                                  child: Icon(
                                    Icons.expand_more_rounded,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            tooltip: l10n.readingModeToggleTooltip,
                            icon: Icon(
                              _isReadingModeActive
                                  ? Icons.self_improvement_rounded
                                  : Icons.nights_stay_outlined,
                              color: _isReadingModeActive
                                  ? AppColors.lantern
                                  : null,
                            ),
                            onPressed: _toggleReadingMode,
                          ),
                          if (!_isReadingModeActive) ...[
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              tooltip: l10n.hifzHideModeTitle,
                              icon: Icon(
                                _hifzHideMode.isHidingActive
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_outlined,
                                color: _hifzHideMode.isHidingActive
                                    ? AppColors.lantern
                                    : null,
                              ),
                              onPressed: () =>
                                  _openHifzHideModeSheet(context, l10n),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              tooltip: l10n.hifzTitle,
                              icon: const Icon(Icons.psychology_alt_outlined),
                              onPressed: () => _openHifzHubPage(context),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              tooltip: l10n.readerSearchHint,
                              icon: const Icon(Icons.search_rounded),
                              onPressed: () => _openSearchSheet(context),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              tooltip: l10n.readerJumpToPage,
                              icon: const Icon(Icons.find_in_page_outlined),
                              onPressed: () =>
                                  _openJumpToPageDialog(context, l10n),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              tooltip: l10n.khatmahPlannerTitle,
                              icon: const Icon(Icons.track_changes_rounded),
                              onPressed: () => _openKhatmahSheet(context),
                            ),
                          ],
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            tooltip: l10n.readerSettingsTitle,
                            icon: const Icon(Icons.text_fields_rounded),
                            onPressed: () => _openReaderSettingsSheet(context),
                          ),
                        ],
                      ),
                      body: Column(
                        children: [
                          // Phase 9 Dimmed Reading Mode Pill OR Full Mode Switcher & Page / Juz Header Bar
                          if (_isReadingModeActive)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                16,
                                4,
                                16,
                                6,
                              ),
                              child: InkWell(
                                onTap: _toggleReadingMode,
                                borderRadius: BorderRadius.circular(999),
                                child: Container(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.lantern.withValues(
                                      alpha: 0.16,
                                    ),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: AppColors.lantern.withValues(
                                        alpha: 0.45,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.self_improvement_rounded,
                                        size: 16,
                                        color: AppColors.lantern,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        l10n.readingModeActivePill,
                                        style: theme.textTheme.labelMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                16,
                                4,
                                16,
                                8,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SegmentedButton<QuranReaderViewMode>(
                                      segments: [
                                        ButtonSegment(
                                          value: QuranReaderViewMode.mushafPage,
                                          icon: const Icon(
                                            Icons.auto_stories_outlined,
                                            size: 18,
                                          ),
                                          label:
                                              Text(l10n.readerModeMushafPage),
                                        ),
                                        ButtonSegment(
                                          value: QuranReaderViewMode.verseList,
                                          icon: const Icon(
                                            Icons.view_list_rounded,
                                            size: 18,
                                          ),
                                          label: Text(l10n.readerModeVerseList),
                                        ),
                                      ],
                                      selected: {state.viewMode},
                                      onSelectionChanged: (selection) {
                                        _cubit.setViewMode(selection.first);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    l10n.readerPageHeader(
                                      state.currentPageNumber,
                                      state.currentJuzNumber,
                                    ),
                                    style: theme.textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ),

                          // Main Reader Surface (Mushaf Page View vs Verse List View)
                          Expanded(
                            child:
                                state.viewMode == QuranReaderViewMode.mushafPage
                                    ? _buildMushafPageView(
                                        context,
                                        state,
                                        audioState.activeVerseKey,
                                        surahTitle,
                                        readerFontSize,
                                        readerLineSpacing,
                                      )
                                    : _buildVerseListView(
                                        context,
                                        state,
                                        audioState.activeVerseKey,
                                        surahTitle,
                                        readerFontSize,
                                        readerLineSpacing,
                                      ),
                          ),

                          // Phase 4 Audio Playback Dock
                          QuranAudioDock(
                            currentSurahNumber: state.currentSurahNumber,
                            currentSurahName: surahTitle,
                            currentSurahVersesCount: surahVersesCount,
                            currentAyahNumber: state.currentAyahNumber,
                            chapters: state.chapters,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildMushafPageView(
    BuildContext context,
    QuranReaderState state,
    String? activeAudioVerseKey,
    String surahTitle,
    double fontSize,
    double lineSpacing,
  ) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 604,
        onPageChanged: (index) {
          if (!_isProgrammaticPageTurn) {
            _cubit.goToPage(index + 1);
          }
        },
        itemBuilder: (context, index) {
          final pageNum = index + 1;
          if (state.isLoading && state.currentPageVerses.isEmpty) {
            return const AppLoadingIndicator();
          }

          final verses = state.currentPageVerses;
          final currentChapter = state.currentChapter;
          final showBismillah = currentChapter != null &&
              currentChapter.bismillahPre &&
              verses.isNotEmpty &&
              verses.first.verseNumber == 1;

          return SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(16),
            child: Container(
              padding: const EdgeInsetsDirectional.all(20),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.lantern.withValues(alpha: 0.45),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Ornate Madani Surah Header Banner
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lantern.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.lantern.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'سورة $surahTitle',
                          style: theme.textTheme.headlineSmall,
                        ),
                        Text(
                          'صفحة ${_toArabicDigits(pageNum)}',
                          style: theme.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),

                  if (showBismillah) ...[
                    const SizedBox(height: 16),
                    Text(
                      'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
                      textAlign: TextAlign.center,
                      style: AppTypography.mushafVerseStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: fontSize,
                        height: lineSpacing,
                      ),
                    ),
                  ],

                  const SizedBox(height: 18),

                  // Flowing Madani Mushaf Verses with interactive tap & live audio highlight
                  RichText(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: AppTypography.mushafVerseStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: fontSize,
                        height: lineSpacing,
                      ),
                      children: verses.map((verse) {
                        final isPlayingVerse =
                            activeAudioVerseKey == verse.verseKey;
                        final isBookmarked = state.bookmarksByVerseKey
                            .containsKey(verse.verseKey);
                        final ayahMarker =
                            ' ﴿${_toArabicDigits(verse.verseNumber)}﴾ ';

                        Color? highlightBg;
                        if (isPlayingVerse) {
                          highlightBg = AppColors.lantern.withValues(
                            alpha: 0.38,
                          );
                        } else if (isBookmarked) {
                          highlightBg = AppColors.lantern.withValues(
                            alpha: 0.18,
                          );
                        }

                        return TextSpan(
                          text: '${_displayVerseText(verse)}$ayahMarker',
                          style: highlightBg != null
                              ? TextStyle(backgroundColor: highlightBg)
                              : null,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _handleVerseTap(
                                  context,
                                  verse,
                                  surahTitle,
                                ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerseListView(
    BuildContext context,
    QuranReaderState state,
    String? activeAudioVerseKey,
    String surahTitle,
    double fontSize,
    double lineSpacing,
  ) {
    final theme = Theme.of(context);
    if (state.isLoading && state.currentPageVerses.isEmpty) {
      return const AppLoadingIndicator();
    }

    return ListView.separated(
      padding: const EdgeInsetsDirectional.all(16),
      itemCount: state.currentPageVerses.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final verse = state.currentPageVerses[index];
        final isPlayingVerse = activeAudioVerseKey == verse.verseKey;
        final bookmarkHex = state.bookmarksByVerseKey[verse.verseKey];
        final translation =
            verse.translations.isNotEmpty ? verse.translations.first : null;
        final cardKey = _verseCardKeys.putIfAbsent(
          verse.verseKey,
          GlobalKey.new,
        );

        return Card(
          key: cardKey,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isPlayingVerse
                  ? AppColors.lantern
                  : theme.colorScheme.outline,
              width: isPlayingVerse ? 2.5 : 1.0,
            ),
          ),
          child: InkWell(
            onTap: () => _handleVerseTap(context, verse, surahTitle),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lantern,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          verse.verseKey,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: AppColors.night,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isPlayingVerse)
                            const Padding(
                              padding: EdgeInsetsDirectional.only(end: 6),
                              child: Icon(
                                Icons.volume_up_rounded,
                                color: AppColors.lantern,
                                size: 20,
                              ),
                            ),
                          if (bookmarkHex != null)
                            const Icon(
                              Icons.bookmark_rounded,
                              color: AppColors.lantern,
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${_displayVerseText(verse)} ﴿${_toArabicDigits(verse.verseNumber)}﴾',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: AppTypography.mushafVerseStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: fontSize,
                      height: lineSpacing,
                    ),
                  ),
                  if (translation != null && translation.text.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      translation.text.replaceAll(RegExp(r'<[^>]*>'), ''),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _toArabicDigits(int number) {
    const western = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const eastern = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    var result = number.toString();
    for (var i = 0; i < western.length; i++) {
      result = result.replaceAll(western[i], eastern[i]);
    }
    return result;
  }
}

class _NavigationIndexSheet extends StatelessWidget {
  const _NavigationIndexSheet({
    required this.onSelectSurah,
    required this.onSelectJuz,
    required this.onSelectPage,
  });

  final ValueChanged<int> onSelectSurah;
  final ValueChanged<int> onSelectJuz;
  final ValueChanged<int> onSelectPage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<QuranReaderCubit>().state;

    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.all(16),
                child: Text(
                  l10n.readerSelectNavigationTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              TabBar(
                tabs: [
                  Tab(text: l10n.readerNavSurah),
                  Tab(text: l10n.readerNavJuz),
                  Tab(text: l10n.readerNavPage),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // 1. Surahs List
                    ListView.builder(
                      itemCount: state.chapters.length,
                      itemBuilder: (context, index) {
                        final ch = state.chapters[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.lantern,
                            foregroundColor: AppColors.night,
                            child: Text('${ch.id}'),
                          ),
                          title: Text(ch.nameArabic),
                          subtitle: Text(
                            '${ch.nameSimple} • ${l10n.verseCount(ch.versesCount)}',
                          ),
                          trailing: Text(l10n.pageCount(ch.startPage)),
                          onTap: () => onSelectSurah(ch.id),
                        );
                      },
                    ),

                    // 2. Juz List (1..30)
                    ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        final juz = index + 1;
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.lantern,
                            foregroundColor: AppColors.night,
                            child: Text('$juz'),
                          ),
                          title: Text('${l10n.readerNavJuz} $juz'),
                          onTap: () => onSelectJuz(juz),
                        );
                      },
                    ),

                    // 3. Page List (1..604)
                    ListView.builder(
                      itemCount: 604,
                      itemBuilder: (context, index) {
                        final page = index + 1;
                        return ListTile(
                          title: Text('${l10n.readerNavPage} $page'),
                          onTap: () => onSelectPage(page),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArabicSearchSheet extends StatelessWidget {
  const _ArabicSearchSheet({required this.onSelectVerse});

  final ValueChanged<QuranVerse> onSelectVerse;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<QuranReaderCubit, QuranReaderState>(
      builder: (context, state) {
        final cubit = context.read<QuranReaderCubit>();

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.all(16),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: l10n.readerSearchHint,
                        prefixIcon: const Icon(Icons.search_rounded),
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: cubit.searchArabicVerses,
                    ),
                  ),
                  Expanded(
                    child: state.searchMatchedVerses.isEmpty
                        ? Center(
                            child: Text(
                              l10n.readerSearchNoResults,
                              style: theme.textTheme.bodyMedium,
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsetsDirectional.all(16),
                            itemCount: state.searchMatchedVerses.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, index) {
                              // Displays the original, unaltered textUthmani in UthmanicHafs font
                              final verse = state.searchMatchedVerses[index];
                              return ListTile(
                                title: Text(
                                  verse.textUthmani,
                                  textDirection: TextDirection.rtl,
                                  style: AppTypography.mushafVerseStyle(
                                    color: theme.colorScheme.onSurface,
                                    fontSize: 22,
                                    height: 1.7,
                                  ),
                                ),
                                subtitle: Text(
                                  '${verse.verseKey} • ${l10n.readerPageHeader(verse.pageNumber, verse.juzNumber)}',
                                ),
                                onTap: () => onSelectVerse(verse),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
