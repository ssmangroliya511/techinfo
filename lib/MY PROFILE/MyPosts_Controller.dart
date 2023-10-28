// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkedin_clone/MY%20PROFILE/MyPost_Model.dart';
import '../STATIC CLS/Static_class.dart';

class MyPostController extends GetxController{

  var mypostModel = MyPosts_Model().obs;
  RxBool isLoading = false.obs;

  FetchMyPost_ApiData() async {

    isLoading.value = true;

    try {
      var response = await Var.dio.post(Urls.baseurl + Constants.MYPOSTS,
          data: {
            'User_id'   :  Userdata.UserId.toString(),
          });
      mypostModel.value = MyPosts_Model.fromJson(response.data);

      if (response.statusCode == 200 && mypostModel.value.code == 200) {
        isLoading.value = false;
        print('MyPost Api Data : ${response.data.toString()}');
        print('MyPost Api Response : ${mypostModel.value.code.toString()}');
      }
      else{
        isLoading.value = false;
        print('Error : ${mypostModel.value.business!.post}');
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
            'Unknown Error','Something went wrong !',
            Colors.red,Colors.white,Icons.error,Colors.red,const Duration(seconds:2)
        );
      }
    }
    
  }
}