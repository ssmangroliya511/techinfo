// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_import, camel_case_types, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, avoid_print

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:getwidget/getwidget.dart';
import 'package:linkedin_clone/HOME/Home_Controller.dart';
import 'package:linkedin_clone/POSTS/ViewPost_Screen.dart';
import 'package:linkedin_clone/WEB%20SCREENS/Dashboard_Screen.dart';
import 'package:linkedin_clone/POSTS/AddPost_Screen.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../DRAWER CLS/Drawerr_cls.dart';
import '../STATIC CLS/Static_class.dart';
import '../VIDEO CONTROLLERS/VideoController_network.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  // HomeController homeController = Get.put(HomeController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
    getxController.homeController.FetchAllPost_ApiData();
  }

  getPermission() async {

    DeviceInfoPlugin plugin = DeviceInfoPlugin();

    AndroidDeviceInfo android = await plugin.androidInfo;

    if (android.version.sdkInt < 33)
    {
      if (await Permission.storage.request().isGranted) {
        setState(() {
          Var.permissionGranted = true;
        });
      }
      else if (await Permission.audio.request().isDenied) {
        setState(() {
          Var.permissionGranted = false;
        });
      }
    }
    else
    {
      if (await Permission.photos.request().isGranted) {
        setState(() {
          Var.permissionGranted = true;
        });
      }
      else if (await Permission.photos.request().isDenied) {
        setState(() {
          Var.permissionGranted = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      key: scaffoldKey,

      appBar : isSearch ? Widget_SearchAppbar() : Widget_DefaultAppbar(),

      drawer: Drawerr(),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch
        ),
        child: Obx((){
          return getxController.homeController.homeallPostModel.value.business == null ?
          Center(child:Lottie.asset('assets/mylottie/Dot Loading Animation.json',height:70,width:70)) :
          getxController.homeController.homeallPostModel.value.business!.post!.isEmpty ?
          NoPosts_widget() :

          ListView.builder(
            // controller: homeController.scrollController.value,
            itemCount:getxController.homeController.homeallPostModel.value.business!.post!.length,
            itemBuilder: (context, index) {

              var postId        = getxController.homeController.homeallPostModel.value.business!.post![index].postId.toString();
              var postTitle     = getxController.homeController.homeallPostModel.value.business!.post![index].pTitle.toString();
              var postDescri    = getxController.homeController.homeallPostModel.value.business!.post![index].pDesc.toString();
              var postcreateAt  = getxController.homeController.homeallPostModel.value.business!.post![index].createdAt.toString();
              var postSource    = getxController.homeController.homeallPostModel.value.business!.post![index].source.toString();
              var postMediaType = getxController.homeController.homeallPostModel.value.business!.post![index].mediaType.toString();
              var userImage     = getxController.homeController.homeallPostModel.value.business!.post![index].uImage.toString();
              var userName      = getxController.homeController.homeallPostModel.value.business!.post![index].uName.toString();

              return Container(
                margin:EdgeInsets.only(bottom:8),
                padding: EdgeInsets.only(bottom:5),
                width:Get.width,color:Colors.white,
                child:Column(
                  children: [

                    /// Profile Pic/Name Section .....................
                    ListTile(
                        contentPadding: EdgeInsets.only(left:10,right:7),
                        leading:CircleAvatar(
                          radius:20,backgroundColor:Colors.grey.shade200,
                          child:
                          userImage.isEmpty || userImage == '' || userImage == 'null' ?
                          Text(userName.toString().substring(0,1).toUpperCase(),
                            style:GoogleFonts.pacifico(color:Colors.blueAccent.shade700,
                                fontWeight:FontWeight.w500,fontSize:18),
                          ) :
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: Urls.mainurl + userImage.toString(),
                              height:Get.height/4,width:Get.width,fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(color:Colors.blueAccent,strokeWidth:2)
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.image_search,color:Colors.red,),
                            ),
                          ),
                        ),
                        /// USER NAME & DATE ....................................
                        title:RichText(
                          text:TextSpan(text:'${userName} \t ',
                              style:GoogleFonts.robotoSlab(
                                  color:Colors.black, fontSize:13,fontWeight:FontWeight.w500),

                              children: [
                                TextSpan(
                                    text:postcreateAt.toString().substring(0,10),
                                    style:GoogleFonts.ptSerif(color:Colors.black,fontSize:12.5)
                                )
                              ]
                          ),
                        ),

                        /// TIME ....................................
                        subtitle:RichText(
                          text: TextSpan(text:'${postcreateAt}'.toString().substring(11,16),
                                   style:GoogleFonts.roboto(color:Colors.black,fontSize:10),

                              children: [
                                TextSpan(text:'\t o\'clock ago',style:GoogleFonts.roboto(
                                    color:Colors.black,fontSize:10)
                                )
                              ]
                          ),
                        ),
                        /// VIEW POST BUTTON ....................................
                        trailing: SizedBox(
                          height:27,width:Get.width/3-27,
                          child: GFButton(
                            elevation: 0,highlightElevation:0,
                              splashColor: Colors.blueAccent.shade100,
                            text:'View Post',textStyle:GoogleFonts.ptSans(
                              fontSize:12,color:Utils.appColor
                            ),
                            icon:Icon(Bootstrap.view_list,size:13,color:Utils.appColor),
                            type: GFButtonType.outline,
                            onPressed: (){
                              Var.postId = postId;
                              Get.to(ViewPost_Screen(
                                  postTitle, postDescri, postcreateAt, postSource,
                                  postMediaType, userImage, userName
                              )
                              );
                            })
                        )
                    ),
                    SizedBox(height:5),


                    /// Title Section ............................................
                    Container(
                      alignment: Alignment.centerLeft,
                      margin:EdgeInsets.only(left:10,right:10),
                      child: Text('${postTitle.capitalize}',style:Utils.posttitleStyle),
                    ),
                    SizedBox(height:5),

                    
                    /// Post Images Or Videos Section .............................
                    postMediaType == 'image' ?
                    Container(
                      height: Get.height/4,width: Get.width,
                      margin: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color:Colors.grey.shade200,borderRadius: BorderRadius.circular(7),
                        boxShadow: [BoxShadow(color:Colors.black26,blurRadius:7,spreadRadius:-4)]
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: CachedNetworkImage(
                              imageUrl: Urls.mainurl + postSource,
                              height:Get.height/4,width:Get.width,fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(color:Colors.blueAccent,strokeWidth:2)
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.image_search,color:Colors.red),
                            ),
                          ),
                          Positioned(
                              left:5,top:5,
                              child:Shimmer.fromColors(
                                baseColor: Colors.white, highlightColor: Colors.black26,
                                period: Duration(seconds:10),
                                child:Icon(HeroIcons.photo,size:20)
                              )
                          )
                        ],
                      )
                    )
                        : postMediaType == 'video' ?
                    Container(
                      width: Get.width,margin: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                            color:Colors.grey.shade200,borderRadius: BorderRadius.circular(7),
                            boxShadow: [BoxShadow(color:Colors.black26,blurRadius:7,spreadRadius:-4)]
                        ),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: VideoPlayNetwork(
                                  pathh:getxController.homeController.homeallPostModel.value.business!.post![index].source.toString()
                              )
                          ),
                          Positioned(
                              left:5,top:5,
                              child:Shimmer.fromColors(
                                  baseColor: Colors.white, highlightColor: Colors.black26,
                                  period: Duration(seconds:5),
                                  child:Icon(HeroIcons.video_camera,size:20)
                              )
                          )
                        ],
                      )
                    )
                        : postMediaType == 'text' ? 
                    Container() : SizedBox(),


                    /// Description Section .....................
                    Container(
                      alignment: Alignment.centerLeft,
                      margin:EdgeInsets.only(left:10,right:15,bottom:5),
                      child: Column(
                        children: [
                          Text('${postDescri}',style:Utils.postDescripStyle,maxLines:5),

                          postDescri.isEmpty ? SizedBox() :
                          Align(
                              alignment:Alignment.topRight,
                              child: GestureDetector(
                                onTap: (){
                                  Var.postId = postId;
                                  Get.to(ViewPost_Screen(
                                      postTitle, postDescri, postcreateAt, postSource,
                                      postMediaType, userImage, userName
                                    )
                                  );
                                },
                                child: Text('.... Read More', style:GoogleFonts.ptSerif(
                                    fontWeight: FontWeight.w600,fontSize:13),maxLines:5
                                ),
                              )
                          ),
                        ],
                      )
                    ),

                    Divider(),

                    /// Likes & Comments Counts Section ............................
                    SizedBox(
                      height:20,width:Get.width/2+160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                              backgroundColor:Colors.blueGrey.shade100,
                              radius:10,child:Icon(Icons.thumb_up,size:12)
                          ),

                          Text('576',style:GoogleFonts.ptSansCaption(fontSize:11.5),),
                          SizedBox(width:180),

                          Text('120 Comments',style:GoogleFonts.ptSansCaption(fontSize:11.5),)
                        ],
                      ),
                    ),

                    Divider(),


                    /// Like Comment repost share Buttons Section .............
                    Container(
                      height:47,width:Get.width/2+160,
                      // color: Colors.grey.shade100,
                      padding: EdgeInsets.only(left:20,right:20,top:6,bottom:5),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.thumb_up_alt_outlined,size:16,color:Colors.black45,),
                              Text('Like',style:GoogleFonts.ptSans(fontSize:11.5,color:Colors.black45),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height:2),
                              Icon(FontAwesome.message,size:14,color:Colors.black45),
                              SizedBox(height:2),
                              Text('Comment',style:GoogleFonts.ptSans(fontSize:11.5,color:Colors.black45),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(BoxIcons.bx_repost,size:20,color:Colors.black45),
                              Text('Repost',style:GoogleFonts.ptSans(fontSize:11,color:Colors.black45),),
                              SizedBox(height:2),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height:3),
                              Icon(Bootstrap.arrow_90deg_right,size:13,color:Colors.black45),
                              SizedBox(height:3),
                              Text('Share',style:GoogleFonts.ptSans(fontSize:12,color:Colors.black45),)
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },);
        })
      ),
    );
  }

  Widget_DefaultAppbar(){
    return AppBar(
      toolbarHeight:53,
      backgroundColor:Colors.white,elevation: 0.5, centerTitle:true,
      iconTheme: IconThemeData(color:Colors.blueAccent),
      actionsIconTheme:IconThemeData(color:Colors.blueAccent),
      title:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height:22,width:21,alignment: Alignment.center,
            padding: EdgeInsets.only(left:2),
            margin: EdgeInsets.only(right:1),
            decoration:BoxDecoration(color:Colors.blueAccent,borderRadius:BorderRadius.circular(3)),
            child:Text('T',style:GoogleFonts.pacifico(fontSize:16.5,height:1.5)),
          ),
          Text("ech Info", style: GoogleFonts.ptSansCaption(
              fontSize:16,color:Colors.blueAccent,fontWeight:FontWeight.w600,height:1.5)
          ),
        ],
      ),
      leadingWidth:45,
      leading: Padding(
        padding: EdgeInsets.only(left:13),
        child: InkWell(
          splashColor: Colors.transparent,highlightColor: Colors.transparent,
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child:SizedBox(
            height:30,width:40,
            child: CircleAvatar(
              radius:20,backgroundColor:Colors.blue.shade50,
              child:
              Userdata.UserImage == null || Userdata.UserImage == '' ?
              Text(Userdata.UserName.toString().substring(0,1).toUpperCase(),
                style:GoogleFonts.roboto(color:Colors.blueAccent.shade700,
                    fontWeight:FontWeight.w500,fontSize:20),
              ) :
              SizedBox(
                height:32,width:50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: Urls.mainurl + Userdata.UserImage.toString(),
                    height:Get.height/4,width:Get.width,fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(color:Colors.blueAccent,strokeWidth:1)
                    ),
                    errorWidget: (context, url, error){
                      return Center(
                        child: Text(Userdata.UserName.toString().substring(0,1).toUpperCase(),
                          style:GoogleFonts.roboto(color:Colors.blueAccent.shade700,
                              fontWeight:FontWeight.w500,fontSize:20),
                        ),
                      );
                    }
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        /// Add Post Navigate...............
        GestureDetector(
          onTap: () => Get.to(AddPost_Screen()),
          child: CircleAvatar(
            backgroundColor:Colors.blue.shade50,radius:15,
            child:Icon(Bootstrap.camera,size:17)
          ),
        ),

        ///  Search Icon ...............
        Padding(
          padding: EdgeInsets.only(right:10,left:8),
          child: GestureDetector(
            onTap: (){
              setState(() { isSearch = true; });
            },
            child: CircleAvatar(
                backgroundColor:Colors.blue.shade50,radius:15,
                child:Icon(Bootstrap.search,size:15)
            ),
          ),
        ),
      ],
    );
  }

  Widget_SearchAppbar(){
    return AppBar(
      toolbarHeight:53,
      backgroundColor:Colors.white,elevation: 0.5, centerTitle:true,
      iconTheme: IconThemeData(color:Colors.blueAccent),
      actionsIconTheme:IconThemeData(color:Colors.blueAccent),

      /// Search TextField ...........................
      title: TextField(
        onChanged: (value) {
          setState(() {});
        },
        controller:Fieldcontroller.hsearch,
        cursorColor:Colors.blueAccent,cursorWidth:1,cursorHeight:20,
        autofocus: true,
        style:GoogleFonts.ptSansCaption(fontSize:13),
        textInputAction:TextInputAction.done,
        decoration:InputDecoration(
            filled:true,fillColor:Colors.grey.shade200,
            isDense: true, hintText:'Search here . . .',
            hintStyle:GoogleFonts.ptSansCaption(fontSize:12.5),
            constraints:BoxConstraints.loose(Size.fromHeight(35)),
            contentPadding: EdgeInsets.only(top:15),
            enabledBorder: OutlineInputBorder(
              borderRadius:BorderRadius.circular(50),borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:BorderRadius.circular(50),borderSide: BorderSide.none
            ),
            prefixIcon: Icon(Bootstrap.search,size:14),
            suffixIcon: Fieldcontroller.hsearch.text.isNotEmpty ? IconButton(
                splashColor:Colors.transparent,highlightColor:Colors.transparent,
                onPressed: () { setState(() { Fieldcontroller.hsearch.text = ''; } );
            }, icon: Icon(CupertinoIcons.delete_solid,size:16,color:Colors.red)) : SizedBox()
        ),
      ),
      leadingWidth:45,
      leading: Padding(
        padding: EdgeInsets.only(left:13),
        child: InkWell(
          splashColor: Colors.transparent,highlightColor: Colors.transparent,
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child:SizedBox(
            height:30,width:40,
            child: CircleAvatar(
              radius:20,backgroundColor:Colors.blue.shade50,
              child:
              Userdata.UserImage == null || Userdata.UserImage == '' ?
              Text(Userdata.UserName.toString().substring(0,1).toUpperCase(),
                style:GoogleFonts.roboto(color:Colors.blueAccent.shade700,
                    fontWeight:FontWeight.w500,fontSize:20),
              ) :
              SizedBox(
                height:32,width:50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                      imageUrl: Urls.mainurl + Userdata.UserImage.toString(),
                      height:Get.height/4,width:Get.width,fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(color:Colors.blueAccent,strokeWidth:1)
                      ),
                      errorWidget: (context, url, error){
                        return Center(
                          child: Text(Userdata.UserName.toString().substring(0,1).toUpperCase(),
                            style:GoogleFonts.roboto(color:Colors.blueAccent.shade700,
                                fontWeight:FontWeight.w500,fontSize:20),
                          ),
                        );
                      }
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
            splashColor: Colors.transparent,highlightColor:Colors.transparent,
            onPressed: () {
              setState(() {
                isSearch = false;
              });
            }, icon:Icon(CupertinoIcons.clear_circled,color:Colors.blueAccent,size:22))
      ],
    );
  }

  NoPosts_widget(){
    return Column(
      children: [
        Container(
          height:60,width:60,margin:EdgeInsets.only(bottom:7),
          decoration:BoxDecoration(
              shape:BoxShape.circle,border:Border.all(color:Colors.black38)
          ),
          child:Icon(Bootstrap.camera,color:Colors.black45),
        ),
        Text('No Posts Yet',style:GoogleFonts.ptSans(fontSize:13,color:Colors.black45),)
      ],
    );
  }
}
