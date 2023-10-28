// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables

import 'package:dio/dio.dart'as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SCREENS/BottomHome_Screen.dart';
import '../STATIC CLS/Static_class.dart';
import 'UpdateProfile_Model.dart';

class UpdateProfileController extends GetxController{

  RxBool isLoading = false.obs;
  var updateprofileModel = UpdateProfile_Model().obs;
  
  var unameController   = TextEditingController().obs;
  var uemailController  = TextEditingController().obs;
  var uStateController  = TextEditingController().obs;
  var uCityController   = TextEditingController().obs;

  FetchUpdateProfile_Api() async {
    isLoading.value = true;

    print('Update UserID : ${Userdata.UserId}');
    print('Update Email  : ${uemailController.value.text}');
    print('Update Name   : ${unameController.value.text}');
    print('Update Image  : ${Var.Updateimg_file}');
    print('Update State  : ${uStateController.value.text}');
    print('Update City   : ${uCityController.value.text}');

    final response;
    try{

      dio.FormData formData = dio.FormData.fromMap({
        'User_id'   : Userdata.UserId,
        'Email'     : uemailController.value.text,
        'Name'      : unameController.value.text,
        'Image'     : Var.Updateimg_file != null ? await dio.MultipartFile.fromFile(Var.Updateimg_file!.path.toString(),filename: 'image1.jpg') : '',
        'State'     : uStateController.value.text,
        'City'      : uCityController.value.text,
      });
      response = await Dio().post(Urls.baseurl + Constants.UPDATEPROF, data: formData);

      updateprofileModel.value = UpdateProfile_Model.fromJson(response.data);

      if (response.statusCode == 200 && updateprofileModel.value.code == 200) {
        isLoading.value = false;
        getDialogs(
            'Success','Profile Update Successfully',
             Colors.white,Colors.green,Icons.check_circle_rounded,
             Colors.white,const Duration(seconds:2)
        );
        print('Update Success ${updateprofileModel.value.business.toString()}');
        SaveDataInPrefs();

        Get.offAll(const BottomHome_Screen());
      }
      else{
        isLoading.value = false;
        getDialogs(
            'Error',updateprofileModel.value.business.toString(),
            Colors.white,Colors.red,Icons.error,
            Colors.red,const Duration(seconds:2)
        );
        print('Error : ${updateprofileModel.value.business.toString()}');
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
      return e.response;
   }
  }

  SaveDataInPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userid',Userdata.UserId.toString());
    prefs.setString('userName',updateprofileModel.value.data!.name.toString());
    prefs.setString('userEmail',updateprofileModel.value.data!.email.toString());
    prefs.setString('userPhone',updateprofileModel.value.data!.mobile.toString());
    prefs.setString('userImage',updateprofileModel.value.data!.image.toString());
    prefs.setString('userState',updateprofileModel.value.data!.state.toString());
    prefs.setString('userCity', updateprofileModel.value.data!.city.toString());

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