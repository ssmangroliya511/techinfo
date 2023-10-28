// ignore_for_file: camel_case_types, prefer_const_constructors, deprecated_member_use, non_constant_identifier_names, unnecessary_string_interpolations, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, unnecessary_brace_in_string_interps, avoid_print, must_be_immutable

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:linkedin_clone/AUTH/LOGIN%20SCREEN/Login_Screen.dart';
import 'package:linkedin_clone/AUTH/VERIFY%20OTP/Verifyotp_Controller.dart';
import 'package:linkedin_clone/AUTH/Web_LoginScreen.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:pinput/pinput.dart';
import '../../STATIC CLS/Static_class.dart';

class Verifyotp_Screen extends StatefulWidget {
  String? otp;
  Verifyotp_Screen( this.otp, {Key? key}) : super(key: key);

  @override
  State<Verifyotp_Screen> createState() => _Verifyotp_ScreenState();
}

class _Verifyotp_ScreenState extends State<Verifyotp_Screen> {


  String? OTP = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OTP = widget.otp;
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
                              Text('O',style:GoogleFonts.ptSerifCaption(color:Colors.black,fontSize:35)),
                              Text('tp Verification',style:GoogleFonts.poppins(color:Colors.white,fontSize:28))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom:80,left:20,right:20),
                          child: Align( alignment:Alignment.center,
                            child: Text('Please enter 6 -digits otp number '
                                'and verify to continue an App', style:GoogleFonts.poppins(color:Colors.white,
                                    fontSize:14),textAlign: TextAlign.center),
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

                                Text("OTP VERIFICATION",style:GoogleFonts.roboto(
                                    fontSize:20,color:Colors.blue,letterSpacing:0.5,fontWeight:FontWeight.w500
                                )),
                                SizedBox(height:50),

                                /// PINPUT TEXT FIELD ............................
                                Obx(() {
                                  return SizedBox(
                                    height:50,width:Get.width/2+110,
                                    child: Pinput(
                                      controller:getxController.verifyOtpController.votp.value,
                                      defaultPinTheme: PinTheme(
                                          decoration:BoxDecoration(color:Colors.grey.shade300,
                                              borderRadius:BorderRadius.circular(7)
                                          )
                                      ),
                                      focusedPinTheme: PinTheme(
                                          decoration:BoxDecoration(color:Colors.grey.shade300,
                                              borderRadius:BorderRadius.circular(7),
                                              border: Border.all(color:Colors.blueAccent,width:0.7)
                                          )
                                      ),
                                      submittedPinTheme: PinTheme(
                                          decoration:BoxDecoration(color:Colors.blue.shade50,
                                              borderRadius:BorderRadius.circular(7),
                                              border: Border.all(color:Colors.black,width:0.7)
                                          )
                                      ),
                                      closeKeyboardWhenCompleted:true,
                                        length:OTP != null ? OTP!.length : 6,
                                      onChanged: (value) {
                                        value = getxController.verifyOtpController.votp.value.text;
                                      },
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      keyboardType:TextInputType.number,
                                    ),
                                  );
                                }),
                                SizedBox(height:30),

                                OTP != null ? Container(
                                  height:20,alignment: Alignment.center,
                                  margin: EdgeInsets.only(bottom:25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Your OTP is  - \t',style:GoogleFonts.roboto(color:Colors.black54,fontSize:12.5)),
                                      Text('${OTP}', style:GoogleFonts.roboto(color:Colors.orange.shade700,
                                              fontSize:13,fontWeight: FontWeight.w600,height:1.5,letterSpacing:0.5)
                                      ),

                                    ],
                                  )
                                ) : SizedBox(),

                                /// VERIFY OTP BUTTON ........................
                                Obx((){

                                  return !getxController.verifyOtpController.isLoading.value ? SizedBox(
                                      width: Get.width/2+50,height: 40,
                                      child: MaterialButton(
                                          elevation:0,splashColor:Colors.black26,
                                          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          height:38,color:Colors.green,
                                          onPressed: () async {
                                            getxController.verifyOtpController.isLoading.value = true;

                                            if(getxController.verifyOtpController.votp.value.text.isEmpty)
                                            {
                                              getxController.verifyOtpController.isLoading.value = false;
                                              getDialogs('Error','OTP Can\'t be Empty !!',
                                                  Colors.white,Colors.red,Icons.error,
                                                  Colors.white,Duration(seconds:2)
                                              );
                                            } else
                                            {
                                              getxController.verifyOtpController.FetchVerifyOtpApi();
                                            }
                                          },
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Verify OTP &  𝐋𝐎𝐆𝐈𝐍',style:GoogleFonts.poppins(color:Colors.white,fontSize:13)),
                                              SizedBox(width:10),
                                              Icon(Iconsax.login,color:Colors.white,size:15)
                                            ],
                                          )
                                      )
                                  ) : CircularProgressIndicator(
                                    color:Colors.green,backgroundColor: Colors.white,strokeWidth:2.5,
                                  );
                                }),


                                GestureDetector(
                                  onTap: () async {
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) {
                                      return Login_Screen();
                                    },));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(top:20),
                                    child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(text: 'Occurred! ',
                                                style: GoogleFonts.poppins(fontSize:13.5,fontWeight:FontWeight.w400,color:Colors.red)
                                            ),
                                            TextSpan(text: 'back to login? ',
                                                style: GoogleFonts.poppins(fontSize:13.5,fontWeight:FontWeight.w400)
                                            ),
                                            TextSpan(
                                                text: ' Go Back',style: GoogleFonts.poppins(
                                                fontSize:13.5,fontWeight:FontWeight.w600,
                                                color:Colors.blueAccent,height:1.5),
                                            ),
                                          ],
                                        ),
                                    ),
                                  )
                                )
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
}




