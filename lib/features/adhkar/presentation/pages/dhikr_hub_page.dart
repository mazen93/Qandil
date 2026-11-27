import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/register_dependencies.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/qandil_lantern_mark.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../tasbih/presentation/pages/tasbih_page.dart';
import '../../domain/entities/adhkar_entities.dart';
import '../cubit/adhkar_cubit.dart';
import '../cubit/adhkar_state.dart';

/// Unified Hub for Phase 8 Adhkar & Duas and Phase 7 Tasbih Counter.
class DhikrHubPage extends StatelessWidget {
  const DhikrHubPage({super.key, this.initialTabIndex = 0});

  final int initialTabIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdhkarCubit>(
      create: (context) => getIt<AdhkarCubit>()..initialize(),
      child: _DhikrHubView(initialTabIndex: initialTabIndex),
    );
  }
}

class _DhikrHubView extends StatefulWidget {
  const _DhikrHubView({required this.initialTabIndex});

  final int initialTabIndex;

  @override
  State<_DhikrHubView> createState() => _DhikrHubViewState();
}

class _DhikrHubViewState extends State<_DhikrHubView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex.clamp(0, 1),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const QandilLanternMark(size: 28),
            const SizedBox(width: 10),
            Text(l10n.dhikrShellTitle),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.lantern,
          indicatorWeight: 3,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor:
              theme.colorScheme.onSurface.withValues(alpha: 0.65),
          tabs: [
            Tab(
              icon: const Icon(Icons.auto_stories_rounded, size: 20),
              text: l10n.adhkarTabTitle,
            ),
            Tab(
              icon: const Icon(Icons.touch_app_rounded, size: 20),
              text: l10n.tasbihTabTitle,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _AdhkarCategoriesView(),
          TasbihPage(),
        ],
      ),
    );
  }
}

class _AdhkarCategoriesView extends StatelessWidget {
  const _AdhkarCategoriesView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return BlocBuilder<AdhkarCubit, AdhkarState>(
      builder: (context, state) {
        if (state.isLoading && state.dataset == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.lantern),
          );
        }

        final nowHour = DateTime.now().hour;
        final isMorningTime = nowHour >= 4 && nowHour < 14;
        final highlightedCategory =
            isMorningTime ? AdhkarCategory.morning : AdhkarCategory.evening;
        final bannerProgress = state.categoriesProgress[highlightedCategory];

        return RefreshIndicator(
          color: AppColors.lantern,
          onRefresh: () => context.read<AdhkarCubit>().initialize(),
          child: ListView(
            padding: const EdgeInsetsDirectional.all(16),
            children: [
              // Contextual Morning/Evening Time Banner
              _TimeContextualBanner(
                category: highlightedCategory,
                isMorning: isMorningTime,
                progress: bannerProgress,
                onTap: () => _openCategory(context, highlightedCategory),
              ),
              const SizedBox(height: 20),

              // Categories Header
              Text(
                l10n.adhkarTabTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Show populated Adhkar Categories (hide pending_import categories with 0 items)
              for (final category in AdhkarCategory.values)
                if ((state.categoriesProgress[category]?.totalItems ?? 0) >
                    0) ...[
                  _CategoryCard(
                    category: category,
                    isAr: isAr,
                    progress: state.categoriesProgress[category],
                    onTap: () => _openCategory(context, category),
                  ),
                  const SizedBox(height: 10),
                ],
            ],
          ),
        );
      },
    );
  }

  void _openCategory(BuildContext context, AdhkarCategory category) {
    context.pushNamed(
      AppRoutes.adhkarCategoryName,
      pathParameters: {'categoryId': category.key},
    );
  }
}

class _TimeContextualBanner extends StatelessWidget {
  const _TimeContextualBanner({
    required this.category,
    required this.isMorning,
    required this.progress,
    required this.onTap,
  });

  final AdhkarCategory category;
  final bool isMorning;
  final AdhkarCategoryProgress? progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final title = isMorning
        ? l10n.morningAdhkarBannerTitle
        : l10n.eveningAdhkarBannerTitle;
    final subtitle = isMorning
        ? l10n.morningAdhkarBannerSubtitle
        : l10n.eveningAdhkarBannerSubtitle;
    final total = progress?.totalItems ?? 0;
    final completed = progress?.completedItems ?? 0;
    final progressFraction = progress?.progressFraction ?? 0.0;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      color: isDark
          ? AppColors.lantern.withValues(alpha: 0.16)
          : AppColors.sand.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.lantern.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.lantern,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      isMorning
                          ? Icons.wb_sunny_rounded
                          : Icons.nightlight_round_rounded,
                      color: AppColors.night,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  if (total > 0)
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            theme.colorScheme.primary.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '$completed/$total',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              if (total > 0) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progressFraction,
                    minHeight: 6,
                    backgroundColor:
                        theme.colorScheme.onSurface.withValues(alpha: 0.1),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColors.lantern),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: FilledButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                  label: Text(l10n.readAdhkarAction),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.lantern,
                    foregroundColor: AppColors.night,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.isAr,
    required this.progress,
    required this.onTap,
  });

  final AdhkarCategory category;
  final bool isAr;
  final AdhkarCategoryProgress? progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final title = isAr ? category.titleAr() : category.titleEn();
    final total = progress?.totalItems ?? 0;
    final completed = progress?.completedItems ?? 0;
    final progressFraction = progress?.progressFraction ?? 0.0;
    final isCompleted = progress?.isAllCompleted ?? false;

    return Card(
      elevation: 0.5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppColors.nile.withValues(alpha: 0.16)
                          : AppColors.lantern.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      category.icon(),
                      color: isCompleted ? AppColors.nile : AppColors.lantern,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (total > 0)
                          Text(
                            l10n.adhkarProgressCompleted(completed, total),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isCompleted
                                  ? AppColors.nile
                                  : theme.textTheme.bodySmall?.color,
                            ),
                          )
                        else
                          Text(
                            l10n.categoryPendingNotice,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (isCompleted)
                    const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.nile,
                      size: 20,
                    )
                  else
                    Icon(
                      Icons.chevron_right_rounded,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                ],
              ),
              if (total > 0) ...[
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: progressFraction,
                    minHeight: 4,
                    backgroundColor:
                        theme.colorScheme.onSurface.withValues(alpha: 0.08),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCompleted ? AppColors.nile : AppColors.lantern,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
