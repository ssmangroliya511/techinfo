// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import '../STATIC CLS/Static_class.dart';
import 'UpdateProfile_Controller.dart';

class UpdateProfile_Screen extends StatefulWidget {
  const UpdateProfile_Screen({Key? key}) : super(key: key);

  @override
  State<UpdateProfile_Screen> createState() => _UpdateProfile_ScreenState();
}

class _UpdateProfile_ScreenState extends State<UpdateProfile_Screen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Var.Updateimg_file = null;
    getxController.updateProfileController.unameController.value.text   = '';
    getxController.updateProfileController.uemailController.value.text  = '';
    getxController.updateProfileController.uStateController.value.text  = '';
    getxController.updateProfileController.uCityController.value.text   = '';
    getxController.updateProfileController.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.scaffoldColor,

      appBar: Widget_Appbar(),


      /// SAVE PROFILE BUTTON.................
      floatingActionButton: Obx((){
        return InkWell(
          onTap: () {
            getxController.updateProfileController.FetchUpdateProfile_Api();
          },
          child: Container(
              height:43,width:Get.width/1-35,
              decoration:BoxDecoration(
                  color:Colors.blueAccent,borderRadius:BorderRadius.circular(10),
                  gradient:LinearGradient(colors: [
                    Colors.blueAccent.shade700,Colors.blue.shade400,Colors.lightBlue.shade600
                  ])
              ),
              child: getxController.updateProfileController.isLoading.value == true ?
              Center(child: SizedBox(
                height:30,width:30,
                child: CircularProgressIndicator(
                    color:Colors.white,strokeWidth:2.5
                ),
              )) :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Save Profile',style:GoogleFonts.ptSans(color:Colors.white,fontSize:16)),
                  SizedBox(width:10),
                  Icon(IonIcons.save,color:Colors.white,size:16)
                ],
              )
          ),
        );
      }),

      body:ScrollConfiguration(

        behavior: ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child:Column(
            children: [
              Container(
                width:Get.width,
                padding: EdgeInsets.only(top:15,bottom:15),
                decoration:BoxDecoration(
                    color: Colors.white,borderRadius:BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color:Colors.black12,blurRadius:7,spreadRadius:-4)]
                ),
                child:Column(
                  children: [
                    /// IMAGE PROFILE ................
                    Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            var pickedImage = await Var.imagePicker.pickImage( source: ImageSource.gallery);
                            setState(() {
                              Var.Updateimg_file = File(pickedImage!.path);
                              print('For Update Picked img ==> ${Var.Updateimg_file}');
                            });
                          },
                          child: CircleAvatar(
                            radius:55,backgroundColor:Colors.grey.shade200,
                            backgroundImage: Var.Updateimg_file == null ? null :
                                 FileImage(File(Var.Updateimg_file!.path)),
                            child:Var.Updateimg_file == null ? Icon(Bootstrap.camera,size:30) : SizedBox()
                          ),
                        )
                    ),
                    SizedBox(height:15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(EvaIcons.info_outline,size:16.5,color: Colors.blueAccent),SizedBox(width:5),
                        Text('Tap Camera Icon to Update Profile Picture',
                            style:GoogleFonts.robotoFlex(color:Colors.black38,fontSize:13)
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                height:Get.height/2-5,width:Get.width,
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom:70,top:10),
                decoration:BoxDecoration(
                  color: Colors.white,borderRadius:BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color:Colors.black12,blurRadius:7,spreadRadius:-4)]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Update your Name -',style:GoogleFonts.robotoCondensed(),),
                    ),
                    TextField(
                       onChanged: (value) { setState(() {}); },
                       controller:getxController.updateProfileController.unameController.value,
                       cursorColor:Colors.black,style:GoogleFonts.roboto(fontSize:14),
                       textInputAction:TextInputAction.next,
                       textCapitalization: TextCapitalization.words,
                       decoration:InputDecoration(
                          isDense: true,filled:true,fillColor:Colors.grey.shade100,
                          hintText:Userdata.UserName == null || Userdata.UserName == '' ?
                             'Enter Name' : '${Userdata.UserName}',
                          counterText:'',
                          hintStyle:GoogleFonts.roboto(fontSize:13,color:Colors.black45),
                          constraints: BoxConstraints( maxHeight:45 ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(30),borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:BorderRadius.circular(30),
                              borderSide: BorderSide(color:Colors.blueAccent,width:0.7)
                          ),
                          prefixIcon:Icon(EvaIcons.person,color:Colors.blue),
                          suffixIcon:getxController.updateProfileController.unameController.value.text.isNotEmpty ?
                          IconButton(onPressed: (){
                            setState(() {
                              getxController.updateProfileController.unameController.value.text = '';
                            });
                           }, icon: Icon(CupertinoIcons.clear,size:15,color:Colors.blue)
                          ) : null
                      ),
                    ),
                    SizedBox(height:17),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Update your Email -',style:GoogleFonts.robotoCondensed(),),
                    ),
                    TextField(
                      onChanged: (value) { setState(() {}); },
                      controller:getxController.updateProfileController.uemailController.value,
                      cursorColor:Colors.black,style:GoogleFonts.roboto(fontSize:14),
                      textInputAction:TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration:InputDecoration(
                          isDense: true,filled:true,fillColor:Colors.grey.shade100,
                          hintText:Userdata.UserEmail == null || Userdata.UserEmail == '' ?
                             'Enter E-mail' : '${Userdata.UserEmail}',
                          counterText:'',
                          constraints: BoxConstraints( maxHeight:45 ),
                          hintStyle:GoogleFonts.roboto(fontSize:13,color:Colors.black45),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(30),borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:BorderRadius.circular(30),
                              borderSide: BorderSide(color:Colors.blueAccent,width:0.7)
                          ),
                          prefixIcon:Icon(EvaIcons.email,color:Colors.blue),
                          suffixIcon:getxController.updateProfileController.uemailController.value.text.isNotEmpty ?
                          IconButton(onPressed: (){
                            setState(() {
                              getxController.updateProfileController.uemailController.value.text = '';
                            });
                          }, icon: Icon(CupertinoIcons.clear,size:15,color:Colors.blue)
                          ) : null
                      ),
                    ),
                    SizedBox(height:17),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Update your State -',style:GoogleFonts.robotoCondensed(),),
                    ),
                    TextField(
                      onChanged: (value) { setState(() {}); },
                      controller:getxController.updateProfileController.uStateController.value,
                      cursorColor:Colors.black,style:GoogleFonts.roboto(fontSize:14),
                      textInputAction:TextInputAction.next,
                      decoration:InputDecoration(
                          isDense: true,filled:true,fillColor:Colors.grey.shade100,
                          hintText:Userdata.UserState == null || Userdata.UserState == '' ?
                             'Enter State' : '${Userdata.UserState}',
                          counterText:'',
                          constraints: BoxConstraints( maxHeight:45 ),
                          hintStyle:GoogleFonts.roboto(fontSize:13,color:Colors.black45),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(30),borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:BorderRadius.circular(30),
                              borderSide: BorderSide(color:Colors.blueAccent,width:0.7)
                          ),
                          prefixIcon:Icon(Bootstrap.building_fill,color:Colors.blue,size:15),
                          suffixIcon:getxController.updateProfileController.uStateController.value.text.isNotEmpty ?
                          IconButton(onPressed: (){
                            setState(() {
                              getxController.updateProfileController.uStateController.value.text = '';
                            });
                          }, icon: Icon(CupertinoIcons.clear,size:15,color:Colors.blue)
                          ) : null
                      ),
                    ),
                    SizedBox(height:17),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Update your City -',style:GoogleFonts.robotoCondensed(),),
                    ),
                    TextField(
                      onChanged: (value) { setState(() {}); },
                      controller:getxController.updateProfileController.uCityController.value,
                      cursorColor:Colors.black,style:GoogleFonts.roboto(fontSize:14),
                      textInputAction:TextInputAction.done,
                      decoration:InputDecoration(
                          isDense: true,filled:true, fillColor:Colors.grey.shade100,
                          hintText:Userdata.UserCity == null || Userdata.UserCity == '' ?
                              'Enter City' : '${Userdata.UserCity}',
                          counterText:'',
                          constraints: BoxConstraints( maxHeight:45 ),
                          hintStyle:GoogleFonts.roboto(fontSize:13,color:Colors.black45),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(30),borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:BorderRadius.circular(30),
                              borderSide: BorderSide(color:Colors.blueAccent,width:0.7)
                          ),
                          prefixIcon:Icon(FontAwesome.city,color:Colors.blue,size:12.5),
                          suffixIcon:getxController.updateProfileController.uCityController.value.text.isNotEmpty ?
                          IconButton(onPressed: (){
                            setState(() {
                              getxController.updateProfileController.uCityController.value.text = '';
                            });
                          }, icon: Icon(CupertinoIcons.clear,size:15,color:Colors.blue)
                          ) : null
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget_Appbar(){
  return AppBar(
    backgroundColor:Colors.white,elevation:0,centerTitle:true,
    iconTheme: IconThemeData(color:Colors.blueAccent),
    title: Text("Update Profile", style: GoogleFonts.ptSansCaption(
           fontSize:16,color:Colors.blueAccent,fontWeight:FontWeight.w600)
    ),
  );
}
