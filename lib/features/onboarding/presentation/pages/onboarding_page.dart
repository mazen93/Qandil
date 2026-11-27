import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/qandil_logo.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';

/// Phase 10 3-Screen Onboarding (`Read`, `Listen`, `Keep your daily wird`):
/// - Follows `QANDIL_BRAND.md` visual identity:
///   - Official `QandilLogo` with wordmark (**Qandil** / **قنديل** in Reem Kufi Bold)
///     and tagline (**Light for your day.** / **نورٌ يرافق يومك.**)
///   - Eight-point Rub el Hizb star ornament (`QandilRubElHizbOrnament`)
///   - Calm rounded cards (16px radius) and buttons (14px radius)
///   - Zero emoji and zero stock imagery.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
    this.onFinished,
  });

  final VoidCallback? onFinished;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    try {
      await context.read<SettingsCubit>().completeOnboarding();
    } catch (_) {}

    if (!mounted) return;
    if (widget.onFinished != null) {
      widget.onFinished!();
      return;
    }

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      context.goNamed(AppRoutes.homeName);
    }
  }

  void _nextSlide() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    final slides = <_OnboardingSlideData>[
      _OnboardingSlideData(
        icon: Icons.menu_book_rounded,
        title: l10n.onboardingReadTitle,
        subtitle: l10n.onboardingReadSubtitle,
      ),
      _OnboardingSlideData(
        icon: Icons.headphones_rounded,
        title: l10n.onboardingListenTitle,
        subtitle: l10n.onboardingListenSubtitle,
      ),
      _OnboardingSlideData(
        icon: Icons.track_changes_rounded,
        title: l10n.onboardingWirdTitle,
        subtitle: l10n.onboardingWirdSubtitle,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 24),
          child: Column(
            children: [
              // Top bar: Language switcher & Skip button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      try {
                        context
                            .read<SettingsCubit>()
                            .updateLanguage(isAr ? 'en' : 'ar');
                      } catch (_) {}
                    },
                    child: Text(
                      isAr ? l10n.languageEnglish : l10n.languageArabic,
                    ),
                  ),
                  TextButton(
                    onPressed: _finishOnboarding,
                    child: Text(l10n.onboardingSkipAction),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Official Qandil Logo + Wordmark (Qandil / قنديل) + Tagline
              const QandilLogo(
                height: 76,
                includeClearSpace: true,
                showWordmark: true,
                showTagline: true,
              ),
              const SizedBox(height: 20),

              // 3 Slides: Read, Listen, Keep your daily wird
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: slides.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final slide = slides[index];
                    return Center(
                      child: SingleChildScrollView(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: AppColors.lantern.withValues(
                                      alpha: isDark ? 0.2 : 0.25,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    slide.icon,
                                    size: 32,
                                    color: isDark
                                        ? AppColors.lantern
                                        : AppColors.night,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const QandilRubElHizbOrnament(size: 20),
                                const SizedBox(height: 16),
                                Text(
                                  slide.title,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  slide.subtitle,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                    height: 1.65,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Step Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(slides.length, (idx) {
                  final active = idx == _currentIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 4),
                    width: active ? 28 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: active
                          ? (isDark ? AppColors.lantern : AppColors.nile)
                          : theme.colorScheme.outline.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Primary CTA Button (Next / Begin with Qandil)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextSlide,
                  child: Text(
                    _currentIndex < 2
                        ? l10n.onboardingNextAction
                        : l10n.onboardingStartAction,
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

class _OnboardingSlideData {
  const _OnboardingSlideData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}
