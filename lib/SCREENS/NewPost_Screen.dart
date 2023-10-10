// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';
import 'package:video_player/video_player.dart';
import '../STATIC CLS/Static_class.dart';

class NewPost_Screen extends StatefulWidget {
  const NewPost_Screen({Key? key}) : super(key: key);

  @override
  State<NewPost_Screen> createState() => _NewPost_ScreenState();
}

class _NewPost_ScreenState extends State<NewPost_Screen> {

  Uint8List? imageData;
  final ImagePicker picker = ImagePicker();
  File? ImgFile;

  VideoPlayerController controller = VideoPlayerController.networkUrl(Uri.parse(''));
  File videoFile = File('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: Widget_Appbar(),

      floatingActionButton: videoFile.path.isEmpty ?
      SpeedDialFabWidget(
        primaryIconCollapse: EvaIcons.close,
        primaryIconExpand: CupertinoIcons.add,

        primaryBackgroundColor: Colors.blueAccent,
        primaryForegroundColor: Colors.white,
        secondaryBackgroundColor: Colors.white,
        secondaryForegroundColor: Colors.black,

        secondaryIconsList: [ Icons.file_present_rounded, EvaIcons.video, Icons.image ],
        secondaryIconsText: [ "Doc", "Add Video", "Add Image"],
        secondaryIconsOnPress: [ () => {}, () => { floatingVideo_Onpressed()}, () => { floatingImg_Onpressed()} ],
      ) :
      FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
            setState(() {
              videoFile.path.isEmpty; videoFile.delete();
              imageData = null; ImgFile = null;
            });
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
              return NewPost_Screen();
            },));
          },child:Icon(Icons.delete,color:Colors.red)
      ),

      body: ScrollConfiguration(
        behavior: ScrollBehavior(
            androidOverscrollIndicator: AndroidOverscrollIndicator.stretch
        ),
        child: ListView(
          padding: EdgeInsets.only(top: 10, bottom: 60, left: 10, right: 10),
          children: [

            /// Description-1 Field ...............................
            Widget_Desc_Field(),
            SizedBox(height: 20),
            Divider(),

            TextField(
              onChanged: (value) {
                setState(() {});
              },
              controller: Fieldcontroller.pshortdescription,
              style: GoogleFonts.roboto(fontSize: 14),
              maxLines: null,
              maxLength: 100,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              onTapOutside: (event) => FocusNode(canRequestFocus: false),
              textCapitalization: TextCapitalization.sentences,
              cursorWidth: 0.9,
              cursorHeight: 17,
              decoration: InputDecoration(
                  isDense: true,counterText: '',
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.black45, width: 0.5)),
                  hintText: 'Short description',
                  hintStyle: GoogleFonts.robotoCondensed(color:Colors.black38,fontSize:14),
                  suffixIcon: Fieldcontroller.pshortdescription.text.isNotEmpty
                      ?
                  IconButton(onPressed: () {
                    setState(() {
                      Fieldcontroller.pshortdescription.text = '';
                    });
                  }, icon: Icon(EvaIcons.close, size: 20)) : SizedBox()
              )
            ),
            SizedBox(height: 5),
            Divider(),

            TextField(
              onChanged: (value) {
                setState(() {});
              },
              controller: Fieldcontroller.pattachlink,
              style: GoogleFonts.roboto(fontSize: 13,
                  color: CupertinoColors.link,
                  fontStyle: FontStyle.italic),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.done,
              onTapOutside: (event) => FocusNode(canRequestFocus: false),
              cursorWidth: 0.9, cursorHeight: 18,
              decoration: InputDecoration(
                  isDense: true,border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.black45, width: 0.5)),
                  hintText: 'Attach your link . . .',
                  hintStyle: GoogleFonts.robotoCondensed(
                      color: Colors.blue.shade200,fontSize: 13.5, fontStyle: FontStyle.normal),
                  suffixIcon: Fieldcontroller.pattachlink.text.isNotEmpty ?
                  IconButton(onPressed: () {
                    setState(() {
                      Fieldcontroller.pattachlink.text = '';
                    });
                  }, icon: Icon(EvaIcons.close, size: 20)) : SizedBox()
              ),
            ),
            Divider(),
            SizedBox(height: 10),

            /// View Post Image or Post Video .......................................
            imageData != null ? Widget_Add_PostImg() : SizedBox(),

            videoFile.path.isEmpty ? SizedBox() : Widget_Add_Video()
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
          CircleAvatar(
            backgroundColor: Colors.white, radius: 17,
            child: Image.asset('myimgs/User No Profile Dp.png'),
          ),
          SizedBox(width: 10),
          Text('Anyone . .▼', style: GoogleFonts.ptSansCaption(
              color: Colors.black, fontSize: 15))
        ],
      ),
      actions: [
        Container(
          padding: EdgeInsets.only(top: 11, bottom: 11, right: 13),
          child: GFButton(
            color: Colors.blueGrey.shade100.withOpacity(0.7),
            shape: GFButtonShape.pills,
            text: 'Post',textStyle: GoogleFonts.ptSans(color: Colors.blueAccent),
            icon: Icon(Bootstrap.send, color: Colors.blueAccent, size: 15),
            onPressed: () {}
          ),
        ),
      ],
    );
  }

  Widget_Desc_Field() {
    return TextField(
      onChanged: (value) {
        setState(() {});
      },
      style: GoogleFonts.roboto(fontSize: 15),
      controller: Fieldcontroller.pdescription,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      onTapOutside: (event) => FocusNode(canRequestFocus: false),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'What do you want to talk about?',
          hintStyle: GoogleFonts.ptSans(color: Colors.black38, fontSize: 16),
          suffixIcon: Fieldcontroller.pdescription.text.isNotEmpty ?
          IconButton(onPressed: () {
            setState(() {
              Fieldcontroller.pdescription.text = '';
            });
          }, icon: Icon(EvaIcons.close, size: 20)) : SizedBox()
      ),
    );
  }

  Widget_Add_PostImg() {
    return Stack(
      children: [
        imageData == null ? SizedBox() :
        SizedBox(
          height: Get.height / 2 - 130, width: Get.width,
          child: ClipRRect(borderRadius: BorderRadius.circular(10),
              child: Image.memory(imageData!, fit: BoxFit.cover)
          ),
        ),
      ],
    );
  }

  Widget_Add_Video() {
    return Stack(
      children: [
        videoFile.path.isEmpty || imageData != null ? SizedBox() : SizedBox(
            height: Get.height / 2 - 130, width: Get.width + 500,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                // aspectRatio:,
                child: VideoPlayer(controller),
              ),
            )
        ),
        Positioned(
          left: 142, top: 102,
          child: videoFile.path.isEmpty || imageData != null
              ? SizedBox()
              : CircleAvatar(
              backgroundColor: Colors.blue, radius: 25,
              child: IconButton(onPressed: () {
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
              },
                  icon: controller.value.isPlaying ? Icon(
                      HeroIcons.pause, size: 33, color: Colors.white) :
                  Padding(padding: EdgeInsets.only(left: 2.5),
                      child: Icon(
                          HeroIcons.play, size: 28, color: Colors.white)))
          ),
        ),
      ],
    );
  }

  floatingImg_Onpressed() async {
    setState(() {
      videoFile.path.isEmpty;
      File(videoFile.path).delete();
      imageData == null;
      imageData == '';
    });

    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      ImgFile = File(pickedImage!.path);
      print('Picked Post Img ==> $ImgFile');
    });

    imageData = await ImgFile!.readAsBytes();
    var editedImage = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => ImageEditor(image: imageData)));
    imageData = editedImage;
    setState(() {});
  }

  floatingVideo_Onpressed() async {
    setState(() {
      imageData == null;
      imageData == '';
      videoFile.path.isEmpty;
      File(videoFile.path).delete();
    });

    final pickedFile = await picker.pickVideo(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: Duration(seconds: 60)
    );
    setState(() {
      videoFile = File(pickedFile!.path);
    });
    setState(() {});

    controller = VideoPlayerController.file(File(videoFile.path));

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize().then((_) => setState(() {}));
    setState(() {
      imageData = null;
    });
  }
}

