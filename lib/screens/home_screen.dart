import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/radio1');
              },
              child: Text('Go to Radio 1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/radio2');
              },
              child: Text('Go to Radio 2'),
            ),
          ],
        ),
      ),
    );
  }
}
