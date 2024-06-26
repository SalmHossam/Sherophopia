import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:sherophopia/Tabs/searchTab.dart';
import 'package:sherophopia/patientHome.dart';
import 'package:sherophopia/introductionScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  // Show splash screen for 2 seconds
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        SearchTab.routeName:(context)=>SearchTab()

      },

    );
  }

}
