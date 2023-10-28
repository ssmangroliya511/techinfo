// ignore_for_file: must_be_immutable, library_private_types_in_public_api, deprecated_member_use

import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class VideoPlayFile extends StatefulWidget {

  String? pathh;
  VideoPlayFile({Key? key, this.pathh}) : super(key: key);

  @override
  _VideoPlayFileState createState() => _VideoPlayFileState();
}

class _VideoPlayFileState extends State<VideoPlayFile> {

  VideoPlayerController? videocontroller2;
  ChewieController? chewieController2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videocontroller2!.dispose();
    videocontroller2!.pause();
    videocontroller2!.value.volume == 0;

    chewieController2!.dispose();
    chewieController2!.pause();
    chewieController2!.videoPlayerController.value.volume == 0;
  }

  Future initializePlayer() async {
    videocontroller2 = VideoPlayerController.file(File(widget.pathh.toString()));

    await Future.wait([videocontroller2!.initialize()]);

    chewieController2 = ChewieController(
      videoPlayerController: videocontroller2!,
      autoPlay:true,
      looping: false,
      showControls: true,
      showControlsOnInitialize:true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      autoInitialize: true,
      showOptions: true,
      useRootNavigator: true,
      draggableProgressBar: true,
      errorBuilder: (context, errorMessage) {
        return Container(
          width: Get.width,
          color:Colors.black45,
          child: const Center(
              child: Icon(CupertinoIcons.wifi_exclamationmark,color:Colors.red)
          ),
        );
      },
    );
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: chewieController2 != null &&
            chewieController2!.videoPlayerController.value.isInitialized &&
            videocontroller2!= null ?
        AspectRatio(
            aspectRatio:chewieController2!.videoPlayerController.value.aspectRatio,
            child: Chewie(controller: chewieController2!)
        ) :
        Container(
            height: Get.height/4,width: Get.width,
            color:Colors.black,margin: const EdgeInsets.all(7),
            child: Shimmer.fromColors(
                baseColor: Colors.blueAccent,highlightColor: Colors.white,
                child : const Icon(Icons.videocam,size:40)
            )
        )
    );
  }
}

