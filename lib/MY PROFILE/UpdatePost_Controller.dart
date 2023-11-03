// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkedin_clone/SCREENS/BottomHome_Screen.dart';
import '../STATIC CLS/Static_class.dart';
import 'UpdatePost_Model.dart';

class UpdatePostController extends GetxController{


  var updatepostModel = UpdatePost_Model().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  final utitleController        = TextEditingController(text: Var.previousTitle.toString()).obs;
  final udescriptionController  = TextEditingController(text: Var.previousDescri.toString()).obs;

  FetchUpdatePost_ApiData() async {

    print('User_id   : ${Userdata.UserId.toString()}');
    print('Postid    : ${Var.postId}');
    print('UP_title  : ${utitleController.value.text}');
    print('UP_desc   : ${udescriptionController.value.text}');
    print('UPostImg  : ${Var.AddPost_ImgFile!.path}');
    print('UPostVid  : ${Var.AddPost_VideoFile!.path}');

    isLoading.value = true;

    try {
      dio.FormData formData = dio.FormData.fromMap({

        'User_id' : Userdata.UserId.toString(),
        'Postid'  : Var.postId,
        'P_title' : utitleController.value.text,
        'P_desc'  : udescriptionController.value.text,
        'Source'  : Var.AddPost_ImgFile!.path.isNotEmpty ?
                    await dio.MultipartFile.fromFile(Var.AddPost_ImgFile!.path,filename: 'image.jpg') :
                    Var.AddPost_VideoFile!.path.isNotEmpty ?
                    await dio.MultipartFile.fromFile(Var.AddPost_VideoFile!.path,filename: 'video.mp4') : null
      });
      var response = await Dio().post(Urls.baseurl + Constants.UPDATEPOST, data: formData,);

      updatepostModel.value = UpdatePost_Model.fromJson(response.data);

      if (response.statusCode == 200 && updatepostModel.value.code == 200) {

        getDialogs(
            'Success','Post Updated Successfully',
             Colors.white,Colors.green,Icons.error,
             Colors.white,const Duration(seconds:3)
        );

        print('UpdatePost Api Data : ${response.data.toString()}');
        print('UpdatePost Api Response : ${updatepostModel.value.code.toString()}');

        Get.off(const BottomHome_Screen());
        isLoading.value = false;
      }
      else{
        isLoading.value = false;
        print('Error : ${updatepostModel.value.message}');
        print('Error : ${updatepostModel.value.code}');

        getDialogs(
            'Error','Something wrong !',
             Colors.white,Colors.red,Icons.error,
             Colors.white,const Duration(seconds:3)
        );
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