// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:linkedin_clone/NOTIFICATIONS/Notification_Model.dart';

class NotificationController extends GetxController{

  RxBool isLoading = false.obs;
  var notificationModel = Notification_Model().obs;


  FetchNotificationApi(){

  }
}