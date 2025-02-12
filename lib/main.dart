import 'package:flutter/material.dart';
import './Pages/welcomingPage.dart';
import './Pages/Dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcoming Page',
      theme: ThemeData(),
      home: WelcomePage(),
      routes: {
        '/dashboard': (context) => Dashboard(),
      },
    );
  }
}
