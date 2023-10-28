// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../MY PROFILE/MyProfile_Screen.dart';
import '../SCREENS/BottomHome_Screen.dart';
import '../POSTS/AddPost_Screen.dart';
import '../STATIC CLS/Static_class.dart';
import '../UPDATE PROFILE/UpdateProfile_Screen.dart';

class Drawerr extends StatefulWidget {
  const Drawerr({Key? key}) : super(key: key);

  @override
  State<Drawerr> createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    packageINFO();
  }

  packageINFO() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Var.AppVersion = packageInfo.version;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            Container(
              height:Get.height/4-30,width:Get.width/2,
              margin:EdgeInsets.only(bottom:10),
              color:Colors.white,
              child:Column(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                      height:90,width:90,
                      margin: EdgeInsets.only(bottom:10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.blueAccent),
                        boxShadow: [BoxShadow(color:Colors.black26,blurRadius:15,spreadRadius:-5)],
                      ),
                      child: InkWell(
                        borderRadius:BorderRadius.circular(100),
                        onTap:(){
                          Navigator.pop(context);
                          Get.to(MyProfile_Screen());
                        },
                        child: SizedBox(
                          height:90,width:90,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Userdata.UserImage == null ?
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
                        ),
                      )
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LineAwesome.user,size:18),
                      Icon(LineAwesome.user,size:18),
                      Padding(
                        padding: EdgeInsets.only(left:7),
                        child: Text('${Userdata.UserName}',
                          style:GoogleFonts.ptSans(fontSize:15,fontWeight:FontWeight.w500),),
                      ),
                    ],
                  ),

                  SizedBox(height:5),

                  Userdata.UserPhone == null || Userdata.UserPhone == '' ?
                  SizedBox() :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LineAwesome.phone_alt_solid,size:17),SizedBox(width:5),

                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Get.to(MyProfile_Screen());
                        },child: Text('+91${Userdata.UserPhone}',
                          style:GoogleFonts.ptSans(fontSize:13,color:Colors.black)
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
            /// LISTTILS...........
            ListTile(
              leading: Icon(HeroIcons.home, color: Colors.black,size:23),
              title: Text("Home",style: GoogleFonts.ptSansCaption(fontSize:14)),
              trailing: Icon(CupertinoIcons.right_chevron,size:15,color:Colors.blueAccent.shade100),
              tileColor:Colors.white,dense:true,
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder:(context) {
                   return BottomHome_Screen();
                 },));
              },
            ),
            SizedBox(height:10),

            ListTile(
              leading: Icon(HeroIcons.user_circle, color: Colors.black,size:23),
              title: Text("View Profile",style: GoogleFonts.ptSansCaption(fontSize:14)),
              trailing: Icon(CupertinoIcons.right_chevron,size:15,color:Colors.blueAccent.shade100),
              tileColor:Colors.white,dense:true,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder:(context) {
                  return MyProfile_Screen();
                },));
              },
            ),
            SizedBox(height:10),

            ListTile(
              leading: Icon( Iconsax.additem,color: Colors.black),
              title: Text("New Post", style: GoogleFonts.ptSansCaption(fontSize:14)),
              trailing: Icon(CupertinoIcons.right_chevron,size:15,color:Colors.blueAccent.shade100),
              tileColor:Colors.white,dense:true,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder:(context) {
                  return AddPost_Screen();
                },));
              },
            ),
            SizedBox(height:10),

            ListTile(
                leading: Icon(IonIcons.settings, color: Colors.black,size:22),
                title: Text("Settings",
                    style: GoogleFonts.ptSansCaption(fontSize: 14)),
                trailing: Icon(CupertinoIcons.right_chevron,size:15,color:Colors.blueAccent.shade100),
                tileColor:Colors.white,dense:true,
                onTap: () {}
            ),
            SizedBox(height:30),

            ListTile(
              leading: Icon(Bootstrap.info, color: Colors.blue),
              title: Text("About",style:GoogleFonts.ptSansCaption(fontSize:14,
                     fontWeight:FontWeight.w400,color:Colors.blue)),
              tileColor:Colors.white,dense:true,
              onTap: () {},
            ),
            SizedBox(height:10),

            ListTile(
              leading: Icon(EvaIcons.log_out, color: Colors.red),
              title: Text("Logout",style:GoogleFonts.ptSansCaption(
                     fontSize:14,color:Colors.red)),
              tileColor:Colors.white,dense:true,
              onTap: ()  {
                Navigator.pop(context);
                Dialogs.Logout_Dialog(context,setState);
              },
            ),
            Var.AppVersion == null ? SizedBox() : Padding
              (padding: EdgeInsets.only(top:200,left:100),
                child:Text("Version ${Var.AppVersion}",
                    style:GoogleFonts.aBeeZee(fontSize: 14.5,color: Colors.blueAccent.shade200))
            )
          ],
        )
    );
  }
}
