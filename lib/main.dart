import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:sherophopia/DoctorHome.dart';
import 'package:sherophopia/Tabs/searchTab.dart';
import 'package:sherophopia/login.dart';
import 'package:sherophopia/patientHome.dart';
import 'package:sherophopia/introductionScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sherophopia/signUp.dart';
import 'firebase_options.dart';


Future<void> main() async {
  // Show splash screen for 2 seconds
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(
    SizedBox(
      child: Image.asset(
        'assets/images/Splash_960.png',
        fit: BoxFit.cover,

      ),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Sherophopia',
      debugShowCheckedModeBanner: false,
      initialRoute: IntroductionScreen.routeName,
      routes: {
        IntroductionScreen.routeName:(context)=>IntroductionScreen(),
        Home.routeName:(context)=>Home(),
        DoctorHome.routeName:(context)=>DoctorHome(),
        SearchTab.routeName:(context)=>SearchTab(),
        SignUp.routeName:(context)=>SignUp(),
        LogIn.routeName:(context)=>LogIn()

      },

    );
  }

}
