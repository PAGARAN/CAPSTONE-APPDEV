import 'package:flutter/material.dart';
// import './Pages/welcomingPage.dart';
import './Pages/Dashboard.dart';
import './Pages/Diagnoses.dart';
import './Pages/Results.dart';
import './Pages/Scan.dart';

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
      home: Scan(),
      routes: {
        '/dashboard': (context) => Dashboard(),
        '/diagnoses': (context) => Diagnoses(),
        '/results': (context) => Results(),
        '/scan': (context) => Scan(),
      },
    );
  }
}
