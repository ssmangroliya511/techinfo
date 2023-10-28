// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_const_constructors, deprecated_member_use, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../STATIC CLS/Static_class.dart';
import '../VIDEO CONTROLLERS/VideoController_network.dart';

class ViewPost_Screen extends StatefulWidget {
  String? postTitle;
  String? postDescri;
  String? postcreateAt;
  String? postSource;
  String? postMediaType;
  String? userImage;
  String? userName;

  ViewPost_Screen(this.postTitle, this.postDescri, this.postcreateAt,
      this.postSource, this.postMediaType, this.userImage, this.userName,
      {super.key});

  @override
  State<ViewPost_Screen> createState() => _ViewPost_ScreenState();
}

class _ViewPost_ScreenState extends State<ViewPost_Screen> {
  String? postTitle;
  String? postDescri;
  String? postcreateAt;
  String? postSource;
  String? postMediaType;
  String? userImage;
  String? userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    postTitle = widget.postTitle;
    postDescri = widget.postDescri;
    postcreateAt = widget.postcreateAt;
    postSource = widget.postSource;
    postMediaType = widget.postMediaType;
    userImage = widget.userImage;
    userName = widget.userName;
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Utils.scaffoldColor,
        body: ScrollConfiguration(
            behavior: ScrollBehavior(
                androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
            child: ListView(
              children: [
                 Stack(
                   children: [

                     /// PROFILE PIC ......................................
                     Container(
                       width: Get.width,
                       padding: EdgeInsets.only(top: 15, bottom: 30),
                       decoration: BoxDecoration(
                           color: Colors.blueAccent, borderRadius: BorderRadius.vertical(
                               bottom: Radius.circular(35)),
                           gradient: LinearGradient(colors: [
                             Colors.blueAccent,Colors.blueAccent.shade100,Colors.lightBlue
                           ])
                       ),
                       child: Column(children: [
                         /// PROFILE PIC ......................................
                         Container(
                           padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(100),
                             boxShadow: [BoxShadow(color:Colors.white24,blurRadius:25,spreadRadius:-5)]
                           ),
                           child: CircleAvatar(
                             radius:47,backgroundColor: Colors.grey.shade200,
                             child: userImage!.isEmpty || userImage == '' || userImage == 'null'
                                 ? Text(userName.toString().substring(0, 1).toUpperCase(),
                                      style: GoogleFonts.pacifico(
                                      color: Colors.blueAccent.shade700,
                                      fontWeight: FontWeight.w500,fontSize: 18),
                                  )
                                 : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      imageUrl: Urls.mainurl + userImage.toString(),
                                      height: Get.height / 4, width: Get.width,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.blueAccent, strokeWidth: 2)),
                                      errorWidget: (context, url, error) => Icon(
                                        Icons.image_search,
                                        color: Colors.red,
                                      ),
                                    ),
                               ),
                           ),
                         ),

                         /// USER NAME ....................................
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(userName.toString().toUpperCase(),
                                 style: GoogleFonts.poppins(color:Colors.white,
                                 fontSize: 16, fontWeight: FontWeight.w500),
                           ),
                         ),
                       ]),
                     ),

                     /// Buttons Widget ...................................
                     Positioned(
                       top:Get.height/7+10,left:0,right:0,
                       child: Container(
                         margin: EdgeInsets.all(35),
                         padding: EdgeInsets.only(top:5,bottom:5),
                         height: 54, width: Get.width,
                         decoration: BoxDecoration(
                             color: Colors.white, borderRadius: BorderRadius.circular(10),
                             border: Border.all(color: Colors.black12, width: 0.2),
                             boxShadow: [
                               BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: -5)
                             ]),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Column(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 CircleAvatar(
                                     radius: 15,backgroundColor: Colors.blue.shade50,
                                     child: Icon(Icons.thumb_up,color: Colors.blue, size: 16)
                                 ),

                                 Text('Likes', style: GoogleFonts.robotoCondensed(fontSize: 11.5),
                                 )
                               ],
                             ),
                             Column(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 CircleAvatar(
                                     radius: 15,
                                     backgroundColor: Colors.orange.shade50,
                                     child: Icon(Bootstrap.messenger,
                                         color: Colors.orange, size: 15)),
                                 Text(
                                   'Comments',
                                   style: GoogleFonts.robotoCondensed(
                                       fontSize: 11.5),
                                 )
                               ],
                             ),
                             Column(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 CircleAvatar(
                                     radius: 15,
                                     backgroundColor: Colors.brown.shade50,
                                     child: Icon(FontAwesome.share,
                                         color: Colors.brown, size: 15)),
                                 Text(
                                   'Share',
                                   style: GoogleFonts.robotoCondensed(
                                       fontSize: 11.5),
                                 )
                               ],
                             ),
                             Column(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 GestureDetector(
                                   onTap: () => Navigator.pop(context),
                                   child: CircleAvatar(
                                       radius: 15,backgroundColor: Colors.red.shade50,
                                       child: Icon(IonIcons.exit, color: Colors.red, size: 17)
                                   ),
                                 ),

                                 Text('Exit', style: GoogleFonts.robotoCondensed(fontSize: 11.5),)
                               ],
                             ),
                           ],
                         ),
                       ),
                     ),

                     /// ListView ..........................................
                     Container(
                       margin: EdgeInsets.only(top:Get.height/5+30),
                       child:Column(
                         children: [
                           /// Title Section ...............................
                           Container(
                             alignment: Alignment.centerLeft,
                             margin: EdgeInsets.only(top: 50, bottom: 7, left: 10, right: 10),
                             child: Text('${postTitle?.capitalize}',
                                 style:GoogleFonts.poppins(color:Colors.lightBlue,fontWeight: FontWeight.w500)
                             ),
                           ),

                           /// DATE & TIME  SECTION .........................
                           Padding(
                               padding: EdgeInsets.only(left: 10, right: 10, bottom: 7),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text('🕒	${postcreateAt.toString().substring(11, 16)} time ago',
                                       style: GoogleFonts.roboto(color: Colors.black54, fontSize: 10)
                                   ),

                                   Text('📅 ${postcreateAt.toString().substring(0, 10)}',
                                           style: GoogleFonts.ptSerif(color: Colors.black,
                                           fontSize: 12,fontWeight: FontWeight.w500)
                                   ),
                                 ],
                               )),

                           /// Post Images Or Videos Section .............................
                           postMediaType == 'image'
                               ? Container(
                               height: Get.height / 4,
                               width: Get.width,
                               margin: EdgeInsets.all(9),
                               decoration: BoxDecoration(
                                   color: Colors.grey.shade200,
                                   borderRadius: BorderRadius.circular(7),
                                   boxShadow: const [
                                     BoxShadow(
                                         color: Colors.black26,
                                         blurRadius: 7,
                                         spreadRadius: -4)
                                   ]),
                               child: Stack(
                                 children: [
                                   ClipRRect(
                                     borderRadius: BorderRadius.circular(7),
                                     child: CachedNetworkImage(
                                       imageUrl: Urls.mainurl + postSource!,
                                       height: Get.height / 4,
                                       width: Get.width,
                                       fit: BoxFit.cover,
                                       placeholder: (context, url) => Center(
                                           child: CircularProgressIndicator(
                                               color: Colors.blueAccent,
                                               strokeWidth: 2)),
                                       errorWidget: (context, url, error) =>
                                           Icon(Icons.image_search, color: Colors.red),
                                     ),
                                   ),
                                   Positioned(
                                       left: 5,
                                       top: 5,
                                       child: Shimmer.fromColors(
                                           baseColor: Colors.white,
                                           highlightColor: Colors.black26,
                                           period: Duration(seconds: 10),
                                           child: Icon(HeroIcons.photo, size: 20)))
                                 ],
                               ))
                               : postMediaType == 'video'
                               ? Container(
                               width: Get.width,
                               margin: EdgeInsets.all(9),
                               decoration: BoxDecoration(
                                   color: Colors.grey.shade200,
                                   borderRadius: BorderRadius.circular(7),
                                   boxShadow: const [
                                     BoxShadow(
                                         color: Colors.black26,
                                         blurRadius: 7,
                                         spreadRadius: -4)
                                   ]),
                               child: Stack(
                                 children: [
                                   ClipRRect(
                                       borderRadius: BorderRadius.circular(7),
                                       child: VideoPlayNetwork(pathh: postSource)),
                                   Positioned(
                                       left: 5,
                                       top: 5,
                                       child: Shimmer.fromColors(
                                           baseColor: Colors.white,
                                           highlightColor: Colors.black26,
                                           period: Duration(seconds: 5),
                                           child: Icon(HeroIcons.video_camera,
                                               size: 20)))
                                 ],
                               ))
                               : postMediaType == 'text'
                               ? Container()
                               : SizedBox(),

                           /// Description Section .....................
                           Container(
                               alignment: Alignment.centerLeft,
                               margin: EdgeInsets.only(left:10, right:10, bottom:7),
                               child: Column(
                                 children: [
                                   Text('$postDescri', style: Utils.postDescripStyle),
                                 ],
                               )),
                           Divider(),

                         ],
                       ),
                     )
                   ],
                 )
              ],
            )
        )
    );
  }
}
