// ignore_for_file: camel_case_types, prefer_const_constructors, deprecated_member_use, non_constant_identifier_names, unnecessary_string_interpolations, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:linkedin_clone/SCREENS/Home_Screen.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SCREENS/BottomHome_Screen.dart';
import '../STATIC CLS/Static_class.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  bool isObsecure = true;
  bool isShowPinput = false;
  bool isReadOnly = false;
  bool isShowGenerateBtn = false;
  var countryCode = '+91';
  String verificationId = '';
  String otp = '';
  String authStatus = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fieldcontroller.lmobile.text = '';
  }

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

        child: !kIsWeb ? Scaffold(
          backgroundColor: Colors.blue.shade600,
          body: Center(
            child: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:130,left:20),
                    child: InkWell(
                        splashColor:Colors.transparent,highlightColor:Colors.transparent,
                        onLongPress:() {
                          Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) {
                            return BottomHome_Screen();
                          },));
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('W',style:GoogleFonts.ptSerifCaption(color:Colors.black,fontSize:35)),
                            Text('elcome',style:GoogleFonts.poppins(color:Colors.white,fontSize:28))
                          ],
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom:80,left:40),
                    child: Align( alignment:Alignment.center,
                      child: Text('To Your Account . . . ',
                        style:GoogleFonts.poppins(color:Colors.white70,fontSize:14)),
                    ),
                  ),

                 Container(
                    height:Get.height/2+20,
                    margin:EdgeInsets.only(top:30,left:15,right:15),
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

                        Widget_Mobile_TextField(),
                        SizedBox(height:30),

                        /// GENERATE OTP BUTTON ..............................
                        Fieldcontroller.lmobile.text.length == 10 || isShowGenerateBtn ?
                        MaterialButton(
                            elevation:0,splashColor:Colors.black26,
                            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(50)),
                            height:38,minWidth:Get.width/2+10,
                            color:Colors.blue,
                            onPressed: () async {
                              setState(() {
                                Var.isloading = true; isReadOnly = true;
                              });
                              Widget_OnPressed_GenerateBtn();
                            },
                            child: Text('Generate OTP',style:GoogleFonts.roboto(
                                color:Colors.white,fontSize:14))
                        ) :
                        Widget_DisableGenerate_Button(),
                        SizedBox(height:45),

                        /// PINPUT TEXTFIELD ............................
                        SizedBox(
                          height:50,width:Get.width/2+110,
                          child: Pinput(
                            defaultPinTheme: PinTheme(
                                decoration:BoxDecoration(color:Colors.grey.shade300,
                                  borderRadius:BorderRadius.circular(7)
                                )
                            ),
                            closeKeyboardWhenCompleted:true,
                            onChanged: (value) { otp = value; },
                            length:6,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            keyboardType:TextInputType.number,
                          ),
                        ),
                        SizedBox(height:30),


                        /// VERIFY OTP BUTTON ........................
                        isShowPinput ? MaterialButton(
                            elevation:0,splashColor:Colors.black26,
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            height:38,minWidth:Get.width/2+10,color:Colors.green,
                            onPressed: () async {
                              setState(() {
                                Var.isloading = true;
                              });
                              try{
                                setState(() {
                                  Var.isloading = false;
                                });
                                await FirebaseAuth.instance
                                    .signInWithCredential(PhoneAuthProvider.credential(
                                     verificationId: verificationId, smsCode: otp))
                                    .then((value) async {
                                     if(value.user != null){
                                       showDialog(
                                         barrierDismissible:false,
                                         context: context, builder: (context) {
                                         return Dialogs.LoginSuccessful_Dialog();
                                       },);

                                       SharedPreferences pref = await SharedPreferences.getInstance();
                                       pref.setString('userMobile',Fieldcontroller.lmobile.text);

                                       Future.delayed(Duration(seconds:4),() {
                                         return Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) {
                                           return BottomHome_Screen();
                                         }));
                                       },);
                                     }
                                });
                              } catch(e){
                                setState(() {
                                  Var.isloading = false;
                                });
                                Get.snackbar( '','',
                                    titleText: Text('Verification failed',
                                        style:GoogleFonts.ptSans(fontSize:15,color:Colors.blueAccent)),
                                    messageText:Text('Invalid OTP !!',
                                        style:GoogleFonts.roboto(fontSize:13,color:Colors.red)),
                                    icon:Icon(Iconsax.danger,color:Colors.red),borderRadius:15,
                                    backgroundColor: Colors.white,boxShadows: [BoxShadow(
                                      color:Colors.black,blurRadius:8,spreadRadius:-4,
                                    )]
                                );
                              }
                            },
                            child: Text('Verify OTP  &  𝐋𝐎𝐆𝐈𝐍',style:GoogleFonts.roboto(
                                color:Colors.white,fontSize:14)
                            )
                         )
                            : Widget_DisableVerify_Button()
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        )

        /// ============ FOR WEB ======================================= ///
            : Scaffold(
             backgroundColor: Colors.blueGrey.shade50,
             body: ResponsiveBuilder(
              builder: (BuildContext context, SizingInformation sizingInformation) {
                if(sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
                  return Center(
                    child: ScrollConfiguration(
                      behavior: ScrollBehavior(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex:4,child: Image.asset('assets/myimgs/Login Page Img.jpg',
                                    fit:BoxFit.cover,height:Get.height)
                              ),
                             Container(
                               height:Get.height,width:Get.width/3+40,
                               color:Colors.blueGrey.shade50,
                               padding:EdgeInsets.symmetric(vertical:130,horizontal:80),

                               child:Card(
                                 elevation:7,color:Colors.blueGrey,
                                 shape: RoundedRectangleBorder(
                                     borderRadius:BorderRadius.circular(20)
                                 ),
                                 child: Container(
                                   padding:EdgeInsets.only(left:20,right:20),
                                   decoration:BoxDecoration( color:Colors.white,
                                     borderRadius: BorderRadius.circular(20),
                                     // border: Border.all(color:Colors.blueGrey.shade700)
                                   ),
                                   child: Column(
                                     children: [

                                       Image.asset('assets/myimgs/Trading app logo.png',fit:BoxFit.contain,width:130),
                                       SizedBox(height:10),

                                       InkWell(
                                         onTap:() {
                                           Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) {
                                             return Home_Screen();
                                           },));
                                         },
                                         child: Text("USER LOGIN",style:GoogleFonts.roboto(
                                             fontSize:20,color:Colors.blueAccent.shade700,
                                             letterSpacing:0.5,fontWeight:FontWeight.w500
                                         )),
                                       ),
                                       SizedBox(height:50),

                                       TextField(
                                         onChanged: (value) { setState(() {}); },
                                         controller: Fieldcontroller.lmobile,
                                         cursorColor:Colors.black,
                                         style:GoogleFonts.roboto(fontSize:14),
                                         textInputAction:TextInputAction.done,
                                         keyboardType: TextInputType.phone,
                                         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                         maxLength:10,
                                         readOnly:isReadOnly ? true : false,
                                         decoration:InputDecoration(
                                             isDense: true,filled:true,
                                             fillColor:Colors.blueGrey.shade50,
                                             hintText:'Enter Mobile No.',counterText:'',
                                             constraints: BoxConstraints( maxHeight:45 ),
                                             hintStyle:GoogleFonts.roboto(fontSize:13,color:Colors.black45),
                                             enabledBorder: OutlineInputBorder(
                                                 borderRadius:BorderRadius.circular(5),
                                                 borderSide: BorderSide(color:Colors.blueGrey,)
                                             ),
                                             focusedBorder: OutlineInputBorder(
                                                 borderRadius:BorderRadius.circular(5),
                                                 borderSide: BorderSide(color:Colors.blueAccent.shade700)
                                             ),
                                             prefixIcon:Icon(Icons.call,color:Colors.blue),
                                             suffixIcon:Fieldcontroller.lmobile.text.isNotEmpty ? IconButton(onPressed: (){
                                               setState(() {
                                                 Fieldcontroller.lmobile.text = '';
                                               });
                                             }, icon: Icon(CupertinoIcons.delete,size:15,color:Colors.red)
                                             ) : null
                                         ),
                                       ),
                                       SizedBox(height:30),

                                       /// GENERATE OTP BUTTON ..............................
                                       MaterialButton(
                                         elevation:0,splashColor:Colors.black26,
                                         shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(50)),
                                         height:43,minWidth:Get.width/8,
                                         color:Colors.blueAccent.shade700,
                                         onPressed: () async {

                                           if(Fieldcontroller.lmobile.text.isEmpty)
                                           {
                                             Fluttertoast.showToast(msg:'Pls enter mobile number',
                                                 backgroundColor:Colors.red,textColor:Colors.white,
                                                 gravity: ToastGravity.CENTER
                                             );
                                           } else if(Fieldcontroller.lmobile.text.length != 10){
                                             Fluttertoast.showToast(msg:'Invalid mobile number',
                                                 backgroundColor:Colors.red,textColor:Colors.white
                                             );
                                           } else{
                                             setState(() {
                                               Var.isloading = true; isReadOnly = true;
                                             });
                                             Widget_OnPressed_GenerateBtn();
                                           }
                                         },
                                         child: Text('Generate OTP',style:GoogleFonts.roboto(
                                             color:Colors.white,fontSize:13)),
                                       ),
                                       SizedBox(height:55),

                                       /// PINPUT TEXTFIELD ............................
                                       SizedBox(
                                         height:50,width:Get.width/2+110,
                                         child: Pinput(
                                           defaultPinTheme: PinTheme(
                                               decoration:BoxDecoration(color:Colors.grey.shade300,
                                                   borderRadius:BorderRadius.circular(5),
                                                   border: Border.all(color:Colors.blueGrey)
                                               )
                                           ),
                                           closeKeyboardWhenCompleted:true,
                                           onChanged: (value) { otp = value; },
                                           length:6,
                                           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                           keyboardType:TextInputType.number,
                                         ),
                                       ),
                                       SizedBox(height:30),


                                       /// VERIFY OTP BUTTON ........................
                                       MaterialButton(
                                           elevation:0,splashColor:Colors.black26,
                                           shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(50)),
                                           height:43,minWidth:Get.width,
                                           color:Colors.green.shade700,
                                           onPressed: () async {
                                             setState(() {
                                               Var.isloading = true;
                                             });
                                             try{
                                               setState(() {
                                                 Var.isloading = false;
                                               });
                                               await FirebaseAuth.instance
                                                   .signInWithCredential(PhoneAuthProvider.credential(
                                                   verificationId: verificationId, smsCode: otp)).then((value) async {
                                                 if(value.user != null){
                                                   /// WEB LOGIN SUCCESS DIALOG....................................
                                                   showDialog(
                                                     barrierDismissible:false,
                                                     context: context, builder: (context) {
                                                     return  Container(
                                                       margin:EdgeInsets.symmetric(vertical:290,horizontal:550),
                                                       decoration:BoxDecoration(
                                                           color:Colors.white,borderRadius:BorderRadius.circular(10)
                                                       ),
                                                       child:Column(
                                                         children: [
                                                           Container(
                                                             height:Get.height/6-27,width:Get.width,
                                                             margin: EdgeInsets.only(bottom:15),
                                                             decoration:BoxDecoration( color:Colors.white,
                                                                 borderRadius:BorderRadius.vertical(top:Radius.circular(20))
                                                             ),
                                                             child:ClipRRect(
                                                                 child: Lottie.asset('assets/mylottie/Lottie Succes Dialog animation img.json')
                                                             ),
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
                                                   },
                                                   );

                                                   SharedPreferences pref = await SharedPreferences.getInstance();
                                                   pref.setString('userMobile',Fieldcontroller.lmobile.text);

                                                   Future.delayed(Duration(seconds:3),() {
                                                     return Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) {
                                                       return BottomHome_Screen();
                                                     }));
                                                   },);
                                                 }
                                               });
                                             } catch(e){
                                               setState(() {
                                                 Var.isloading = false;
                                               });
                                               Get.snackbar( '','',
                                                   titleText: Text('Verification failed',
                                                       style:GoogleFonts.ptSans(fontSize:15,color:Colors.blueAccent)),
                                                   messageText:Text('Invalid OTP !!',
                                                       style:GoogleFonts.roboto(fontSize:13,color:Colors.red)),
                                                   icon:Icon(Iconsax.danger,color:Colors.red),borderRadius:15,
                                                   backgroundColor: Colors.white,boxShadows: [BoxShadow(
                                                     color:Colors.black,blurRadius:8,spreadRadius:-4,
                                                   )]
                                               );
                                             }
                                           },
                                           child: Text('Verify OTP & Sign In',style:GoogleFonts.roboto(
                                               color:Colors.white,fontSize:13)
                                           )
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                             )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Container(color:Colors.purple);
              },
            )
        ),
      ),
    );
  }

  Widget_OnPressed_GenerateBtn() async {
    return await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryCode + Fieldcontroller.lmobile.text,
      timeout: Duration(seconds:60),
      verificationCompleted: (AuthCredential authCredential) {
        setState(() {
          authStatus = "Your account is successfully verified";
          Fluttertoast.showToast(
              msg: '$authStatus',gravity:ToastGravity.CENTER,backgroundColor:Colors.green,
              textColor: Colors.white
          );
          isShowPinput = true;
          Var.isloading = false;
          isReadOnly = true;
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        setState(() {
          authStatus = "Authentication failed";
          Fluttertoast.showToast(
              msg: '${authStatus} Try After 2 hour',gravity:ToastGravity.CENTER,
              backgroundColor:Colors.red,textColor: Colors.white
          );
          isShowPinput = false;
          Var.isloading = false;
          isReadOnly = true;
        });
      },
      codeSent: (verId, forceResendingToken) {
        verificationId = verId;
        setState(() {
          authStatus = "OTP has been successfully send";
          Fluttertoast.showToast(msg: '$authStatus',gravity:ToastGravity.CENTER);
          isShowPinput = true;
          Var.isloading = false;
          isReadOnly = true;
          isShowGenerateBtn = false;
        });
        // otpDialogBox(context).then((value) {});
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
          Fluttertoast.showToast(
              msg: '$authStatus',gravity:ToastGravity.CENTER,backgroundColor:Colors.red,
              textColor: Colors.white
          );
          Var.isloading = false;
          isReadOnly = false;
        });
      },
    );
  }

  Widget_DisableVerify_Button(){
    return MaterialButton(
        elevation:0,splashColor:Colors.transparent,highlightColor:Colors.transparent,highlightElevation:0,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        height:38,minWidth:Get.width/2+10,color:Colors.green.shade200,
        onPressed: () {},
        child: Text('Verify OTP  &  𝐋𝐎𝐆𝐈𝐍',style:GoogleFonts.roboto(color:Colors.white,fontSize:14))
    );
  }

  Widget_DisableGenerate_Button(){
    return MaterialButton(
        elevation:0,splashColor:Colors.black26,
        shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(50)),
        height:38,minWidth:Get.width/2+10,
        color:Colors.blue.shade200,
        onPressed: () {
          Fluttertoast.showToast(msg: Fieldcontroller.lmobile.text.isEmpty
              ? 'Pls enter mobile number' : 'Invalid mobile number',
              backgroundColor:Colors.red,textColor:Colors.white
          );
        },
        child: Text('Generate OTP',style:GoogleFonts.roboto(
            color:Colors.white,fontSize:14))
    );
  }

  Widget_Mobile_TextField(){
    return TextField(
      onChanged: (value) { setState(() {}); },
      controller: Fieldcontroller.lmobile,
      cursorColor:Colors.black,
      style:GoogleFonts.roboto(fontSize:14),
      textInputAction:TextInputAction.done,
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLength:10,
      readOnly:isReadOnly ? true : false,
      decoration:InputDecoration(
          isDense: true,filled:true,
          fillColor:Colors.grey.shade200,
          hintText:'Enter Mobile No.',counterText:'',
          constraints: BoxConstraints( maxHeight:45 ),
          hintStyle:GoogleFonts.roboto(fontSize:13,color:Colors.black45),
          enabledBorder: OutlineInputBorder(
            borderRadius:BorderRadius.circular(30),borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius:BorderRadius.circular(30),
              borderSide: BorderSide(color:Colors.white)
          ),
          prefixIcon:Icon(Icons.call,color:Colors.blue),
          suffixIcon:Fieldcontroller.lmobile.text.isNotEmpty ? IconButton(onPressed: (){
             setState(() {
               Fieldcontroller.lmobile.text = '';
             });
           }, icon: Icon(CupertinoIcons.clear,size:15,color:Colors.blue)
          ) : null
      ),
    );
  }

  Future<bool> _onbackPressed() async {
    return (await Dialogs.ExitApp_Dialog(context,setState)) ?? false;
  }
}




