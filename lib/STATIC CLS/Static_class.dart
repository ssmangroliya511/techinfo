// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors, use_build_context_synchronously, constant_identifier_names, avoid_print, camel_case_types

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkedin_clone/AUTH/LOGIN%20SCREEN/Login_Controller.dart';
import 'package:linkedin_clone/AUTH/VERIFY%20OTP/Verifyotp_Controller.dart';
import 'package:linkedin_clone/HOME/Home_Controller.dart';
import 'package:linkedin_clone/MY%20PROFILE/DeletePost_Controller.dart';
import 'package:linkedin_clone/MY%20PROFILE/DeleteUser_Controller.dart';
import 'package:linkedin_clone/MY%20PROFILE/MyPosts_Controller.dart';
import 'package:linkedin_clone/MY%20PROFILE/MyProfile_Controller.dart';
import 'package:linkedin_clone/UPDATE%20PROFILE/UpdateProfile_Controller.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AUTH/LOGIN SCREEN/Login_Screen.dart';
import '../MY PROFILE/UpdatePost_Controller.dart';
import '../POSTS/AddPost_Controller.dart';


class Urls{
    static const baseurl = 'https://techinfo.bitinfotechnology.com/api/';
    static const mainurl = 'https://techinfo.bitinfotechnology.com/';
}

class Constants{
    static const LOGIN       =    'login';
    static const VERIFY      =    'verify_Otp';
    static const MYPOSTS     =    'my_post';
    static const UPDATEPROF  =    'update_profile';
    static const ADDPOSTS    =    'add_post';
    static const ALLPOSTS    =    'all_post';
    static const DELETEPOST  =    'deletePost';
}


class Var {
  static var AppVersion;
  static var selectedIndex = 0;
  static bool isloading = false;
  static bool isGuestUser = false;
  static final dio = Dio();
  static final ImagePicker imagePicker = ImagePicker();
  static File? Updateimg_file;
  static File? AddPost_ImgFile;
  static File? AddPost_VideoFile;
  static var AddPostImage;
  static var AddPostVideo;
  static var editedImage;
  static var permissionGranted;
  static var postId;
  static var postDescription;
  static var postTitle;
  static var postSourse;
}

class getxController{
  static var loginController          = Get.put(LoginController());
  static var verifyOtpController      = Get.put(VerifyOtpController());
  static var myProfileController      = Get.put(MyProfileController());
  static var updateProfileController  = Get.put(UpdateProfileController());
  static var homeController           = Get.put(HomeController());
  static var deletePostController     = Get.put(DeletePostController());
  static var addPostController        = Get.put(AddPostController());
  static var myPostController         = Get.put(MyPostController());
  static var deleteUserController     = Get.put(DeleteUserController());
  static var updatePostController     = Get.put(UpdatePostController());
}

class Userdata{
  static var UserId;
  static var UserName;
  static var UserEmail;
  static var UserPhone;
  static var UserImage;
  static var UserState;
  static var UserCity ;
}

class Utils{
  static var scaffoldColor    = Colors.grey.shade100;
  static var posttitleColor   = Colors.blueGrey.shade500;
  static var appColor         = Colors.blueAccent.shade400;

  static var posttitleStyle   = GoogleFonts.poppins(
                                   fontSize:13,color:Utils.posttitleColor,
                                   fontWeight: FontWeight.w500
                                );

  static var postDescripStyle  = GoogleFonts.ptSansCaption(fontSize:13,color:Colors.black);
}


getDialogs(title,message,textColor,bgColor,icon,iconColor,durationTime){
  return Get.snackbar(
      title, message,
      backgroundColor: bgColor,
      colorText:textColor,
      margin: const EdgeInsets.symmetric(vertical:10,horizontal:10),
      icon: Icon(icon,color:iconColor,size:20),
      duration:durationTime
  );
}

class Fieldcontroller{

  static TextEditingController hsearch    =  TextEditingController();
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

  static Logout_Dialog(BuildContext context,setState){
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
          content:  Text('Are You sure Want to Logged Out your account ??',
              style: GoogleFonts.ptSans(fontSize:15)),
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

                  prefs.remove('userid');
                  prefs.remove('userName');
                  prefs.remove('userEmail');
                  prefs.remove('userPhone');
                  prefs.remove('userImage');
                  prefs.remove('userState');
                  prefs.remove('userCity');

                  prefs.remove('guestName');

                  getxController.loginController.lmobile.value.clear();
                  getxController.verifyOtpController.votp.value.clear();
                  print('Account Logged Out....');

                  Fluttertoast.showToast(msg: 'Logout Successful',
                      backgroundColor:Colors.white,textColor:Colors.blue,gravity:ToastGravity.TOP
                  );

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
