import 'package:example_radio/screens/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'radio_provider.dart';
import 'screens/home_screen.dart';
import 'screens/radio_screen1.dart';
import 'screens/radio_screen2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (await Permission.notification.request().isGranted) {
    AwesomeNotifications().initialize(
      null, // Bildirim ikonunu burada belirtin (null: default ikon kullan)
      [
        NotificationChannel(
          channelKey: 'radio_channel',
          channelName: 'Radio Notification',
          channelDescription: 'Bu kanal radyo bildirimleri için kullanılıyor',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
        ),
      ],
    );
  }

  NotificationService.initialize(); // Bildirim servislerini başlatın

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RadioProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
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
