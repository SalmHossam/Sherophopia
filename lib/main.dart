import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:sherophopia/DoctorHome.dart';
import 'package:sherophopia/DoctorTabs/createComunity.dart';
import 'package:sherophopia/DoctorTabs/manageRequestScreen.dart';
import 'package:sherophopia/Tabs/aboutTab.dart';
import 'package:sherophopia/Tabs/contactTab.dart';
import 'package:sherophopia/Tabs/joinComunity.dart';
import 'package:sherophopia/Tabs/searchTab.dart';
import 'package:sherophopia/login.dart';
import 'package:sherophopia/patientHome.dart';
import 'package:sherophopia/introductionScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sherophopia/signUp.dart';
import 'firebase_options.dart';

/// Define App ID and Token
const APP_ID = '<Your App ID>';
const Token = '<Your Token>';

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
        LogIn.routeName:(context)=>LogIn(),
        ContactUsPage.routeName:(Context)=>ContactUsPage(),
        AboutUsPage.routeName:(Context)=>AboutUsPage(),
        JoinCommunityScreen.routeName :(context)=>JoinCommunityScreen(initialText: '',),
        CreateCommunityScreen.routeName:(context)=>CreateCommunityScreen(),
        ManageRequestsScreen.routeName:(context)=>ManageRequestsScreen()

      },

    );
  }
}
