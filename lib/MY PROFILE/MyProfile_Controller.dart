// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:linkedin_clone/STATIC%20CLS/Static_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class MyProfileController extends GetxController{


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    FetchUserData();
  }


  FetchUserData() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();

     Userdata.UserId      =  prefs.get('userid').obs;
     Userdata.UserName    =  prefs.get('userName').obs;
     Userdata.UserEmail   =  prefs.get('userEmail').obs;
     Userdata.UserPhone   =  prefs.get('userPhone').obs;
     Userdata.UserImage   =  prefs.get('userImage').obs;
     Userdata.UserState   =  prefs.get('userState').obs;
     Userdata.UserCity    =  prefs.get('userCity').obs;
  }
}