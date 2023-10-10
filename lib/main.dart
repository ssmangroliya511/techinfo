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
  await Firebase.initializeApp( options: const FirebaseOptions(
    apiKey: "AIzaSyD1C8QaEAxv9QJIm2DDF9N3_b3UZv5o",
    appId: "1:270790104828:web:1da6b11a4729a7d79729",
    messagingSenderId: "2707901048",
    projectId: "todo-app-firebase-ce8", ), );
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
                  height:50,width:70,
                  decoration:BoxDecoration(
                      color:Colors.white, borderRadius:BorderRadius.circular(10)
                  ),
                  alignment: Alignment.center,
                  child: Text('Ti',style:GoogleFonts.pacifico(fontSize:35,color:Colors.blueAccent),))
          ),
          SizedBox(height:10),
          Expanded( child: Text("Tech Info",
                    style:GoogleFonts.ptSansCaption(fontSize:15,fontWeight:FontWeight.w600,color:Colors.white)
                   )
          ),
        ]),
        nextScreen: Var.UserMobile == null || Var.UserMobile == '' ? Login_Screen() : BottomHome_Screen()
    );
  }
}

