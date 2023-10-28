// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:linkedin_clone/AUTH/SPLASH/SplashScreen.dart';
import 'package:linkedin_clone/WEB%20SCREENS/Dashboard_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    /// FOR WEB UNCOMMIT THIS CODE ..............
    options: FirebaseOptions(
     apiKey: "AIzaSyDVSgUUTSzHsE7it6-hgUpfOUBH7Pe_I4g",
     appId: "1:870158300642:android:edfa8be02530c2051eb5bb",
     messagingSenderId: "870158300642",
     projectId: "tech-info-bdd56",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tech Info', debugShowCheckedModeBanner: false,
      home: kIsWeb ? Dashboard_Screen() : SplashScreen(),
    );
  }
}

