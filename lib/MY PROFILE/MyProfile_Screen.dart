// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_const_literals_to_create_immutables, avoid_print, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:linkedin_clone/POSTS/AddPost_Screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../DRAWER CLS/Drawerr_cls.dart';
import '../POSTS/ViewPost_Screen.dart';
import '../STATIC CLS/Static_class.dart';
import '../UPDATE PROFILE/UpdateProfile_Screen.dart';
import '../VIDEO CONTROLLERS/VideoController_network.dart';
import 'UpdatePost_Screen.dart';

class MyProfile_Screen extends StatefulWidget {
  const MyProfile_Screen({Key? key}) : super(key: key);

  @override
  State<MyProfile_Screen> createState() => _MyProfile_ScreenState();
}

class _MyProfile_ScreenState extends State<MyProfile_Screen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getxController.myProfileController.FetchUserData();
    getxController.myPostController.FetchMyPost_ApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Utils.scaffoldColor,

      appBar: AppBar(
        toolbarHeight:55,
        backgroundColor:Colors.white,elevation: 0, centerTitle:true,
        iconTheme: IconThemeData(color:Colors.blueAccent),
        actionsIconTheme:IconThemeData(color:Colors.blueAccent),
        title: Text("Your Profile", style: GoogleFonts.ptSansCaption(
            fontSize:16,color:Colors.blueAccent,fontWeight:FontWeight.w600)
        ),
        leading:IconButton(
            splashColor: Colors.transparent,highlightColor:Colors.transparent,
            onPressed:() {
              scaffoldKey.currentState!.openDrawer();
            },icon: Icon(BoxIcons.bx_grid_horizontal)
        ),
      ),

      drawer: Drawerr(),

      body: ScrollConfiguration(
        behavior: ScrollBehavior(

        ),
        child: ListView(
          children: [
            Container(
              height: Get.height/3-20,
              margin: EdgeInsets.only(bottom:10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.vertical(bottom: Radius.circular(30)),
                  boxShadow:[BoxShadow(color:Colors.black12,blurRadius:6,spreadRadius:-5)]
              ),
              child: Stack(
                children: [
                  /// PROFILE COVER & LOGOUT BUTTON
                  Container(
                    height:Get.height/4-40,width:Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,image: DecorationImage(
                        image: AssetImage('assets/myimgs/Techinfo Profile Cover Image.png'),
                        fit: BoxFit.fitWidth,opacity:0.3),
                    ),
                    child:Align( alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top:10,bottom:10,right:10),
                                child: SizedBox(
                                  height:38,width:115,
                                  child: FloatingActionButton.extended(
                                      elevation:0,
                                      shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                                      backgroundColor: Colors.white,
                                      onPressed: () {
                                        Dialogs.Logout_Dialog(context,setState);
                                      },icon:Icon(BoxIcons.bx_log_out, color: Colors.red.shade400,size:18),
                                      label: Text('Logout?',style:GoogleFonts.roboto(color:Colors.red.shade400))
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  /// PROFILE PIC & USER NAME SECTION ................
                  Padding(
                    padding: EdgeInsets.only(top:80,left:25),
                    child: Row(
                      children: [

                        /// PROFILE PIC ..........................
                        Container(
                            height:105,width:105,
                            margin: EdgeInsets.only(bottom:10),alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:Colors.white,borderRadius: BorderRadius.circular(100),
                              boxShadow: [BoxShadow(color:Colors.blue.shade100,blurRadius:10,spreadRadius:-3)],
                            ),
                            child: SizedBox(
                              height:105,width:105,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Userdata.UserImage == null || Userdata.UserImage == '' ?
                                Center(child: Text(Userdata.UserName.toString().toUpperCase().substring(0,1),
                                    style:GoogleFonts.ptSans(fontSize:55,
                                        fontWeight:FontWeight.w600,color:Colors.white))
                                ) :
                                CachedNetworkImage(
                                  imageUrl: Urls.mainurl + Userdata.UserImage.toString(),fit:BoxFit.cover,
                                  placeholder: (context, url) {
                                    return CircularProgressIndicator(
                                        color:Colors.blueAccent.shade700,strokeWidth:2.5);
                                  },
                                  errorWidget: (context, url, error) {
                                    return Center(child: Text(Userdata.UserName.toString().toUpperCase().substring(0,1),
                                        style:GoogleFonts.ptSans(fontSize:55,
                                            fontWeight:FontWeight.w600,color:Colors.indigo))
                                    );
                                  },
                                ),
                              ),
                            )
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// USER NAME ...........................
                            Padding(
                              padding: EdgeInsets.only(top:67,left:11),
                              child: Row(
                                children: [
                                  Icon(LineAwesome.user_circle_solid),SizedBox(width:5),
                                  Text('${Userdata.UserName}',style: GoogleFonts.poppins(
                                      color:Colors.black,fontWeight: FontWeight.w500,fontSize:15.5)
                                  ),
                                ],
                              ),
                            ),

                            /// USER POSTS ...........................
                            Padding(
                              padding: EdgeInsets.only(top:5,left:15),
                              child: Row(
                                children: [
                                  Icon(Bootstrap.camera,size:14),SizedBox(width:5),
                                  Obx((){
                                    return Text('My Post :'
                                        ' ${getxController.myPostController.mypostModel.value.business == null
                                        ? 0
                                        : getxController.myPostController.mypostModel.value.business!.post!.length}',
                                      style: GoogleFonts.poppins(color:Colors.black,fontSize:12,height:1.6),
                                    );
                                  })
                                ],
                              ),
                            ),


                            /// UPDATE PROFILE BUTTON ...........................................
                            InkWell(
                              onTap:() {
                                Navigator.push(context,MaterialPageRoute(builder:(context) {
                                  return UpdateProfile_Screen();
                                },));
                              },
                              child: Container(
                                  height:35,width:Get.width/3,
                                  margin: EdgeInsets.only(top:10,left:15),
                                  decoration:BoxDecoration(
                                      color:Colors.blueAccent,borderRadius:BorderRadius.circular(10),
                                      gradient:LinearGradient(colors: [
                                        Colors.blueAccent.shade700,Colors.blue.shade500,Colors.blueAccent.shade700
                                      ])
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Update Profile',style:GoogleFonts.ptSans(color:Colors.white,fontSize:13)),
                                      Icon(Bootstrap.pencil_fill,color:Colors.white,size:13)
                                    ],
                                  )
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  ///ACTIVE DOT
                  Positioned(
                      top:185,left:105,
                      child: CircleAvatar(
                        radius:11,backgroundColor:Colors.grey.shade100,
                        child:CircleAvatar(radius:6.5,backgroundColor:Colors.green,),
                      )
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:7,bottom:7,left:13),
              child: Text('Account Details',
                style:GoogleFonts.poppins(fontWeight:FontWeight.w500),),
            ),

            Padding(
              padding: EdgeInsets.only(top:5,left:10,right:10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color:Colors.black12,blurRadius:7,spreadRadius:-5)]
                ),
                child: ListTile(
                  dense:true,
                  leading:CircleAvatar( radius:15,backgroundColor:Colors.brown.shade100.withOpacity(0.6),
                    child:Icon(EvaIcons.email,size:17,color:Colors.brown),
                  ),
                  title: Text('Email-Id',style:GoogleFonts.ptSerifCaption(),),
                  trailing: Userdata.UserEmail == null || Userdata.UserEmail == '' ?

                  GestureDetector( onTap: () => Get.to(UpdateProfile_Screen()),
                    child: Text('+ Add Email?',
                        style:GoogleFonts.ptSansCaption(fontSize:13,color:Colors.black38)
                    ),
                  ) :

                  Text('${Userdata.UserEmail}',
                    style:GoogleFonts.ptSansCaption(fontSize:13.5,color:Colors.blue)
                  ),
                ),
              ),
            ),

            Userdata.UserPhone == null || Userdata.UserPhone == '' ? SizedBox() :
            Padding(
              padding: EdgeInsets.only(top:10,left:10,right:10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color:Colors.black12,blurRadius:7,spreadRadius:-5)]
                ),
                child: ListTile(
                  dense:true,
                  leading:CircleAvatar( radius:15,backgroundColor:Colors.green.shade100.withOpacity(0.6),
                    child:Icon(EvaIcons.phone_call,size:16,color:Colors.green),
                  ),
                  title: Text('Contact No.',style:GoogleFonts.ptSerifCaption(),),
                  trailing:Text('+91${Userdata.UserPhone}',
                    style:GoogleFonts.roboto(fontSize:13,color:Colors.blue,height:1.7)
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:10,left:10,right:10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color:Colors.black12,blurRadius:7,spreadRadius:-5)]
                ),
                child: ListTile(
                  dense:true,
                  leading:CircleAvatar( radius:15,backgroundColor:Colors.orange.shade100.withOpacity(0.6),
                    child:Icon(Bootstrap.building_fill,size:16,color:Colors.orange),
                  ),
                  title: Text('State',style:GoogleFonts.ptSerifCaption(),),
                  trailing:Userdata.UserState == null || Userdata.UserState == '' ?

                  GestureDetector( onTap: () => Get.to(UpdateProfile_Screen()),
                    child: Text('+ Add State',
                      style:GoogleFonts.ptSansCaption(fontSize:13,color:Colors.black38)
                    ),
                  ) :

                  Text('${Userdata.UserState}',
                      style:GoogleFonts.ptSansCaption(fontSize:13.5,color:Colors.blue)
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:10,left:10,right:10,bottom:10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color:Colors.black12,blurRadius:7,spreadRadius:-5)]
                ),
                child: ListTile(
                  dense:true,
                  leading:CircleAvatar( radius:15,backgroundColor:Colors.blue.shade100.withOpacity(0.6),
                    child:Padding(
                      padding: const EdgeInsets.only(right:4),
                      child: Icon(FontAwesome.city,size:12.5,color:Colors.blueAccent),
                    ),
                  ),
                  title: Text('City',style:GoogleFonts.ptSerifCaption(),),

                  trailing:Userdata.UserCity == null || Userdata.UserCity == '' ?

                  GestureDetector( onTap: () => Get.to(UpdateProfile_Screen()),
                    child: Text('+ Add City',
                        style:GoogleFonts.ptSansCaption(fontSize:13,color:Colors.black38)
                    ),
                  ) :

                  Text('${Userdata.UserCity}',
                    style:GoogleFonts.ptSansCaption(fontSize:13.5,color:Colors.blue)
                  )

                ),
              ),
            ),

            /// MY POST SECTION ........
            Padding(
              padding: EdgeInsets.only(top:7,left:12),
              child: Text('Your Posts', style:GoogleFonts.poppins(
                  fontWeight:FontWeight.w500,color:Colors.black)),
            ),
            SizedBox(height:10),

            Obx((){
             return getxController.myPostController.mypostModel.value.business == null ?
             Center(child: CircularProgressIndicator(color:Colors.blueAccent,strokeWidth:2)) :
             getxController.myPostController.mypostModel.value.business!.post!.isEmpty ?
             NoPosts_widget() :

             ListView.builder(
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
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
                   margin:EdgeInsets.only(bottom:10,left:10,right:10),
                   padding: EdgeInsets.only(bottom:10,left:7,right:7),
                   decoration:BoxDecoration(
                     color: Colors.white,borderRadius: BorderRadius.circular(10),
                     border: Border.all(color: Colors.black45,width:0.4),
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
          ],
        ),
      ),
    );
  }
}

NoPosts_widget(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height:60,width:60,margin:EdgeInsets.only(top:20,bottom:7),
        decoration:BoxDecoration(
            shape:BoxShape.circle,border:Border.all(color:Colors.black38)
        ),
        child:Icon(Bootstrap.camera,color:Colors.black45),
      ),
      Text('No Posts Yet',style:GoogleFonts.ptSans(fontSize:13,color:Colors.black45),),

      GFButton(
        size:30,text: 'Create New Post?',
        textStyle:GoogleFonts.ptSans(fontSize: 13,color:Colors.white),
        onPressed:() {
          Get.to(AddPost_Screen());
        },
      ),
    ],
  );
}


PostStatus_Button(postStatus,postId){
  return GestureDetector(
    onTap: () {
      print('Post Id ===> $postId');
    },
    child: Container(
        margin: EdgeInsets.only(right:7),
        padding: EdgeInsets.symmetric(horizontal:9,vertical:6),
        decoration: BoxDecoration(
          color:postStatus == 'pending' ?
          Colors.blue.shade50 : Colors.green.shade50,
          borderRadius:BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            postStatus == 'pending' ?
            Icon( Icons.watch_later_outlined,size:15,color:Colors.blueAccent) :
            Icon(IonIcons.checkmark_circle,size:15,color:Colors.green),

            SizedBox(width:5),

            Text(
              postStatus == 'pending' ? 'Pending' : 'Approved',
              style:GoogleFonts.notoSerif(
                  fontSize:10,fontWeight:FontWeight.w600,
                  color: postStatus == 'pending' ? Colors.blueAccent : Colors.green
              ),
              textAlign: TextAlign.center,
            ),
          ],
        )
    ),
  );
}
