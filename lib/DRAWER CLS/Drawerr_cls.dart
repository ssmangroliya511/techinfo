// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../SCREENS/BottomHome_Screen.dart';
import '../SCREENS/NewPost_Screen.dart';
import '../SCREENS/Profile_Screen.dart';
import '../STATIC CLS/Static_class.dart';

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
              padding:EdgeInsets.only(left:15),
              color:Colors.white,
              child:Column(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius:35,child:Image.asset('myimgs/User No Profile Dp.png'),
                  ),
                  Text('Sagar Mangroliya',style:GoogleFonts.ptSans(fontSize:19,fontWeight:FontWeight.w600),),
                  InkWell(onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder:(context) {
                      return Profile_Screen();
                    },));
                  },child: Text('+917046379090',style:GoogleFonts.ptSans(fontSize:14),))
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
                  return Profile_Screen();
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
                  return NewPost_Screen();
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
                Dialogs.Logout_Dialog(context);
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
