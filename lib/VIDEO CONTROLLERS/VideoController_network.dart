// ignore_for_file: must_be_immutable, library_private_types_in_public_api, deprecated_member_use, non_constant_identifier_names

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:linkedin_clone/STATIC%20CLS/Static_class.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayNetwork extends StatefulWidget {
  String? pathh;

  VideoPlayNetwork({Key? key, this.pathh}) : super(key: key);

  @override
  _VideoPlayNetworkState createState() => _VideoPlayNetworkState();
}

class _VideoPlayNetworkState extends State<VideoPlayNetwork> {
  VideoPlayerController? videocontroller;
  ChewieController? chewieController;

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
    videocontroller!.dispose();
    videocontroller!.pause();
    videocontroller!.value.volume == 0;

    chewieController!.dispose();
    chewieController!.pause();
    chewieController!.videoPlayerController.value.volume == 0;

  }

  Future initializePlayer() async {
    videocontroller =
        VideoPlayerController.network(Urls.mainurl + widget.pathh.toString());

    await Future.wait([videocontroller!.initialize()]);

    chewieController = ChewieController(
      videoPlayerController: videocontroller!,
      autoPlay: true,
      looping: true,
      showControls: true,
      showControlsOnInitialize: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      autoInitialize: true,
      showOptions: true,
      useRootNavigator: true,
      draggableProgressBar: true,
      errorBuilder: (context, errorMessage) {
        return Container(
          width: Get.width,
          color: Colors.black45,
          child: const Center(
              child:
                  Icon(CupertinoIcons.wifi_exclamationmark, color: Colors.red)),
        );
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: chewieController != null &&
               chewieController!.videoPlayerController.value.isInitialized &&
               videocontroller != null
            ?
            VisibilityDetector(
                key: Key('unique key'),
                onVisibilityChanged: (visibilityInfo) {
                  var visiblePercentage = visibilityInfo.visibleFraction * 100;
                  if (visibilityInfo.visibleFraction == 0 || visibilityInfo.visibleFraction != 1) {
                    chewieController!.pause();
                    videocontroller!.pause();
                    chewieController!.videoPlayerController.value.volume == 0;

                  } else {
                    videocontroller!.play();
                    chewieController!.play();
                    chewieController!.videoPlayerController.value.volume == 100 ;
                  }
                },
                child: AspectRatio(
                    aspectRatio: chewieController!
                        .videoPlayerController.value.aspectRatio,
                    child: Chewie(controller: chewieController!)),
              )
            : Container(
                height: Get.height / 4,
                width: Get.width,
                color: Colors.black,
          margin: const EdgeInsets.all(7),
                child: Shimmer.fromColors(
                    baseColor: Colors.blueAccent,
                    highlightColor: Colors.white,
                    child: const Icon(Icons.videocam, size: 40))));
  }
}
