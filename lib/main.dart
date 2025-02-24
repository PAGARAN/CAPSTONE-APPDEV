import 'package:flutter/material.dart';
import './Pages/welcomingPage.dart';
import './Pages/Dashboard.dart';
import './Pages/Diagnoses.dart';
import './Pages/Results.dart';
import './Pages/Scan.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcoming Page',
      theme: ThemeData(),
      home: WelcomePage(),
      routes: {
        '/dashboard': (context) => Dashboard(),
        '/diagnoses': (context) => const Diagnoses(),
        '/results': (context) => const Results(
              disease: 'Rust',
              date: 'Just now',
            ),
        '/scan': (context) => const Scan(),
      },
    );
  }
}
