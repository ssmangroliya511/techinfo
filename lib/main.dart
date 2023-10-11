// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkedin_clone/SCREENS/BottomHome_Screen.dart';
import 'AUTH/Login_Screen.dart';
import 'STATIC CLS/Static_class.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

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

class MyApp extends StatelessWidget {const MyApp({super.key});

@override
Widget build(BuildContext context) {
  return GetMaterialApp(
    title: 'Tech Info',debugShowCheckedModeBanner:false,
    // home: Splash_Screen(),
    home: Login_Screen(),
  );
}
}
class Splash_Screen extends StatelessWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 170,
        backgroundColor: Colors.blueAccent.shade200,
        splashTransition: SplashTransition.fadeTransition,
        animationDuration:Duration(seconds:2),
        splash: Column(children: [
          SizedBox(height:20),
          Expanded(
              child: Container(
                  height:50,width:70,alignment: Alignment.center,
                  decoration:BoxDecoration(
                      color:Colors.white, borderRadius:BorderRadius.circular(10)
                  ),
                  child: Text('Ti',style:GoogleFonts.pacifico(
                      fontSize:35,color:Colors.blueAccent)))
          ),
          SizedBox(height:10),
          Expanded(child: Text("Tech Info",
              style:GoogleFonts.ptSansCaption(fontSize:15,
                  fontWeight:FontWeight.w600,color:Colors.white))
          ),
        ]),
        nextScreen: Var.UserMobile == null || Var.UserMobile == '' ? Login_Screen() : BottomHome_Screen()
    );
  }
}

