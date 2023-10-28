// ignore_for_file: camel_case_types, prefer_const_constructors, deprecated_member_use, non_constant_identifier_names, unnecessary_string_interpolations, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, unnecessary_brace_in_string_interps, avoid_print

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:linkedin_clone/AUTH/Web_LoginScreen.dart';
import 'package:linkedin_clone/SCREENS/BottomHome_Screen.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../STATIC CLS/Static_class.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onbackPressed();
      },
      child: OverlayLoaderWithAppIcon(
        isLoading:Var.isloading,
        overlayBackgroundColor: Colors.black,
        circularProgressColor: Colors.blueAccent,
        appIcon: Icon(Bootstrap.send,size:18,color:Colors.black),

        /// =================== FOR MOBILE SCREEN ======================= ///
        child: !kIsWeb ?
        Scaffold(
            backgroundColor: Colors.blue.shade600,
            body: Center(
              child: ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top:130,left:7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('W',style:GoogleFonts.ptSerifCaption(color:Colors.black,fontSize:35)),
                          Text('elcome',style:GoogleFonts.poppins(color:Colors.white,fontSize:28))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom:80,left:20,right:20),
                      child: Align( alignment:Alignment.center,
                        child: Text('Please enter mobile number and verify to continue an App',
                            style:GoogleFonts.poppins(color:Colors.white,fontSize:14),textAlign: TextAlign.center),
                      ),
                    ),

                    Container(
                      height:Get.height/2+20,
                      margin:EdgeInsets.only(top:37,left:10,right:10),
                      padding:EdgeInsets.all(10),
                      decoration:BoxDecoration(
                        color:Colors.white,borderRadius:BorderRadius.circular(15),
                      ),
                      child:Column(
                        children: [
                          SizedBox(height:10),

                          Text("USER LOGIN",style:GoogleFonts.roboto(
                              fontSize:20,color:Colors.blue,letterSpacing:0.5,fontWeight:FontWeight.w500
                          )),
                          SizedBox(height:50),

                          /// OTP TEXT-FIELD..............................
                          Obx((){
                           return TextField(
                            controller:getxController.loginController.lmobile.value,
                            cursorColor:Colors.black,
                            style:GoogleFonts.roboto(fontSize:14),
                            textInputAction:TextInputAction.done,
                            keyboardType: TextInputType.phone, maxLength:10,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration:InputDecoration(
                                isDense: true,filled:true, fillColor:Colors.grey.shade200,
                                hintText:'Enter Mobile No.',counterText:'',
                                hintStyle:GoogleFonts.roboto(fontSize:13,color:Colors.black45),
                                constraints: BoxConstraints( maxHeight:43,maxWidth:Get.width/1-60),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:BorderRadius.circular(30),borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:BorderRadius.circular(30),
                                    borderSide: BorderSide(color:Colors.black,width:0.5)
                                ),
                                prefixIcon:Icon(Icons.call,color:Colors.blue),
                                suffixIcon: getxController.loginController.lmobile.value.text.isNotEmpty ?
                                  IconButton(onPressed: (){
                                    getxController.loginController.lmobile.value.text = '';
                                  }, icon:Icon(CupertinoIcons.clear,size:15,color:Colors.blue)
                                ) : null
                            ),
                          );
                        }),
                        SizedBox(height:30),

                          /// GENERATE OTP BUTTON ..............................
                          Obx((){
                            return !getxController.loginController.isLoading.value ?
                            SizedBox(
                              width: Get.width/2+50,height:40,
                              child: MaterialButton(
                                  elevation:0,splashColor:Colors.black26,
                                  shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(50)),
                                  height:38,color:Colors.blue,
                                  onPressed: (){
                                    getxController.loginController.isLoading.value = true;

                                    if(getxController.loginController.lmobile.value.text.isEmpty)
                                    {
                                      getxController.loginController.isLoading.value = false;
                                      getDialogs(
                                          'Empty Error','Mobile number can\'t be empty !',
                                           Colors.white,Colors.red,Icons.error,Colors.white,const Duration(seconds:2)
                                      );

                                    }else if(getxController.loginController.lmobile.value.text.length < 10)
                                    {
                                      getxController.loginController.isLoading.value = false;

                                      getDialogs(
                                          'Error','Invalid Mobile number !',
                                           Colors.white,Colors.red,Icons.error,Colors.white,const Duration(seconds:2)
                                      );

                                    }else{
                                      getxController.loginController.FetchSendOtpApi();
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Send OTP',style:GoogleFonts.poppins(color:Colors.white,fontSize:14)),
                                      SizedBox(width:10),
                                      Icon(Bootstrap.send,color:Colors.white,size:14)
                                    ],
                                  )
                              )
                            ) : SizedBox(
                              height:30,width:30,
                              child: CircularProgressIndicator(
                                color: Colors.blueAccent.shade700,strokeWidth:2,
                              ),
                            );
                          }),
                          SizedBox(height: 20),

                          GestureDetector(
                            onTap: () async {
                              Var.isGuestUser = true;
                              Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) {
                                return BottomHome_Screen();
                              },));
                              Fluttertoast.showToast(msg: 'Sign in As a Guest',gravity:ToastGravity.CENTER);

                              SharedPreferences  prefs = await SharedPreferences.getInstance();

                              prefs.setString('guestName', 'Guest');
                              Userdata.UserName = prefs.getString('guestName');
                              setState(() {});

                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'Sign in as a Guest? ',
                                      style: GoogleFonts.poppins(fontSize:13.5,fontWeight:FontWeight.w400)
                                  ),
                                  TextSpan(
                                    // recognizer:SignUp_Onpressed,
                                     text: ' Go',style: GoogleFonts.poppins(
                                     fontSize:13.5,fontWeight:FontWeight.w600,color:Colors.blueAccent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                      ),
                    )
                  ],
                ),
              ),
            )
        ) :
        /// ===================== FOR WEB SCREEN ========================= ///
        Web_LoginScreen()
      )
    );
  }

  Future<bool> _onbackPressed() async {
    return (await Dialogs.ExitApp_Dialog(context,setState)) ?? false;
  }


  // final SignUp_Onpressed = TapGestureRecognizer()
  //   ..onTap = () {
  //     Get.offAll(Home_Screen());
  //   };
}




