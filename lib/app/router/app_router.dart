import 'package:go_router/go_router.dart';

import '../../features/adhkar/presentation/pages/adhkar_reader_page.dart';
import '../../features/adhkar/presentation/pages/dhikr_hub_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/prayer/presentation/pages/prayer_page.dart';
import '../../features/quran/presentation/pages/quran_reader_page.dart';
import '../../features/settings/presentation/pages/credits_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import 'app_error_page.dart';
import 'app_routes.dart';
import 'app_shell_scaffold.dart';

/// Centralized declarative router configuration using GoRouter with 5 bottom bar branches.
abstract final class AppRouter {
  static GoRouter createRouter({String initialLocation = AppRoutes.homePath}) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.onboardingPath,
          name: AppRoutes.onboardingName,
          builder: (context, state) => const OnboardingPage(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return AppShellScaffold(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoutes.homePath,
                  name: AppRoutes.homeName,
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoutes.quranPath,
                  name: AppRoutes.quranName,
                  builder: (context, state) {
                    final pageParam = int.tryParse(
                      state.uri.queryParameters['page'] ?? '',
                    );
                    final verseKeyParam = state.uri.queryParameters['verseKey'];
                    final openTafsirParam =
                        state.uri.queryParameters['openTafsir'] == 'true';
                    return QuranReaderPage(
                      initialPageNumber: pageParam,
                      initialVerseKey: verseKeyParam,
                      openTafsirOnLoad: openTafsirParam,
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoutes.prayerPath,
                  name: AppRoutes.prayerName,
                  builder: (context, state) => const PrayerPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoutes.dhikrPath,
                  name: AppRoutes.dhikrName,
                  builder: (context, state) => const DhikrHubPage(),
                  routes: <RouteBase>[
                    GoRoute(
                      path: AppRoutes.adhkarCategorySubPath,
                      name: AppRoutes.adhkarCategoryName,
                      builder: (context, state) {
                        final catId =
                            state.pathParameters['categoryId'] ?? 'morning';
                        return AdhkarReaderPage(categoryId: catId);
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoutes.morePath,
                  name: AppRoutes.moreName,
                  builder: (context, state) => const SettingsPage(),
                  routes: <RouteBase>[
                    GoRoute(
                      path: AppRoutes.creditsSubPath,
                      name: AppRoutes.creditsName,
                      builder: (context, state) => const CreditsPage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => AppErrorPage(error: state.error),
    );
  }

  static final GoRouter router = createRouter();
}
