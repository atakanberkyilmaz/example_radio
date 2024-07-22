import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:example_radio/radio_provider.dart';
import 'package:example_radio/screens/home_screen.dart';
import 'package:example_radio/screens/radio_screen1.dart';
import 'package:example_radio/screens/radio_screen2.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (await Permission.notification.request().isGranted) {
    AwesomeNotifications().initialize(
      'resource://drawable/notification', // Bildirim ikonunu burada belirt res/drawable/...
      [
        NotificationChannel(
          channelKey: 'radio_channel',
          channelName: 'Radio Notification',
          channelDescription: 'Bu kanal radio bildirimleri için kullanılıyor',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
        ),
      ],
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RadioProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/radio1': (context) => RadioScreen1(),
          '/radio2': (context) => RadioScreen2(),
        },
      ),
    );
  }
}
