// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkedin_clone/AUTH/LOGIN%20SCREEN/Login_Controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../SCREENS/BottomHome_Screen.dart';
import '../../STATIC CLS/Static_class.dart';
import 'Verifyotp_Model.dart';

class VerifyOtpController extends GetxController{

  LoginController loginController = Get.put(LoginController());

  final votp = TextEditingController().obs;
  var verifyotpModel = VerifyOtp_Model().obs;
  RxBool isLoading = false.obs;

  FetchVerifyOtpApi() async {
    isLoading.value = true;
    final response;
    try{
      response = await Var.dio.post(Urls.baseurl + Constants.VERIFY,
          data:{
            'Mobile'   : loginController.lmobile.value.text,
            'Otp'      : votp.value.text,
          });
          verifyotpModel.value = VerifyOtp_Model.fromJson(response.data);

      if (response.statusCode == 200 && verifyotpModel.value.code == 200) {
        isLoading.value = false;

        getDialogs(
            'Success','Login Successfully Done',
             Colors.white,Colors.green,Icons.check_circle_rounded,
             Colors.white,const Duration(seconds:2)
        );
        print('Login Success ${verifyotpModel.value.message.toString()}');
        SaveDataInPrefs();

        Get.offAll(const BottomHome_Screen());
      }
      else{
        isLoading.value = false;
        getDialogs(
             'Error',verifyotpModel.value.message.toString(),
              Colors.white,Colors.red,Icons.error,
              Colors.red,const Duration(seconds:2)
        );
        print('Error : ${verifyotpModel.value.message.toString()}');
      }
      return response.statusCode;

    }on DioException catch (e){
      if(e.response?.statusCode == 404){
        isLoading.value = false;
        print('Status Code ${e.response?.statusCode} : Invalid url or Incorrect Url !');
        getDialogs(
            '404 Error','Invalid url or Incorrect Url !',
            Colors.red,Colors.white,Icons.error,Colors.red,const Duration(seconds:2)
        );
      }
      else if (e.response!.statusCode == 400){
        isLoading.value = false;
        print('Status Code ${e.response!.statusCode} : Invalid request !');
        getDialogs(
            '400 Error','Invalid request !',
            Colors.red,Colors.white,Icons.error,Colors.red,const Duration(seconds:2)
        );
      }
      else if (e.response!.statusCode == 409){
        isLoading.value = false;
        print('Status Code ${e.response!.statusCode} : Conflict occurred !');
        getDialogs(
            '409 Error','Conflict occurred !',
            Colors.red,Colors.white,Icons.error,Colors.red,const Duration(seconds:2)
        );
      }
      else if (e.response!.statusCode == 500){
        isLoading.value = false;
        print('Status Code ${e.response!.statusCode} : Internal server error occurred, please try again later !');
        getDialogs(''
            '500 Error','Internal server error occurred, please try again later !',
            Colors.red,Colors.white,Icons.error,Colors.red,const Duration(seconds:2)
        );
      }
      else{
        isLoading.value = false;
        print('Status Code ${e.response!.statusCode} : Something went wrong !');
        getDialogs(''
            'Error','Something went wrong !',
            Colors.red,Colors.white,Icons.error,Colors.red,const Duration(seconds:2)
        );
      }
      isLoading.value = false;
      return e.response;
    }
  }


  SaveDataInPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userid    = verifyotpModel.value.business!.userId.toString();
    var username  = verifyotpModel.value.business!.uname.toString();
    var useremail = verifyotpModel.value.business!.email.toString();
    var userphone = verifyotpModel.value.business!.mob.toString();
    var userimage = verifyotpModel.value.business!.image.toString();
    var userstate = verifyotpModel.value.business!.state.toString();
    var usercity  = verifyotpModel.value.business!.city.toString();

    prefs.setString('userid',    userid);
    prefs.setString('userName',  username.isEmpty ? 'User' : username);
    prefs.setString('userEmail', useremail);
    prefs.setString('userPhone', userphone);
    prefs.setString('userImage', userimage);
    prefs.setString('userState', userstate);
    prefs.setString('userCity',  usercity);

    Userdata.UserId    = prefs.getString('userid');
    Userdata.UserName  = prefs.getString('userName');
    Userdata.UserEmail = prefs.getString('userEmail');
    Userdata.UserPhone = prefs.getString('userPhone');
    Userdata.UserImage = prefs.getString('userImage');
    Userdata.UserState = prefs.getString('userState');
    Userdata.UserCity  = prefs.getString('userCity');

    print('UserId    : ${Userdata.UserId}');
    print('UserName  : ${Userdata.UserName}');
    print('UserEmail : ${Userdata.UserEmail}');
    print('UserPhone : ${Userdata.UserPhone}');
    print('UserImage : ${Userdata.UserImage}');
    print('UserState : ${Userdata.UserState}');
    print('UserCity  : ${Userdata.UserCity }');
  }

}