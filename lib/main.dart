import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:sherophopia/home.dart';
import 'package:sherophopia/introductionScreen.dart';

Future<void> main() async {
  // Show splash screen for 2 seconds
  Gemini.init(apiKey: '--- Your Gemini Api Key ---');
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
        Home.routeName:(context)=>Home()
      },

    );
  }

}
