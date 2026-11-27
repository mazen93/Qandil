import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/qandil_lantern_mark.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/quran_entities.dart';
import '../cubit/quran_reader_cubit.dart';
import '../cubit/quran_reader_state.dart';

/// Phase 3 Bottom sheet opened when tapping any verse in the Quran reader:
/// 1. Tafsir (choose from available list + scholar credit)
/// 2. Translation (choose language/translator + credit)
/// 3. Word-by-Word breakdown
/// 4. Bookmark with color picker & Personal reflection note
/// 5. Share as text or PNG image card with mandatory credit line
class VerseActionBottomSheet extends StatefulWidget {
  const VerseActionBottomSheet({
    required this.verse,
    required this.surahName,
    super.key,
  });

  final QuranVerse verse;
  final String surahName;

  @override
  State<VerseActionBottomSheet> createState() => _VerseActionBottomSheetState();
}

class _VerseActionBottomSheetState extends State<VerseActionBottomSheet> {
  static const List<String> _bookmarkColors = [
    '#F2A93B', // Lantern Amber
    '#1F6F5C', // Nile Green
    '#D98A12', // Deep Gold
    '#C85A5A', // Warm Rose
  ];

  late final TextEditingController _noteController;
  final GlobalKey _shareCardBoundaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
    final cubit = context.read<QuranReaderCubit>();
    cubit.loadVerseDetails(widget.verse).then((_) {
      if (mounted) {
        _noteController.text = cubit.state.activeVerseNote;
      }
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  String _stripHtmlTags(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  Future<void> _shareAsText(
    AppLocalizations l10n,
    QuranReaderState state,
  ) async {
    final buffer = StringBuffer()
      ..writeln('﴿ ${widget.verse.textUthmani} ﴾')
      ..writeln('[${widget.surahName} — ${widget.verse.verseKey}]');

    final translation = state.activeVerseTranslation;
    if (translation != null && translation.text.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln(_stripHtmlTags(translation.text));
      if (translation.resourceName.isNotEmpty) {
        buffer.writeln('— ${translation.resourceName}');
      }
    }

    buffer
      ..writeln()
      ..write(l10n.verseShareCreditLine);

    await SharePlus.instance.share(
      ShareParams(text: buffer.toString()),
    );
  }

  Future<void> _shareAsImage(AppLocalizations l10n) async {
    try {
      final boundary = _shareCardBoundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) return;

      final image = await boundary.toImage(pixelRatio: 2.5);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      final pngBytes = Uint8List.view(byteData.buffer);
      final xFile = XFile.fromData(
        pngBytes,
        mimeType: 'image/png',
        name: 'qandil_${widget.verse.verseKey.replaceAll(':', '_')}.png',
      );

      await SharePlus.instance.share(
        ShareParams(
          files: [xFile],
          text: l10n.verseShareCreditLine,
        ),
      );
    } catch (_) {
      // Fallback to text share if headless or offscreen image capture fails
      if (mounted) {
        await _shareAsText(l10n, context.read<QuranReaderCubit>().state);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<QuranReaderCubit, QuranReaderState>(
      builder: (context, state) {
        final cubit = context.read<QuranReaderCubit>();
        final activeBookmarkColor =
            state.bookmarksByVerseKey[widget.verse.verseKey];

        return DefaultTabController(
          length: 4,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.78,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Verse Card Header & Share Buttons (also wrapped in RepaintBoundary for Image Share)
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        16,
                        12,
                        16,
                        8,
                      ),
                      child: RepaintBoundary(
                        key: _shareCardBoundaryKey,
                        child: Container(
                          padding: const EdgeInsetsDirectional.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.night,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.lantern.withValues(alpha: 0.45),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  const QandilLanternMark(
                                    size: 24,
                                    forceDarkColorway: true,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${widget.surahName} • ${widget.verse.verseKey}',
                                      style: theme.textTheme.labelLarge
                                          ?.copyWith(color: AppColors.lantern),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                widget.verse.textUthmani,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: AppTypography.mushafVerseStyle(
                                  color: AppColors.ivory,
                                  fontSize: 24,
                                  height: 1.8,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l10n.verseShareCreditLine,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: AppColors.ivoryMuted,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Share Buttons Row
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _shareAsText(l10n, state),
                              icon: const Icon(Icons.share_outlined, size: 18),
                              label: Text(l10n.verseSheetShareText),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _shareAsImage(l10n),
                              icon: const Icon(Icons.image_outlined, size: 18),
                              label: Text(l10n.verseSheetShareImage),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 4 Tabs: Tafsir | Translation | Word-by-Word | Bookmark & Note
                    TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(text: l10n.verseSheetTafsirTab),
                        Tab(text: l10n.verseSheetTranslationTab),
                        Tab(text: l10n.verseSheetWordByWordTab),
                        Tab(text: l10n.verseSheetBookmarkNoteTab),
                      ],
                    ),

                    Expanded(
                      child: TabBarView(
                        children: [
                          // 1. Tafsir Tab
                          _buildTafsirTab(context, l10n, state, cubit),

                          // 2. Translation Tab
                          _buildTranslationTab(context, l10n, state, cubit),

                          // 3. Word-by-Word Tab
                          _buildWordByWordTab(context),

                          // 4. Bookmark & Note Tab
                          _buildBookmarkAndNoteTab(
                            context,
                            l10n,
                            activeBookmarkColor,
                            cubit,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTafsirTab(
    BuildContext context,
    AppLocalizations l10n,
    QuranReaderState state,
    QuranReaderCubit cubit,
  ) {
    final theme = Theme.of(context);
    final tafsirs = state.tafsirCatalog;
    final activeTafsir = state.activeVerseTafsir;

    return ListView(
      padding: const EdgeInsetsDirectional.all(16),
      children: [
        if (tafsirs.isNotEmpty) ...[
          DropdownButtonFormField<int>(
            initialValue: tafsirs.any((t) => t.id == state.selectedTafsirId)
                ? state.selectedTafsirId
                : tafsirs.first.id,
            decoration: InputDecoration(
              labelText: l10n.verseSheetSelectTafsir,
              border: const OutlineInputBorder(),
            ),
            items: tafsirs
                .map(
                  (t) => DropdownMenuItem<int>(
                    value: t.id,
                    child: Text('${t.name} (${t.authorName})'),
                  ),
                )
                .toList(),
            onChanged: (id) {
              if (id != null) {
                cubit.loadVerseDetails(widget.verse, tafsirId: id);
              }
            },
          ),
          const SizedBox(height: 16),
        ],
        if (activeTafsir != null && activeTafsir.text.isNotEmpty) ...[
          Text(
            _stripHtmlTags(activeTafsir.text),
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.7),
          ),
          const SizedBox(height: 12),
          Text(
            activeTafsir.resourceName.isNotEmpty
                ? '— ${activeTafsir.resourceName}'
                : '— التفسير الميسر (مجمع الملك فهد لطباعة المصحف الشريف)',
            style: theme.textTheme.labelMedium,
          ),
        ] else
          Text(
            l10n.verseShareCreditLine,
            style: theme.textTheme.bodyMedium,
          ),
      ],
    );
  }

  Widget _buildTranslationTab(
    BuildContext context,
    AppLocalizations l10n,
    QuranReaderState state,
    QuranReaderCubit cubit,
  ) {
    final theme = Theme.of(context);
    final translations = state.translationCatalog;
    final activeTranslation = state.activeVerseTranslation;

    return ListView(
      padding: const EdgeInsetsDirectional.all(16),
      children: [
        if (translations.isNotEmpty) ...[
          DropdownButtonFormField<int>(
            initialValue: translations.any(
              (t) => t.id == state.selectedTranslationId,
            )
                ? state.selectedTranslationId
                : translations.first.id,
            decoration: InputDecoration(
              labelText: l10n.verseSheetSelectTranslation,
              border: const OutlineInputBorder(),
            ),
            items: translations
                .map(
                  (t) => DropdownMenuItem<int>(
                    value: t.id,
                    child: Text('${t.name} (${t.languageName})'),
                  ),
                )
                .toList(),
            onChanged: (id) {
              if (id != null) {
                cubit.loadVerseDetails(widget.verse, translationId: id);
              }
            },
          ),
          const SizedBox(height: 16),
        ],
        if (activeTranslation != null && activeTranslation.text.isNotEmpty) ...[
          Text(
            _stripHtmlTags(activeTranslation.text),
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
          const SizedBox(height: 12),
          Text(
            activeTranslation.resourceName.isNotEmpty
                ? '— ${activeTranslation.resourceName}'
                : '— Dr. Mustafa Khattab, The Clear Quran',
            style: theme.textTheme.labelMedium,
          ),
        ],
      ],
    );
  }

  Widget _buildWordByWordTab(BuildContext context) {
    final theme = Theme.of(context);
    final words = widget.verse.words
        .where((w) => w.charTypeName == 'word')
        .toList(growable: false);

    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.all(16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: words.map((word) {
            return Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.outline),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    word.textUthmani,
                    style: AppTypography.mushafVerseStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 24,
                      height: 1.5,
                    ),
                  ),
                  if (word.transliterationText.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      word.transliterationText,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                  if (word.translationText.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      word.translationText,
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBookmarkAndNoteTab(
    BuildContext context,
    AppLocalizations l10n,
    String? activeBookmarkColor,
    QuranReaderCubit cubit,
  ) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsetsDirectional.all(16),
      children: [
        Text(
          l10n.verseSheetBookmarkColorLabel,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ..._bookmarkColors.map((hex) {
              final color = _parseHexColor(hex);
              final isSelected = activeBookmarkColor == hex;
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: InkWell(
                  onTap: () => cubit.setBookmark(
                    verse: widget.verse,
                    colorHex: hex,
                  ),
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.onSurface,
                        width: isSelected ? 3 : 1,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.bookmark_rounded,
                            color: AppColors.ivory,
                            size: 20,
                          )
                        : null,
                  ),
                ),
              );
            }),
            if (activeBookmarkColor != null)
              TextButton.icon(
                onPressed: () => cubit.removeBookmark(widget.verse),
                icon: const Icon(Icons.bookmark_remove_outlined),
                label: Text(l10n.verseSheetRemoveBookmark),
              ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          l10n.verseSheetNoteLabel,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _noteController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: l10n.verseSheetNoteHint,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () async {
            await cubit.saveNote(
              verse: widget.verse,
              content: _noteController.text,
            );
          },
          icon: const Icon(Icons.save_outlined),
          label: Text(l10n.verseSheetSaveNote),
        ),
      ],
    );
  }

  Color _parseHexColor(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    final value = int.tryParse('FF$cleaned', radix: 16) ?? 0xFFF2A93B;
    return Color(value);
  }
}
