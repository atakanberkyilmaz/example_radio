import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'radio_provider.dart';
import 'home_screen.dart';
import 'radio_screen1.dart';
import 'radio_screen2.dart';

void main() {
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
