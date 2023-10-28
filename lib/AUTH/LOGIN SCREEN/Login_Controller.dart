// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkedin_clone/AUTH/LOGIN%20SCREEN/Login_Model.dart';
import 'package:linkedin_clone/AUTH/VERIFY%20OTP/Verifyotp_Screen.dart';
import '../../STATIC CLS/Static_class.dart';

class LoginController extends GetxController{

   final lmobile      = TextEditingController().obs;
   var sendotpModel   = SendOtp_Model().obs;
   RxBool isLoading   = false.obs;

   FetchSendOtpApi() async {

     isLoading.value = true;

     try {
      var response = await Var.dio.post(Urls.baseurl + Constants.LOGIN,
          data: {
             'Mobile'   : lmobile.value.text,
          });
          sendotpModel.value = SendOtp_Model.fromJson(response.data);

       if (response.statusCode == 200 && sendotpModel.value.code == 200 || sendotpModel.value.oTP != null) {
         isLoading.value = false;

         getDialogs(
             'Success','Your Otp is ${sendotpModel.value.oTP.toString()}',
              Colors.white,Colors.green,Icons.error,
              Colors.white,const Duration(seconds:3)
         );

         print('Your Otp is ${sendotpModel.value.oTP.toString()}');

         Get.offAll( Verifyotp_Screen(sendotpModel.value.oTP.toString()));
       }
       else{
         isLoading.value = false;
         getDialogs(
             'Error',sendotpModel.value.message.toString(),
              Colors.white,Colors.red,Icons.error,Colors.red,const Duration(seconds:2)
         );
         print('Error : ${sendotpModel.value.message.toString()}');
       }
     }
     on DioException catch (e){
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
    }

  }
}

