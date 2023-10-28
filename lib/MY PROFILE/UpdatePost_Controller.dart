// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../STATIC CLS/Static_class.dart';
import 'UpdatePost_Model.dart';

class UpdatePostController extends GetxController{


  var updatepostModel = UpdatePost_Model().obs;
  RxBool isLoading = false.obs;


  FetchUpdatePost_ApiData() async {

    isLoading.value = true;

    try {
      var response = await Var.dio.post(Urls.baseurl + Constants.MYPOSTS,
          data: {
            'User_id' : Userdata.UserId.toString(),
            'Postid'  : Var.postId,
            'P_title' : Var.postTitle,
            'P_desc'  : Var.postDescription,
            'Source'  : Var.postSourse
          });
      updatepostModel.value = UpdatePost_Model.fromJson(response.data);

      if (response.statusCode == 200 && updatepostModel.value.code == 200) {
        isLoading.value = false;

        getDialogs(
            'Success','Post Updated Successfully',
             Colors.white,Colors.green,Icons.error,
             Colors.white,const Duration(seconds:3)
        );

        print('UpdatePost Api Data : ${response.data.toString()}');
        print('UpdatePost Api Response : ${updatepostModel.value.code.toString()}');
      }
      else{
        isLoading.value = false;
        print('Error : ${updatepostModel.value.message}');
        print('Error : ${updatepostModel.value.code}');
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