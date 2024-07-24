import 'package:example_radio/screens/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'radio_provider.dart';
import 'screens/home_screen.dart';
import 'screens/radio_screen1.dart';
import 'screens/radio_screen2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBSnjVgyh8G9jEYlRxewQAQGgI2O0s_S94",
      authDomain: "exampleradioson.firebaseapp.com",
      projectId: "exampleradioson",
      storageBucket: "exampleradioson.appspot.com",
      messagingSenderId: "408577952902",
      appId: "1:408577952902:web:951857909ff958d9185507",
      measurementId: "G-6WV9LF2NDB",
    ),
  );

  if (await Permission.notification.request().isGranted) {
    AwesomeNotifications().initialize(
      null,
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

  NotificationService.initialize(); //

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
