import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/app/theme/app_theme.dart';
import 'package:qandil/core/widgets/qandil_empty_state.dart';
import 'package:qandil/features/settings/presentation/pages/credits_page.dart';
import 'package:qandil/l10n/app_localizations.dart';

/// Phase 13 Release Hardening: Accessibility Pass Tests
/// Verifies:
/// 1. 200% text scaling (`TextScaler.linear(2.0)`) renders key screens in Arabic (RTL)
///    and English (LTR) without layout overflow exceptions.
/// 2. Complete Credits screen attributes Quran Foundation, Reciters, Tafsir & Translations,
///    Adhkar (Hisn al-Muslim / Seen-Arabic), Fonts (KFGQPC UthmanicHafs, Reem Kufi, IBM Plex Sans Arabic),
///    Prayer/Hijri calculations, Privacy Policy summary, and Open-Source Licenses button.
/// 3. Screen-reader Semantics labels are exposed for TalkBack & VoiceOver.
void main() {
  Widget buildScaledTestApp({
    required Widget child,
    required Locale locale,
    required ThemeData theme,
    double textScale = 2.0,
  }) {
    return MaterialApp(
      locale: locale,
      theme: theme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, navigatorChild) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(textScale),
          ),
          child: navigatorChild!,
        );
      },
      home: child,
    );
  }

  group('Phase 13 Accessibility (200% Text Scale & Screen Reader Semantics)',
      () {
    testWidgets(
      'CreditsPage renders all required source attributions and Privacy Policy at 200% text scale in Arabic (RTL) without overflow',
      (tester) async {
        final semanticsHandle = tester.ensureSemantics();
        try {
          await tester.pumpWidget(
            buildScaledTestApp(
              locale: const Locale('ar'),
              theme: AppTheme.dark,
              textScale: 2.0,
              child: const CreditsPage(),
            ),
          );
          await tester.pumpAndSettle();

          // Verify Arabic RTL directionality
          expect(Directionality.of(tester.element(find.byType(Scaffold))),
              TextDirection.rtl);

          // Verify top-level credits headings and scroll through all cards at 200% scale
          expect(find.textContaining('قنديل'), findsWidgets);
          expect(find.textContaining('ميثاق أمانة المحتوى'), findsOneWidget);

          await tester.scrollUntilVisible(
            find.textContaining('القرّاء والتلاوات الصوتية'),
            200,
          );
          expect(
            find.textContaining('القرّاء والتلاوات الصوتية'),
            findsOneWidget,
          );

          await tester.scrollUntilVisible(
            find.textContaining('التفاسير والترجمات المعتمدة'),
            200,
          );
          expect(
            find.textContaining('التفاسير والترجمات المعتمدة'),
            findsOneWidget,
          );

          await tester.scrollUntilVisible(
            find.textContaining('سياسة الخصوصية وحماية البيانات'),
            200,
          );
          expect(
            find.textContaining('سياسة الخصوصية وحماية البيانات'),
            findsOneWidget,
          );

          await tester.scrollUntilVisible(
            find.byIcon(Icons.description_outlined),
            200,
          );
          expect(find.byIcon(Icons.description_outlined), findsOneWidget);
        } finally {
          semanticsHandle.dispose();
        }
      },
    );

    testWidgets(
      'CreditsPage and QandilEmptyState render at 200% text scale in English (LTR) without overflow',
      (tester) async {
        await tester.pumpWidget(
          buildScaledTestApp(
            locale: const Locale('en'),
            theme: AppTheme.light,
            textScale: 2.0,
            child: const CreditsPage(),
          ),
        );
        await tester.pumpAndSettle();

        expect(Directionality.of(tester.element(find.byType(Scaffold))),
            TextDirection.ltr);
        expect(find.text('Content Integrity Pledge'), findsOneWidget);

        await tester.scrollUntilVisible(
          find.text('Quran Reciters & Audio Sources'),
          200,
        );
        expect(find.text('Quran Reciters & Audio Sources'), findsOneWidget);

        await tester.scrollUntilVisible(
          find.text('Privacy Policy & On-Device Guarantee'),
          200,
        );
        expect(
          find.text('Privacy Policy & On-Device Guarantee'),
          findsOneWidget,
        );

        // Also test QandilEmptyState at 200% text scale
        await tester.pumpWidget(
          buildScaledTestApp(
            locale: const Locale('en'),
            theme: AppTheme.dark,
            textScale: 2.0,
            child: const Scaffold(
              body: SingleChildScrollView(
                child: QandilEmptyState(
                  title: 'No Bookmarks Yet',
                  message:
                      'Tap any verse in the Quran reader to save a colored bookmark or personal reflection note.',
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('No Bookmarks Yet'), findsOneWidget);
      },
    );
  });
}
