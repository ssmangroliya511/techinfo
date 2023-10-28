// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkedin_clone/HOME/Home_Model.dart';
import '../STATIC CLS/Static_class.dart';

class HomeController extends GetxController{

  var homeallPostModel = HomeAllPost_Model().obs;
  RxBool isLoading = false.obs;

  FetchAllPost_ApiData() async {

    isLoading.value = true;

    try {
      var response = await Var.dio.get(Urls.baseurl + Constants.ALLPOSTS);
      
      homeallPostModel.value = HomeAllPost_Model.fromJson(response.data);

      if (response.statusCode == 200 && homeallPostModel.value.code == 200) {
        isLoading.value = false;
        print('AllPost Api Data : ${response.data.toString()}');
        print('AllPost Api Response : ${homeallPostModel.value.code.toString()}');
      }
      else{
        isLoading.value = false;
        print('Error : ${homeallPostModel.value.business!.post}');
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