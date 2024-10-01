import 'package:emcall/onboarding_screen.dart';
import 'package:emcall/web/agencies/web_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDcyhD8zYwcN5XnD-5sD4bOJb_-J2jlQxQ",
          authDomain: "emcall-53167.firebaseapp.com",
          projectId: "emcall-53167",
          storageBucket: "emcall-53167.appspot.com",
          messagingSenderId: "1061298560199",
          appId: "1:1061298560199:web:1d4bce8ce309fdfdea72e2",
          measurementId: "G-C43PKLGGZH"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const OnboardingApp());
}

class OnboardingApp extends StatelessWidget {
  const OnboardingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: kIsWeb ? const WebHomePage() : const OnboardingScreen(),
    );
  }
}
