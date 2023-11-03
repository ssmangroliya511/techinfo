// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, unrelated_type_equality_checks, sized_box_for_whitespace, prefer_typing_uninitialized_variables, must_be_immutable, prefer_if_null_operators

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkedin_clone/POSTS/AddPost_Controller.dart';
import 'package:linkedin_clone/VIDEO%20CONTROLLERS/VideoController_file.dart';
import 'package:lottie/lottie.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';
import '../STATIC CLS/Static_class.dart';

class UpdatePost_Screen extends StatefulWidget {
  dynamic postID;
  dynamic index;
  UpdatePost_Screen(this.postID,this.index, {Key? key}) : super(key: key);

  @override
  State<UpdatePost_Screen> createState() => _UpdatePost_ScreenState();
}

class _UpdatePost_ScreenState extends State<UpdatePost_Screen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Uint8List? imageData;
  final ImagePicker picker = ImagePicker();
  var postId;
  var postindex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getxController.updatePostController.utitleController.value.text = '';
    getxController.updatePostController.udescriptionController.value.text = '';
    getxController.updatePostController.isLoading.value = false;
    Var.isVideoPost = false;
    Var.isImagePost = false;
    Var.AddPost_ImgFile = File('');
    Var.AddPost_VideoFile = File('');
    print('In_Video : ${Var.AddPost_VideoFile}');
    print('In_Image : ${Var.AddPost_ImgFile}');
    print('isVideoPost : ${Var.isVideoPost }');
    print('isImagePost : ${Var.isImagePost }');

    postindex = widget.index;

    postId = widget.postID;
    Var.previousTitle = getxController.myPostController.mypostModel.value.business!.post![postindex].pTitle;
    Var.previousDescri = getxController.myPostController.mypostModel.value.business!.post![postindex].pDesc;
    print('POST ID ==> $postId');
    print('POST INDEX ==> $postindex');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Var.AddPost_ImgFile = File('');
    Var.AddPost_VideoFile = File('');
    getxController.addPostController.atitleController.value.text = '';
    getxController.addPostController.adescriptionController.value.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: Widget_Appbar(),

      floatingActionButton: SpeedDialFabWidget(
        primaryIconCollapse: EvaIcons.close,
        primaryIconExpand: CupertinoIcons.add,

        primaryBackgroundColor: Colors.blueAccent,
        primaryForegroundColor: Colors.white,
        secondaryBackgroundColor: Colors.white,
        secondaryForegroundColor: Colors.black,

        secondaryIconsList: [ CupertinoIcons.delete_solid, EvaIcons.video, Icons.image ],
        secondaryIconsText: [ "Delete", "Add Video", "Add Image"],
        secondaryIconsOnPress: [
              () => floatingDelete_Onpressed(),
              () => floatingVideo_Onpressed(),
              () => floatingImg_Onpressed(),
        ],
      ),

      body: ScrollConfiguration(
        behavior: ScrollBehavior(
            androidOverscrollIndicator: AndroidOverscrollIndicator.stretch
        ),
        child: ListView(
          padding: EdgeInsets.only(top: 10, bottom: 60, left: 10, right: 10),
          children: [

            /// Title Field ...............................
            TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller:getxController.updatePostController.utitleController.value,
                style: GoogleFonts.roboto(fontSize: 14),
                maxLines: null, maxLength:50,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                onTapOutside: (event) => FocusNode(canRequestFocus: false),
                textCapitalization: TextCapitalization.sentences,
                cursorWidth: 0.9, cursorHeight: 17,
                decoration: InputDecoration(
                    isDense: true,counterText: '',
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                        color: Colors.black45, width: 0.5)),
                    hintText:  Var.previousTitle != null ? Var.previousTitle : 'Your title or Questions . . . ',
                    hintStyle: GoogleFonts.robotoCondensed(color:Colors.black38,fontSize:14),
                    suffixIcon: getxController.addPostController.atitleController.value.text.isNotEmpty ?
                    IconButton(onPressed: () {
                      setState(() {
                        getxController.addPostController.atitleController.value.text = '';
                      });
                    }, icon: Icon(EvaIcons.close, size: 20)) : SizedBox()
                )
            ),
            SizedBox(height: 20),
            Divider(),

            /// Description Field ................
            Widget_Desc_Field(),
            SizedBox(height: 5),
            Divider(),

            SizedBox(height: 20),

            /// View Post Image .......................................
            Var.isImagePost == true ?
            Container(
              height: Get.height/2-180,
              width: Get.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageData!=null ? Image.memory(imageData!,fit: BoxFit.cover) : SizedBox(),
              ),
            )
                : Var.isVideoPost == true ?

            /// View Post Video .......................................
            Container(
                width:400,child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:VideoPlayFile(
                    pathh:Var.AddPost_VideoFile?.path != null ? Var.AddPost_VideoFile!.path.toString() : ''
                )
            )
            )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget_Appbar() {
    return AppBar(
      toolbarHeight: 55,
      backgroundColor: Colors.white,
      elevation: 0.5,centerTitle: true,
      iconTheme: IconThemeData(color: Colors.blueAccent),
      actionsIconTheme: IconThemeData(color: Colors.blueAccent),
      leadingWidth: 45,
      title: Row(
        children: [
          InkWell(
            onTap: () {
              getxController.updatePostController.isLoading.value = false;
            },
            child: Text('Edit This Post ....', style: GoogleFonts.ptSansCaption(
                color: Colors.black, fontSize: 15)),
          )
        ],
      ),
      actions: [
        Obx((){
          return !getxController.updatePostController.isLoading.value ?
          Container(
            padding: EdgeInsets.only(top: 11, bottom: 11, right: 13),
            child: GFButton(
                color: Colors.blueGrey.shade50.withOpacity(0.9),
                shape: GFButtonShape.pills,
                text: 'Update Post',textStyle: GoogleFonts.poppins(
                    color: Colors.green,fontSize:12,fontWeight: FontWeight.w500
                ),
                icon: Icon(Icons.update,color:Colors.green, size:19),
                onPressed: () {
                  Var.postId  = postId;
                  getxController.updatePostController.FetchUpdatePost_ApiData();
                  getxController.myPostController.FetchMyPost_ApiData();
                  getxController.homeController.FetchAllPost_ApiData();
                }
            ),
          ) : Lottie.asset('assets/mylottie/Dot Loading Animation.json',
              height:Get.height/3+10,width:Get.width/4);
        })
      ],
    );
  }

  Widget_Desc_Field() {
    return TextField(
      onChanged: (value) {
        setState(() {});
      },
      style: GoogleFonts.roboto(fontSize: 15),
      controller: getxController.updatePostController.udescriptionController.value,
      maxLines: null,maxLength:null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      onTapOutside: (event) => FocusNode(canRequestFocus: false),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: Var.previousDescri != null ? Var.previousDescri : 'What you want to describe . . . ',
          hintStyle: GoogleFonts.ptSans(color: Colors.black38, fontSize: 16),
          suffixIcon: getxController.addPostController.adescriptionController.value.text.isNotEmpty ?
          IconButton(onPressed: () {
            setState(() {
              getxController.addPostController.adescriptionController.value.text = '';
            });
          }, icon: Icon(EvaIcons.close, size: 20)) : SizedBox()
      ),
    );
  }

  floatingDelete_Onpressed() async {
    setState(() {
      Var.isVideoPost = false;
      Var.isImagePost = false;
      Var.AddPost_ImgFile = File('');
      Var.AddPost_VideoFile = File('');
      print('DE-Video : ${Var.AddPost_VideoFile}');
      print('DE-Image : ${Var.AddPost_ImgFile}');
      print('isVideoPost : ${Var.isVideoPost }');
      print('isImagePost : ${Var.isImagePost }');
    });
    Fluttertoast.showToast(
        msg: 'Delete Successful !',textColor:Colors.green,
        gravity: ToastGravity.CENTER
    );
  }


  floatingImg_Onpressed() async {
    setState(() {
      Var.isImagePost = true;
      Var.isVideoPost = false;
      Var.AddPost_VideoFile = File('');
      imageData = null;
      print('Ds_Video : ${Var.AddPost_VideoFile}');
      print('Ds_Image : ${Var.AddPost_ImgFile}');
      print('isVideoPost : ${Var.isVideoPost }');
      print('isImagePost : ${Var.isImagePost }');
    });

    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      Var.AddPost_ImgFile = File(pickedImage!.path);
      print('Picked Add Post Img ==> ${Var.AddPost_ImgFile}');
    });

    imageData = await Var.AddPost_ImgFile!.readAsBytes();
    final editedImage = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ImageEditor(image: imageData))
    );

    imageData = editedImage;
    setState(() {});

  }

  floatingVideo_Onpressed() async {
    setState(() {
      Var.isImagePost = false;
      Var.AddPost_ImgFile = File('');
      imageData = null;
      print('V_Video : ${Var.AddPost_VideoFile}');
      print('V_Image : ${Var.AddPost_ImgFile}');
      print('isVideoPost : ${Var.isVideoPost }');
      print('isImagePost : ${Var.isImagePost }');
    });

    final pickedvideoFile = await picker.pickVideo(source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front, maxDuration: Duration(seconds: 60));
    setState(() {
      Var.isVideoPost = true;
      Var.AddPost_VideoFile = File('');
      Var.AddPost_VideoFile = File(pickedvideoFile!.path);
    });
    print('Add Video ==> ${Var.AddPost_VideoFile}');
  }


}