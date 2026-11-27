import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/app/app.dart';
import 'package:qandil/app/di/register_dependencies.dart';
import 'package:qandil/app/router/app_router.dart';
import 'package:qandil/app/theme/app_colors.dart';
import 'package:qandil/core/config/app_config.dart';
import 'package:qandil/core/config/environment.dart';
import 'package:qandil/core/database/app_database.dart';

void main() {
  setUp(() async {
    await getIt.reset();
    await registerDependencies(
      config: const AppConfig(
        appName: 'Qandil Widget Test',
        environment: Environment.development,
        apiBaseUrl: 'https://api.test.com',
        enableLogging: false,
      ),
      database: AppDatabase(NativeDatabase.memory()),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('Qandil Phase 1 Foundation Shell & RTL/Theme Tests', () {
    testWidgets(
        'defaults to Arabic (ar) with RTL directionality and renders 4 Home cards and 5 navigation tabs',
        (tester) async {
      await tester.pumpWidget(
        QandilApp(routerConfig: AppRouter.createRouter()),
      );
      await tester.pumpAndSettle();

      // Verify Arabic RTL directionality
      final scaffoldContext = tester.element(find.byType(NavigationBar));
      expect(Directionality.of(scaffoldContext), TextDirection.rtl);

      // Verify 5 bottom bar tabs in Arabic
      expect(find.text('الرئيسية'), findsOneWidget);
      expect(find.text('القرآن'), findsOneWidget);
      expect(find.text('الصلاة'), findsWidgets);
      expect(find.text('الأذكار'), findsOneWidget);
      expect(find.text('المزيد'), findsOneWidget);

      // Verify 4 Home placeholder cards (scrolling down if needed)
      expect(find.text('الصلاة القادمة'), findsOneWidget);
      expect(find.text('وِرد اليوم'), findsOneWidget);
      expect(find.text('التسبيح اليومي'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('آية اليوم'), 200);
      expect(find.text('آية اليوم'), findsOneWidget);

      // Unmount widget tree and pump zero-duration timer scheduled by Drift StreamQueryStore on cancel
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(Duration.zero);
    });

    testWidgets(
        'switches language to English (LTR) and toggles Dark/Light theme in Settings',
        (tester) async {
      await tester.pumpWidget(
        QandilApp(routerConfig: AppRouter.createRouter()),
      );
      await tester.pumpAndSettle();

      // Navigate to "المزيد" (More/Settings) tab
      await tester.tap(find.text('المزيد'));
      await tester.pumpAndSettle();

      expect(find.text('الإعدادات والمزيد'), findsOneWidget);

      // Switch language to English
      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();

      final navContext = tester.element(find.byType(NavigationBar));
      expect(Directionality.of(navContext), TextDirection.ltr);
      expect(find.text('Settings & More'), findsOneWidget);

      // Switch theme to Dark (Night #0F2A2E)
      await tester.tap(find.text('Dark (Night)'));
      await tester.pumpAndSettle();

      final darkTheme = Theme.of(tester.element(find.byType(NavigationBar)));
      expect(darkTheme.brightness, Brightness.dark);
      expect(darkTheme.scaffoldBackgroundColor, AppColors.night);

      // Switch theme to Light (Ivory #FBF6EA)
      await tester.tap(find.text('Light (Ivory)'));
      await tester.pumpAndSettle();

      final lightTheme = Theme.of(tester.element(find.byType(NavigationBar)));
      expect(lightTheme.brightness, Brightness.light);
      expect(lightTheme.scaffoldBackgroundColor, AppColors.ivory);

      // Scroll down to About & Credits and open it
      await tester.scrollUntilVisible(find.text('About & Credits'), 200);
      await tester.tap(find.text('About & Credits'));
      await tester.pumpAndSettle();

      expect(find.text('Content Integrity Pledge'), findsOneWidget);

      // Unmount widget tree and pump zero-duration timer scheduled by Drift StreamQueryStore on cancel
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(Duration.zero);
    });
  });
}
