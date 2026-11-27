import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/app/theme/app_theme.dart';
import 'package:qandil/core/widgets/qandil_empty_state.dart';
import 'package:qandil/core/widgets/qandil_logo.dart';
import 'package:qandil/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:qandil/l10n/app_localizations.dart';

void main() {
  group('Phase 10: OnboardingPage, QandilLogo & QandilEmptyState Widget Tests',
      () {
    testWidgets(
        'renders 3-screen Onboarding (Read, Listen, Keep your daily wird) with Qandil wordmark and tagline',
        (tester) async {
      var finished = false;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: OnboardingPage(
            onFinished: () {
              finished = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify wordmark (قنديل) and tagline (نورٌ يرافق يومك.)
      expect(find.text('قنديل'), findsOneWidget);
      expect(find.text('نورٌ يرافق يومك.'), findsOneWidget);

      // Slide 1: Read (اقرأ بتدبّر وسكينة)
      expect(find.text('اقرأ بتدبّر وسكينة'), findsOneWidget);
      expect(find.text('التالي'), findsOneWidget);

      // Advance to Slide 2: Listen (استمع لكبار القرّاء)
      await tester.tap(find.text('التالي'));
      await tester.pumpAndSettle();
      expect(find.text('استمع لكبار القرّاء'), findsOneWidget);

      // Advance to Slide 3: Keep your daily wird (واظب على وردك اليومي)
      await tester.tap(find.text('التالي'));
      await tester.pumpAndSettle();
      expect(find.text('واظب على وردك اليومي'), findsOneWidget);
      expect(find.text('ابدأ مع قنديل'), findsOneWidget);

      // Finish onboarding
      await tester.tap(find.text('ابدأ مع قنديل'));
      await tester.pumpAndSettle();
      expect(finished, isTrue);
    });

    testWidgets('renders QandilEmptyState with Rub el Hizb ornament',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(
            body: QandilEmptyState(
              title: 'No items yet',
              message: 'Your saved items will appear here.',
            ),
          ),
        ),
      );

      expect(find.byType(QandilRubElHizbOrnament), findsOneWidget);
      expect(find.text('No items yet'), findsOneWidget);
      expect(find.text('Your saved items will appear here.'), findsOneWidget);
    });
  });
}
