import 'package:flutter/widgets.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'app/app.dart';
import 'app/di/register_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.mmazin.qandil.channel.audio',
      androidNotificationChannelName: 'Qandil Quran Recitation',
      androidNotificationOngoing: true,
    );
  } catch (_) {
    // Allow boot to continue safely in desktop/test harnesses where background audio service is not supported.
  }
  await registerDependencies();
  runApp(const QandilApp());
}
