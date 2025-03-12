import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import './Pages/welcomingPage.dart';
import './Pages/Dashboard.dart';
import './Pages/Results.dart';
import './Pages/Diagnoses.dart';
import './Pages/Scan.dart';
import './Pages/AboutPage.dart';
import './Pages/Language.dart';
import './utils/global_materialization.dart' as custom_local;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('tl'),
        Locale('ceb'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        ...context.localizationDelegates,
        custom_local.GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Corn Disease Detection',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WelcomePage(),
      routes: {
        '/dashboard': (context) => const Dashboard(),
        '/diagnoses': (context) => const Diagnoses(),
        '/scan': (context) => const Scan(),
        '/about': (context) => const AboutPage(),
        '/language': (context) => const Language(),
      },
    );
  }
}


