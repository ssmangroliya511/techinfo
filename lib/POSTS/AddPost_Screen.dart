// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, unrelated_type_equality_checks, sized_box_for_whitespace

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

class AddPost_Screen extends StatefulWidget {
  const AddPost_Screen({Key? key}) : super(key: key);

  @override
  State<AddPost_Screen> createState() => _AddPost_ScreenState();
}

class _AddPost_ScreenState extends State<AddPost_Screen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Uint8List? imageData;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('In_Video : ${Var.AddPost_VideoFile}');
    print('In_Image : ${Var.AddPost_ImgFile}');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('Ds_Video : ${Var.AddPost_VideoFile}');
    print('Ds_Image : ${Var.AddPost_ImgFile}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                controller:getxController.addPostController.atitleController.value,
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
                    hintText: 'Add your title . . ',
                    hintStyle: GoogleFonts.robotoCondensed(color:Colors.black38,fontSize:14),
                    suffixIcon: getxController.addPostController.atitleController.value.text.isNotEmpty
                        ?
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

            /// View Post Image or Post Video .......................................
             Var.AddPost_ImgFile!.path.isNotEmpty || Var.AddPost_ImgFile != null
                 ? Widget_ShowImage() : SizedBox(),

             // Var.AddPost_VideoFile!.path.isNotEmpty || Var.AddPost_VideoFile != null ?
             Widget_ShowVideo()
                 // : SizedBox()
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
              getxController.addPostController.isLoading.value = false;
            },
            child: Text('Share a New Post', style: GoogleFonts.ptSansCaption(
                color: Colors.black, fontSize: 15)),
          )
        ],
      ),
      actions: [
        Obx((){
          return !getxController.addPostController.isLoading.value ? Container(
              padding: EdgeInsets.only(top: 11, bottom: 11, right: 13),
              child: GFButton(
                  color: Colors.blueGrey.shade100.withOpacity(0.7),
                  shape: GFButtonShape.pills,
                  text: 'Post',textStyle: GoogleFonts.ptSans(color: Colors.blueAccent),
                  icon: Icon(Bootstrap.send, color: Colors.blueAccent, size: 15),
                  onPressed: () {
                    getxController.addPostController.FetchAddPost_ApiData();
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
      controller: getxController.addPostController.adescriptionController.value,
      maxLines: null,maxLength:null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      onTapOutside: (event) => FocusNode(canRequestFocus: false),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'What do you want to talk about? . .',
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

  Widget_ShowImage() {
    return Stack(
      children: [
        imageData == null ? SizedBox() :
        SizedBox(
          height: Get.height / 2-180, width: Get.width,
          child: ClipRRect(borderRadius: BorderRadius.circular(10),
              child: Image.memory(imageData!, fit: BoxFit.cover)
          ),
        ),
      ],
    );
  }

  Widget_ShowVideo() {
    return Container(
        width: Get.width,child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: VideoPlayFile(pathh:Var.AddPost_VideoFile!.path,)
        )
    );
  }

   floatingDelete_Onpressed() async {

    if(Var.AddPost_VideoFile!.path.isEmpty && imageData == null)
      {
        Fluttertoast.showToast(
            msg: 'No files found to delete !?',
            gravity: ToastGravity.CENTER
        );
      }
    else{
      setState(() {
        imageData = null;
        Var.AddPost_ImgFile = File('');
        Var.AddPost_VideoFile = File('');
        print('DE-Video : ${Var.AddPost_VideoFile}');
        print('DE-Image : ${Var.AddPost_ImgFile}');
      });
      Fluttertoast.showToast(
          msg: 'Delete Successful !',textColor:Colors.green,
          gravity: ToastGravity.CENTER
      );
    }
   }


  floatingImg_Onpressed() async {
    setState(() {
      imageData = null;
      Var.AddPost_VideoFile = File('');
      print('Ds_Video : ${Var.AddPost_VideoFile}');
      print('Ds_Image : ${Var.AddPost_ImgFile}');
    });

    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      Var.AddPost_ImgFile = File(pickedImage!.path);
      print('Picked Add Post Img ==> ${Var.AddPost_ImgFile}');
    });

    imageData = await Var.AddPost_ImgFile!.readAsBytes();
    Var.editedImage = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ImageEditor(image: imageData))
    );

    imageData = Var.editedImage;
    setState(() {});

  }

  floatingVideo_Onpressed() async {
      setState(() {
        imageData = null;
        Var.AddPost_VideoFile = File('');
        print('V_Video : ${Var.AddPost_VideoFile}');
        print('V_Image : ${Var.AddPost_ImgFile}');
      });

      final pickedvideoFile = await picker.pickVideo(source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front, maxDuration: Duration(seconds: 60));
        setState(() {
          Var.AddPost_VideoFile = File(pickedvideoFile!.path);
        });
    }


  }