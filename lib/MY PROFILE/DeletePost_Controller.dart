// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkedin_clone/MY%20PROFILE/DeletePost_Model.dart';
import '../STATIC CLS/Static_class.dart';

class DeletePostController extends GetxController{

  var deletePostModel = DeletePost_Model().obs;
  RxBool isLoading = false.obs;

  FetchDeletePost_ApiData() async {

    isLoading.value = true;

    try {
      print('Post ID : ${Var.postId}');
      var response = await Var.dio.post(Urls.baseurl + Constants.DELETEPOST,
          data: {
            'user_id'   :  Userdata.UserId.toString(),
            'post_id'   :  Var.postId,
          });
      deletePostModel.value = DeletePost_Model.fromJson(response.data);

      if (response.statusCode == 200 && deletePostModel.value.code == 200) {
        isLoading.value = false;

        getDialogs(
            'Success','Post Deleted Successfully',
             Colors.green,Colors.white,Icons.error,
             Colors.green,const Duration(seconds:3)
        );

        print('DeletePost Api Data : ${response.data.toString()}');
        print('DeletePost Api Response : ${deletePostModel.value.code.toString()}');
      }
      else{
        isLoading.value = false;

        getDialogs(
            'Error',deletePostModel.value.business,
             Colors.red,Colors.white,Icons.error,
             Colors.red,const Duration(seconds:2)
        );

        print('Error : ${deletePostModel.value.business}');
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