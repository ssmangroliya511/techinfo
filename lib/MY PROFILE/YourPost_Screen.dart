// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, unrelated_type_equality_checks, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:linkedin_clone/MY%20PROFILE/MyPosts_Controller.dart';
import 'package:linkedin_clone/POSTS/AddPost_Screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../POSTS/ViewPost_Screen.dart';
import '../STATIC CLS/Static_class.dart';
import '../VIDEO CONTROLLERS/VideoController_network.dart';
import 'MyProfile_Screen.dart';
import 'UpdatePost_Screen.dart';

class YourPost_Screen extends StatefulWidget {
  const YourPost_Screen({Key? key}) : super(key: key);

  @override
  State<YourPost_Screen> createState() => _YourPost_ScreenState();
}

class _YourPost_ScreenState extends State<YourPost_Screen> {
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();

  MyPostController myPostController = Get.put(MyPostController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myPostController.FetchMyPost_ApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey1,

      appBar : Widget_Appbar(),

      body:ScrollConfiguration(behavior: ScrollBehavior(
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch
      ),
        child:  Obx((){
          return getxController.myPostController.mypostModel.value.business == null ?
          Center(child: CircularProgressIndicator(color:Colors.blueAccent,strokeWidth:2)) :
          getxController.myPostController.mypostModel.value.business!.post!.isEmpty ?
          Center(child:NoPosts_widget()) :

          ListView.builder(
            shrinkWrap: true,
            itemCount: getxController.myPostController.mypostModel.value.business!.post!.length,
            itemBuilder: (context, index) {
              dynamic INDEX         = index;
              dynamic postId        = getxController.myPostController.mypostModel.value.business!.post![index].postId.toString();
              dynamic postTitle     = getxController.myPostController.mypostModel.value.business!.post![index].pTitle.toString();
              dynamic postDescri    = getxController.myPostController.mypostModel.value.business!.post![index].pDesc.toString();
              dynamic postcreateAt  = getxController.myPostController.mypostModel.value.business!.post![index].createdAt.toString();
              dynamic postSource    = getxController.myPostController.mypostModel.value.business!.post![index].source.toString();
              dynamic postMediaType = getxController.myPostController.mypostModel.value.business!.post![index].mediaType.toString();
              dynamic postStatus    = getxController.myPostController.mypostModel.value.business!.post![index].status.toString();
              dynamic userImage     = Userdata.UserImage;
              dynamic userName      = Userdata.UserName;

              return Container(
                width:Get.width,
                margin:EdgeInsets.only(bottom:10,left:2,right:2),
                padding: EdgeInsets.only(bottom:10,left:7,right:7),
                decoration:BoxDecoration(
                    color: Colors.white,borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color:Colors.black26,blurRadius:5,spreadRadius:-5)]
                ),

                child:Column(
                  children: [

                    /// Profile Pic/Name Section .....................
                    ListTile(
                        contentPadding: EdgeInsets.only(left:1,right:5),
                        dense: true,
                        leading:CircleAvatar(
                          radius:20,backgroundColor:Colors.grey.shade200,
                          child:
                          Userdata.UserImage == null || Userdata.UserImage == '' ?
                          Text(Userdata.UserName.toString().substring(0,1).toUpperCase(),
                            style:GoogleFonts.pacifico(color:Colors.orange,
                                fontWeight:FontWeight.w500,fontSize:18),
                          ) :
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: Urls.mainurl + Userdata.UserImage.toString(),
                              height:Get.height/4,width:Get.width,fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(color:Colors.blueAccent,strokeWidth:2)
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.image_search,color:Colors.red,),
                            ),
                          ),
                        ),
                        title:RichText(
                          text:TextSpan(text:'You \t ',
                              style:GoogleFonts.poppins(color:Colors.black,
                                  fontWeight:FontWeight.w500,fontSize:12.5),

                              children: [
                                TextSpan(
                                    text:postcreateAt.toString().substring(0,10),
                                    style:GoogleFonts.ptSerif(color:Colors.blueGrey,fontSize:11)
                                )
                              ]
                          ),
                        ),

                        subtitle: RichText(
                          text: TextSpan(text:postcreateAt.toString().substring(11,16),
                              style:GoogleFonts.roboto(color:Colors.black45,fontSize:10),

                              children: [
                                TextSpan(text:'\t o\'clock ago',style:GoogleFonts.roboto(
                                    color:Colors.black45,fontSize:10)
                                )
                              ]
                          ),
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            PostStatus_Button(postStatus,postId),

                            /// UPDATE POST BUTTON.......................
                            Padding(
                                padding:EdgeInsets.only(right:7),
                                child:  GestureDetector(
                                  onTap: () {
                                    dynamic postID = postId;
                                    dynamic index = INDEX;
                                    Get.to(UpdatePost_Screen(postID,index));
                                    // getxController.updatePostController.isLoading.value = false;
                                  },
                                  child: CircleAvatar(
                                      radius:13,backgroundColor:Colors.orange,
                                      child: Icon(Iconsax.edit,size:15,color:Colors.white)
                                  ),
                                )
                            ),

                            /// DELETE POST BUTTON............
                            Obx((){
                              return !getxController.deletePostController.isLoading.value ?
                              GestureDetector(
                                  onTap: () {
                                    Var.postId = getxController.myPostController.mypostModel.value.business!.post![index].postId.toString();
                                    getxController.deletePostController.FetchDeletePost_ApiData();
                                    getxController.myPostController.FetchMyPost_ApiData();
                                    getxController.homeController.FetchAllPost_ApiData();
                                  },
                                  child: CircleAvatar(
                                      radius:13,backgroundColor:Colors.red,
                                      child: Icon(CupertinoIcons.delete,size:15,color:Colors.white)
                                  )
                              ) : Lottie.asset('assets/mylottie/Dot Loading Animation.json');
                            })
                          ],
                        )
                    ),
                    Divider(),

                    /// Title Section .....................
                    Container(
                      alignment: Alignment.centerLeft,
                      margin:EdgeInsets.only(left:2,right:5,top:5,bottom:10),
                      child:Text('$postTitle', style:Utils.posttitleStyle),
                    ),

                    /// Post Images Or Videos Section .............................
                    postMediaType == 'image' ?
                    Container(
                        height: Get.height/4,width: Get.width,
                        decoration: BoxDecoration(
                            color:Colors.grey.shade200,borderRadius: BorderRadius.circular(7),
                            boxShadow: [BoxShadow(color:Colors.black26,blurRadius:7,spreadRadius:-4)]
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: Urls.mainurl + postSource,
                                height:Get.height/4,width:Get.width,fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                    child:CircularProgressIndicator(color:Colors.blueAccent,strokeWidth:2)
                                ),
                                errorWidget:(context, url, error) => Icon(Icons.image_search,color:Colors.red),
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
                        :
                    postMediaType == 'video' ?
                    Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            color:Colors.grey.shade200,borderRadius: BorderRadius.circular(7),
                            boxShadow: [BoxShadow(color:Colors.black26,blurRadius:7,spreadRadius:-4)]
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: VideoPlayNetwork(
                                    pathh:getxController.myPostController.mypostModel.value.business!.post![index].source.toString()
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
                        : postMediaType == 'text' ? Container() : SizedBox(),

                    /// Description Section .....................................
                    Container(
                        alignment: Alignment.centerLeft,
                        margin:EdgeInsets.only(top:10,left:5,right:5),
                        child: Column(
                          children: [
                            Text(postDescri,style:Utils.postDescripStyle,maxLines:5),

                            postDescri.isEmpty ? SizedBox() :
                            Align(
                                alignment:Alignment.topRight,
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      Var.postId = postId;
                                    });
                                    Get.to(
                                        ViewPost_Screen(
                                            postTitle, postDescri, postcreateAt,postSource,
                                            postMediaType,userImage,userName)
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
                  ],
                ),
              );
            },);
        })

       ),
     );
  }

  Widget_Appbar(){
    return AppBar(
      toolbarHeight:55,
      backgroundColor:Colors.white,elevation:0, centerTitle:true,
      iconTheme: IconThemeData(color:Colors.blueAccent),
      actionsIconTheme:IconThemeData(color:Colors.blueAccent),
      leading:IconButton(
          splashColor: Colors.transparent,highlightColor:Colors.transparent,
          onPressed:() {
            scaffoldKey1.currentState!.openDrawer();
          },icon: Icon(BoxIcons.bx_grid_horizontal)
      ),
      title:Text('Your Posts', style: GoogleFonts.ptSansCaption(
          fontSize:16,color:Colors.blueAccent,fontWeight:FontWeight.w600)),
    );
  }



  NoPost_Widget(){
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height:50,width:50,margin:EdgeInsets.only(bottom:7),
              decoration:BoxDecoration(
                  shape:BoxShape.circle,border:Border.all(color:Colors.black38)
              ),
              child:Icon(Bootstrap.camera,color:Colors.black45,size:20),
            ),
            Text('You Not Create Any Post Yet !!',
              style:GoogleFonts.ptSans(fontSize:13,color:Colors.black45),),
            SizedBox(height:5),
            GFButton(onPressed:() {
                  Navigator.push(context,MaterialPageRoute(builder:(context) {
                   return AddPost_Screen();
                 },));
               },
               text: 'Create Post ?', textStyle: GoogleFonts.ptSans(),
               icon: Icon(Icons.post_add_rounded,color:Colors.white,size:20),
            )
          ],
        ),
     );
  }
}

