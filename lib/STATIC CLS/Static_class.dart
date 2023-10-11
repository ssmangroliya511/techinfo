// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AUTH/Login_Screen.dart';

class Var {
  static var AppVersion;
  static var selectedIndex = 0;
  static bool isloading = false;

  static var UserMobile;
}


class Fieldcontroller{

  static TextEditingController hsearch            =  TextEditingController();
  static TextEditingController pdescription       =  TextEditingController();
  static TextEditingController pshortdescription  =  TextEditingController();
  static TextEditingController pattachlink        =  TextEditingController();


  /// Login Textfield Controllers ...................
  static TextEditingController lmobile            =  TextEditingController();
  static TextEditingController lpinputverify      =  TextEditingController();


  /// Update Profile Textfield Controllers ...................
  static TextEditingController uname              =  TextEditingController();
  static TextEditingController uemailid           =  TextEditingController();
  static TextEditingController ustate             =  TextEditingController();
  static TextEditingController ucity              =  TextEditingController();

}


class Dialogs{

  static ExitApp_Dialog(BuildContext context,setState){
    return  showDialog(
      barrierDismissible: false,
      context: context, builder: (context) =>
        AlertDialog(
          shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
          titlePadding:  EdgeInsets.only(left:15,right: 10,top:10,bottom:2),
          contentPadding:EdgeInsets.only(left:15,right: 10,top:10,bottom:5),
          actionsPadding:EdgeInsets.only(left:15,right: 10,top:15),

          title: Row(children: [
            Icon(IonIcons.exit_sharp,color:Colors.red,size:23),
            Text('\tExit App',style:GoogleFonts.ptSansCaption(color:Colors.red,fontSize:16.5))
          ]),
          content:  Text('Are You sure Want to Exit an App ??',style: GoogleFonts.ptSans(fontSize:15)),
          actions: <Widget>[

            MaterialButton(
                elevation: 0,splashColor: Colors.transparent,hoverElevation:0,highlightElevation:0,
                highlightColor:Colors.transparent,hoverColor:Colors.transparent,
                shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
                color: Colors.white,minWidth:70,
                child: Text('NO',style:GoogleFonts.ptSans(fontSize:14,color:Colors.blueAccent)),
                onPressed:() {
                  setState(() {
                    Var.isloading = false;
                  });
                  Navigator.of(context).pop(false);
                },
            ),

            MaterialButton(
                elevation: 0,splashColor: Colors.transparent,hoverElevation:0,highlightElevation:0,
                highlightColor:Colors.transparent,hoverColor:Colors.transparent,
                shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
                color: Colors.white,minWidth:70,
                child: Text('CONFIRM',style:GoogleFonts.ptSans(fontSize:14,color:Colors.red)),
                onPressed:() {
                  setState(() {
                    Var.isloading = false;
                  });
                  exit(0);
                },
            ),
          ],
        ),
     );
  }

  static Logout_Dialog(BuildContext context){
    return  showDialog(
      barrierDismissible: false,
      context: context, builder: (context) =>
        AlertDialog(
          shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
          titlePadding:  EdgeInsets.only(left:15,right: 10,top:10,bottom:2),
          contentPadding:EdgeInsets.only(left:15,right: 10,top:10,bottom:5),
          actionsPadding:EdgeInsets.only(left:15,right: 10,top:15),

          title: Row(children: [
            Icon(IonIcons.log_out,color:Colors.red,size:23),
            Text('\tLogout',style:GoogleFonts.ptSansCaption(color:Colors.red,fontSize:16.5))
          ]),
          content:  Text('Are You sure Want to Logged Out your account ??',style: GoogleFonts.ptSans(fontSize:15)),
          actions: <Widget>[

            MaterialButton(
                elevation: 0,splashColor: Colors.transparent,hoverElevation:0,highlightElevation:0,
                highlightColor:Colors.transparent,hoverColor:Colors.transparent,
                shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
                color: Colors.white,minWidth:70,
                child: Text('DISCARD',style:GoogleFonts.ptSans(fontSize:14,color:Colors.blueAccent)),
                onPressed: () => Navigator.of(context).pop(false)
            ),

            MaterialButton(
                elevation: 0,splashColor: Colors.transparent,hoverElevation:0,highlightElevation:0,
                highlightColor:Colors.transparent,hoverColor:Colors.transparent,
                shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
                color: Colors.white,minWidth:70,
                child: Text('LOGOUT',style:GoogleFonts.ptSans(fontSize:14,color:Colors.red)),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('userMobile');

                  Fluttertoast.showToast(msg: 'Logout Successful',
                      backgroundColor:Colors.white,textColor:Colors.blue,gravity:ToastGravity.TOP
                  );
                  FirebaseAuth.instance.signOut();

                  Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) {
                    return Login_Screen();
                  },));
                },
            ),
          ],
        ),
     );
  }


  static LoginSuccessful_Dialog(){
     return  Container(
       margin:EdgeInsets.symmetric(vertical:280,horizontal:30),
       decoration:BoxDecoration(
           color:Colors.white,borderRadius:BorderRadius.circular(10)
       ),
       child:Column(
         children: [
           Container(
             height:Get.height/6-27,width:Get.width,
             margin: EdgeInsets.only(bottom:15),
             decoration:BoxDecoration( color:Colors.green,
                 borderRadius:BorderRadius.vertical(top:Radius.circular(10))
             ),
             child:Lottie.asset('assets/mylottie/Lottie Succes Dialog animation img.json'),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('User Verified \t',style:GoogleFonts.roboto(
                   fontSize:17.5,color:Colors.lightBlue,fontWeight:FontWeight.normal,
                   decoration:TextDecoration.none)
               ),
               Icon(Icons.verified,color:Colors.lightBlue,size:20)
             ],
           ),
           SizedBox(height:10),
           Text('Login Completed Successfully !!',style:GoogleFonts.ptSans(
               fontSize:15.5,color:Colors.black,fontWeight:FontWeight.normal,
               decoration:TextDecoration.none)
           )
         ],
       ),
     );
  }
}