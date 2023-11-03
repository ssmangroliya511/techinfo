// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_constructors

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../SCREENS/BottomHome_Screen.dart';
import '../STATIC CLS/Static_class.dart';
import 'AddPost_Model.dart';

class AddPostController extends GetxController{

  var addpostModel = AddPost_Model().obs;
  RxBool isLoading = false.obs;

  final atitleController        = TextEditingController().obs;
  final adescriptionController  = TextEditingController().obs;

  FetchAddPost_ApiData() async {

    isLoading.value = true;

    print('User_id : ${Userdata.UserId.toString()}');
    print('P_title : ${atitleController.value.text}');
    print('P_desc  : ${adescriptionController.value.text}');
    print('Image   : ${Var.AddPost_ImgFile}');
    print('Video   : ${Var.AddPost_VideoFile}');

    try {
      dio.FormData formData = dio.FormData.fromMap({
        'User_id' : Userdata.UserId.toString(),
        'P_title' : atitleController.value.text,
        'P_desc'  : adescriptionController.value.text,
        'Source'  : Var.AddPost_ImgFile!.path.isNotEmpty ?
                    await dio.MultipartFile.fromFile(Var.AddPost_ImgFile!.path,filename: 'image.jpg') :
                    Var.AddPost_VideoFile!.path.isNotEmpty ?
                    await dio.MultipartFile.fromFile(Var.AddPost_VideoFile!.path,filename: 'video.mp4') : null
      });
      var response = await Dio().post(Urls.baseurl + Constants.ADDPOSTS, data: formData,);

      addpostModel.value = AddPost_Model.fromJson(response.data);

      if (response.statusCode == 200 && addpostModel.value.code == 200) {
        isLoading.value = false;
        getDialogs(
            'Success','Post Added Successfully',
             Colors.white,Colors.green,Icons.done_outline,
             Colors.white,const Duration(seconds:2)
        );
        Get.offAll(BottomHome_Screen());

        print('Data Success : ${response.data}');
        print('Code Success : ${response.statusCode}');
      }
      else{
        isLoading.value = false;
        print('Error : ${addpostModel.value.message}');
        print('Error : ${addpostModel.value.code}');
      }
    }
    on DioException catch (e){
      print('Status Code ${e.message} : Invalid url or Incorrect Url !');
      print('Status Code ${e.response?.data.toString()} : Invalid url or Incorrect Url !');
      if(e.response?.statusCode == 404){
        isLoading.value = false;
        print('Status Code ${e.response?.statusCode} : Invalid url or Incorrect Url !');
        getDialogs(
            '404 Error','Invalid url or Incorrect Url !',
            Colors.red,Colors.white,Icons.error,Colors.red,const Duration(seconds:2)
        );
      }
      else if (e.response?.statusCode == 400){
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
    return isLoading.value = false;
  }
}


// dio.FormData formData = dio.FormData.fromMap({
// 'User_id' : Userdata.UserId.toString(),
// 'P_title' : atitleController.value.text,
// 'P_desc'  : adescriptionController.value.text,
// 'Image'   : Var.AddPost_ImgFile != null  && Var.AddPost_ImgFile!.path.isNotEmpty ?
// await dio.MultipartFile.fromFile(Var.AddPost_ImgFile!.path, filename: 'image.jpg') : null,
// 'Video'   : Var.AddPost_VideoFile != null && Var.AddPost_VideoFile!.path.isNotEmpty ?
// await dio.MultipartFile.fromFile(Var.AddPost_VideoFile!.path, filename: 'video.mp4') : null
// });