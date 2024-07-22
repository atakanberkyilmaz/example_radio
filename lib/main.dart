import 'package:example_radio/screens/home_screen.dart';
import 'package:example_radio/screens/radio_screen1.dart';
import 'package:example_radio/screens/radio_screen2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'radio_provider.dart';

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
