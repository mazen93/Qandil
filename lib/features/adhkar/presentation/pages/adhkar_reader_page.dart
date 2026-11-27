import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/di/register_dependencies.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/qandil_empty_state.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/adhkar_entities.dart';
import '../cubit/adhkar_cubit.dart';
import '../cubit/adhkar_state.dart';

/// Swipe reader for Adhkar and Duas inside a selected [category].
class AdhkarReaderPage extends StatelessWidget {
  const AdhkarReaderPage({
    super.key,
    required this.categoryId,
    this.initialItemIndex = 0,
  });

  final String categoryId;
  final int initialItemIndex;

  @override
  Widget build(BuildContext context) {
    final category =
        AdhkarCategory.tryFromKey(categoryId) ?? AdhkarCategory.morning;

    return BlocProvider<AdhkarCubit>(
      create: (_) {
        final cubit = getIt<AdhkarCubit>();
        cubit.initialize().then((_) {
          if (!cubit.isClosed) {
            cubit.selectCategory(
              category,
              initialIndex: initialItemIndex,
            );
          }
        });
        return cubit;
      },
      child: _AdhkarReaderView(category: category),
    );
  }
}

class _AdhkarReaderView extends StatefulWidget {
  const _AdhkarReaderView({required this.category});

  final AdhkarCategory category;

  @override
  State<_AdhkarReaderView> createState() => _AdhkarReaderViewState();
}

class _AdhkarReaderViewState extends State<_AdhkarReaderView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final categoryTitle =
        isAr ? widget.category.titleAr() : widget.category.titleEn();

    return BlocConsumer<AdhkarCubit, AdhkarState>(
      listener: (context, state) {
        if (_pageController.hasClients &&
            _pageController.page?.round() != state.currentReaderIndex) {
          _pageController.jumpToPage(state.currentReaderIndex);
        }
      },
      builder: (context, state) {
        final items = state.activeCategoryItems;
        final totalItems = items.length;
        final currentIndex = state.currentReaderIndex;
        final progress = state.activeCategoryProgress;
        final progressFraction = progress?.progressFraction ?? 0.0;

        return Scaffold(
          appBar: AppBar(
            title: Text(categoryTitle),
            actions: [
              if (totalItems > 0)
                Center(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            theme.colorScheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        l10n.adhkarItemCounter(currentIndex + 1, totalItems),
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              IconButton(
                icon: const Icon(Icons.format_size_rounded),
                tooltip: l10n.adhkarFontSizeLabel,
                onPressed: () => _showFontSizeSheet(context),
              ),
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                tooltip: l10n.adhkarResetCategoryAction,
                onPressed: () => _confirmResetCategory(context),
              ),
            ],
            bottom: totalItems > 0
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(4),
                    child: LinearProgressIndicator(
                      value: progressFraction,
                      minHeight: 4,
                      backgroundColor:
                          theme.colorScheme.onSurface.withValues(alpha: 0.08),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.lantern),
                    ),
                  )
                : null,
          ),
          body: state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.lantern),
                )
              : totalItems == 0
                  ? _EmptyCategoryPlaceholder(category: widget.category)
                  : Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: totalItems,
                            onPageChanged: (idx) {
                              context.read<AdhkarCubit>().setReaderIndex(idx);
                            },
                            itemBuilder: (context, idx) {
                              final item = items[idx];
                              final itemProgress = state.itemsProgress[item.id];
                              return _AdhkarItemCard(
                                item: item,
                                progress: itemProgress,
                                fontSize: state.readerFontSize,
                                isAr: isAr,
                                onIncrement: () async {
                                  final completed = await context
                                      .read<AdhkarCubit>()
                                      .incrementCurrentItem();
                                  if (completed &&
                                      state.autoAdvanceOnComplete &&
                                      idx < totalItems - 1 &&
                                      mounted) {
                                    unawaited(
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 320),
                                        curve: Curves.easeInOut,
                                      ),
                                    );
                                  }
                                },
                                onToggleComplete: () {
                                  context
                                      .read<AdhkarCubit>()
                                      .toggleCurrentItemComplete();
                                },
                                onShare: () => _shareItem(context, item, isAr),
                              );
                            },
                          ),
                        ),
                        _ReaderBottomNavigation(
                          currentIndex: currentIndex,
                          totalItems: totalItems,
                          onPrev: currentIndex > 0
                              ? () => _pageController.previousPage(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInOut,
                                  )
                              : null,
                          onNext: currentIndex < totalItems - 1
                              ? () => _pageController.nextPage(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInOut,
                                  )
                              : null,
                        ),
                      ],
                    ),
        );
      },
    );
  }

  void _showFontSizeSheet(BuildContext context) {
    final cubit = context.read<AdhkarCubit>();
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return BlocBuilder<AdhkarCubit, AdhkarState>(
          bloc: cubit,
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.adhkarFontSizeLabel,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.text_fields_rounded, size: 18),
                        Expanded(
                          child: Slider(
                            value: state.readerFontSize,
                            min: 18.0,
                            max: 38.0,
                            divisions: 10,
                            activeColor: AppColors.lantern,
                            label: '${state.readerFontSize.round()}',
                            onChanged: cubit.setReaderFontSize,
                          ),
                        ),
                        const Icon(Icons.text_fields_rounded, size: 28),
                      ],
                    ),
                    SwitchListTile.adaptive(
                      title: const Text('الانتقال التلقائي عند اكتمال التكرار'),
                      subtitle: const Text(
                          'التقدم للذكر التالي تلقائياً عند إتمام العدد'),
                      value: state.autoAdvanceOnComplete,
                      activeTrackColor: AppColors.lantern,
                      onChanged: cubit.toggleAutoAdvance,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _confirmResetCategory(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<AdhkarCubit>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: Text(l10n.adhkarResetCategoryAction),
          content: Text(l10n.adhkarResetCategoryConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(false),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogCtx).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.nile,
              ),
              child: const Text('إعادة الضبط'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      await cubit.resetActiveCategoryToday();
    }
  }

  Future<void> _shareItem(
      BuildContext context, AdhkarItem item, bool isAr) async {
    final l10n = AppLocalizations.of(context);
    final buffer = StringBuffer();
    buffer.writeln(item.arabic);

    final translation = isAr ? null : item.translationFor('en');
    if (translation != null && translation.isNotEmpty) {
      buffer.writeln();
      buffer.writeln(translation);
    }

    if (item.sourceRef != null && item.sourceRef!.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('${l10n.adhkarSourceLabel}: ${item.sourceRef}');
    }

    buffer.writeln();
    buffer.writeln('— ${l10n.adhkarShareCredit}');

    await SharePlus.instance.share(
      ShareParams(text: buffer.toString()),
    );
  }
}

class _AdhkarItemCard extends StatelessWidget {
  const _AdhkarItemCard({
    required this.item,
    required this.progress,
    required this.fontSize,
    required this.isAr,
    required this.onIncrement,
    required this.onToggleComplete,
    required this.onShare,
  });

  final AdhkarItem item;
  final AdhkarItemProgress? progress;
  final double fontSize;
  final bool isAr;
  final VoidCallback onIncrement;
  final VoidCallback onToggleComplete;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final currentCount = progress?.currentCount ?? 0;
    final isCompleted = progress?.isCompleted ?? false;
    final targetRepeat = item.repeat;
    final translation = isAr ? null : item.translationFor('en');

    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Repeat Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppColors.nile.withValues(alpha: 0.15)
                      : AppColors.lantern.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isCompleted
                          ? Icons.check_circle_rounded
                          : Icons.repeat_rounded,
                      size: 16,
                      color: isCompleted ? AppColors.nile : AppColors.lantern,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.repeatTextAr ??
                          (targetRepeat == 1
                              ? 'مرة واحدة'
                              : '$targetRepeat مرات'),
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isCompleted ? AppColors.nile : AppColors.night,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                tooltip: 'مشاركة الذكر',
                onPressed: onShare,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Main Arabic Text (Unmodified authentic text)
          Container(
            padding: const EdgeInsetsDirectional.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
              ),
            ),
            child: Text(
              item.arabic,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'UthmanicHafs',
                fontSize: fontSize,
                height: 1.9,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Optional Translation (if present)
          if (translation != null && translation.isNotEmpty) ...[
            Container(
              padding: const EdgeInsetsDirectional.all(14),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                translation,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Optional Fadl (Virtue / Merits if present in verified dataset)
          if (item.fadl != null && item.fadl!.trim().isNotEmpty) ...[
            Container(
              padding: const EdgeInsetsDirectional.all(14),
              decoration: BoxDecoration(
                color: AppColors.sand.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.lantern.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.star_outline_rounded,
                    size: 18,
                    color: AppColors.lantern,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.adhkarFadlLabel,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppColors.lantern,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.fadl!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Mandatory Source Reference Badge
          if (item.sourceRef != null && item.sourceRef!.trim().isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Icons.menu_book_outlined,
                  size: 15,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '${l10n.adhkarSourceLabel}: ${item.sourceRef}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],

          // Large Circular Tap Counter
          Center(
            child: SizedBox(
              width: 140,
              height: 140,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: CircularProgressIndicator(
                      value: targetRepeat > 0
                          ? (currentCount / targetRepeat).clamp(0.0, 1.0)
                          : 0.0,
                      strokeWidth: 8,
                      backgroundColor:
                          theme.colorScheme.onSurface.withValues(alpha: 0.08),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isCompleted ? AppColors.nile : AppColors.lantern,
                      ),
                    ),
                  ),
                  Material(
                    color: isCompleted ? AppColors.nile : AppColors.lantern,
                    shape: const CircleBorder(),
                    elevation: 3,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onIncrement,
                      child: SizedBox(
                        width: 116,
                        height: 116,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$currentCount',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.night,
                                ),
                              ),
                              Text(
                                '/ $targetRepeat',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color:
                                      AppColors.night.withValues(alpha: 0.75),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Mark Complete toggle button
          Center(
            child: TextButton.icon(
              onPressed: onToggleComplete,
              icon: Icon(
                isCompleted
                    ? Icons.check_circle_rounded
                    : Icons.check_circle_outline_rounded,
                color: isCompleted ? AppColors.nile : null,
              ),
              label: Text(
                l10n.adhkarMarkCompletedAction,
                style: TextStyle(
                  color: isCompleted ? AppColors.nile : null,
                  fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReaderBottomNavigation extends StatelessWidget {
  const _ReaderBottomNavigation({
    required this.currentIndex,
    required this.totalItems,
    required this.onPrev,
    required this.onNext,
  });

  final int currentIndex;
  final int totalItems;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context)
                .colorScheme
                .outlineVariant
                .withValues(alpha: 0.4),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: onPrev,
            tooltip: 'السابق',
          ),
          Text(
            '${currentIndex + 1} / $totalItems',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            onPressed: onNext,
            tooltip: 'التالي',
          ),
        ],
      ),
    );
  }
}

class _EmptyCategoryPlaceholder extends StatelessWidget {
  const _EmptyCategoryPlaceholder({required this.category});

  final AdhkarCategory category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return QandilEmptyState(
      icon: category.icon(),
      title: l10n.categoryEmptyTitle,
      message: l10n.categoryEmptyDescription,
    );
  }
}
