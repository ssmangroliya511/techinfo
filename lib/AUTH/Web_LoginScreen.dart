// ignore_for_file: prefer_const_constructors, camel_case_types

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../SCREENS/BottomHome_Screen.dart';
import '../STATIC CLS/Static_class.dart';
import 'LOGIN SCREEN/Login_Controller.dart';

class Web_LoginScreen extends StatefulWidget {
  const Web_LoginScreen({super.key});

  @override
  State<Web_LoginScreen> createState() => _Web_LoginScreenState();
}

class _Web_LoginScreenState extends State<Web_LoginScreen> {

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                                    Padding(
                                      padding: EdgeInsets.only(top:30,bottom:20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height:22,width:21,alignment: Alignment.center,
                                            padding: EdgeInsets.only(left:2),
                                            margin: EdgeInsets.only(right:1),
                                            decoration:BoxDecoration(color:Colors.blueAccent,borderRadius:BorderRadius.circular(3)),
                                            child:Text('T',style:GoogleFonts.pacifico(fontSize:16.5,height:1.5)),
                                          ),
                                          Text("ech Info", style: GoogleFonts.ptSansCaption(
                                              fontSize:16,color:Colors.blueAccent,fontWeight:FontWeight.w600,height:1.5)
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height:10),

                                    InkWell(
                                      onTap:() {
                                        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) {
                                          return BottomHome_Screen();
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
                                      controller:loginController.lmobile.value,
                                      cursorColor:Colors.black,
                                      style:GoogleFonts.roboto(fontSize:14),
                                      textInputAction:TextInputAction.done,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      maxLength:10,
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
                                          suffixIcon:loginController.lmobile.value.text.isNotEmpty ? IconButton(onPressed: (){
                                            setState(() {
                                              loginController.lmobile.value.text = '';
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

                                        if(loginController.lmobile.value.text.isEmpty)
                                        {
                                          Fluttertoast.showToast(msg:'Pls enter mobile number',
                                              backgroundColor:Colors.red,textColor:Colors.white,
                                              gravity: ToastGravity.CENTER
                                          );
                                        } else if(loginController.lmobile.value.text.length != 10){
                                          Fluttertoast.showToast(msg:'Invalid mobile number',
                                              backgroundColor:Colors.red,textColor:Colors.white
                                          );
                                        } else{
                                          setState(() {
                                            Var.isloading = true;
                                          });
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
                                        onChanged: (value) {

                                        },
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
                                        onPressed: () {

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
            return Stack(
              children: [

                Container(
                  height: Get.height,width:Get.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage('assets/myimgs/Login Page Img.jpg'),
                          fit: BoxFit.cover)),
                  child: BackdropFilter( filter: ImageFilter.blur(sigmaX:3, sigmaY:3),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    ),
                  ),
                ),

                Align(
                    alignment: Alignment.center, child: Text('Welcome To Tech Info . . .',
                    style: GoogleFonts.pacifico(color:Colors.white70,
                        fontSize:25,fontStyle: FontStyle.italic)
                )
                )
              ],
            );
          },
        )
    );
  }
}
