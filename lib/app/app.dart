import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/settings/presentation/cubit/settings_cubit.dart';
import '../features/settings/presentation/cubit/settings_state.dart';
import '../l10n/app_localizations.dart';
import 'di/register_dependencies.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Root application widget configuring routing, themes, Arabic-first RTL localization,
/// dynamic text size scaling, and automatic notification rescheduling on app resume.
class QandilApp extends StatefulWidget {
  const QandilApp({
    super.key,
    this.routerConfig,
  });

  final GoRouter? routerConfig;

  @override
  State<QandilApp> createState() => _QandilAppState();
}

class _QandilAppState extends State<QandilApp> with WidgetsBindingObserver {
  late final SettingsCubit _settingsCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _settingsCubit = getIt<SettingsCubit>()..loadSettings();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _settingsCubit.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Reschedule 7-day rolling window on app resume (handles timezone or day boundary changes)
      _settingsCubit.rescheduleNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>.value(
      value: _settingsCubit,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final settings = state.settings;

          return MaterialApp.router(
            title: 'Qandil',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: settings.themeMode,
            locale: settings.locale,
            routerConfig: widget.routerConfig ?? AppRouter.router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
            ],
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              final effectiveScale = settings.textScaleFactor;
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: TextScaler.linear(effectiveScale),
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
