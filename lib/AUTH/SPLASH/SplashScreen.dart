// ignore_for_file: avoid_print

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkedin_clone/SCREENS/BottomHome_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../STATIC CLS/Static_class.dart';
import '../LOGIN SCREEN/Login_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences? prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpref();
  }

  Future<void> getpref() async {
    prefs = await SharedPreferences.getInstance();

    Userdata.UserId    = prefs?.getString('userid');
    Userdata.UserName  = prefs?.getString('userName');
    Userdata.UserEmail = prefs?.getString('userEmail');
    Userdata.UserPhone = prefs?.getString('userPhone');
    Userdata.UserImage = prefs?.getString('userImage');
    Userdata.UserState = prefs?.getString('userState');
    Userdata.UserCity  = prefs?.getString('userCity');

    Userdata.UserId == "" || Userdata.UserId == null ? "" :
    Get.offAll(const BottomHome_Screen());

    print('UserId    : ${Userdata.UserId}');
    print('UserName  : ${Userdata.UserName }');
    print('UserEmail : ${Userdata.UserEmail}');
    print('UserPhone : ${Userdata.UserPhone}');
    print('UserImage : ${Userdata.UserImage}');
    print('UserState : ${Userdata.UserState}');
    print('UserCity  : ${Userdata.UserCity }');
  }

  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(
        splashIconSize: 170,
        backgroundColor: Colors.blueAccent.shade200,
        splashTransition: SplashTransition.fadeTransition,
        animationDuration:const Duration(seconds:2),
        splash: Column(children: [
          const SizedBox(height:20),
          Expanded(
              child: Container(
                  height:50,width:70,alignment: Alignment.center,
                  decoration:BoxDecoration(
                      color:Colors.white, borderRadius:BorderRadius.circular(10)
                  ),
                  child: Text('Ti',style:GoogleFonts.pacifico(
                      fontSize:35,color:Colors.blueAccent)))
          ),
          const SizedBox(height:10),
          Expanded(child: Text("Tech Info",
              style:GoogleFonts.ptSansCaption(fontSize:15,
                  fontWeight:FontWeight.w600,color:Colors.white))
          ),
        ]),
        nextScreen: Userdata.UserPhone != null ? const BottomHome_Screen() : const Login_Screen()
    );
  }
}
