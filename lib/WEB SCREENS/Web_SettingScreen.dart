// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../POSTS/AddPost_Screen.dart';
import '../STATIC CLS/Static_class.dart';


class Web_SettingScreen extends StatefulWidget {
  const Web_SettingScreen({Key? key}) : super(key: key);

  @override
  State<Web_SettingScreen> createState() => _Web_SettingScreenState();
}

class _Web_SettingScreenState extends State<Web_SettingScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar : Widget_AppBar(),

      body: ResponsiveBuilder(builder: (context, sizingInformation) {

        if(sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return Container();
        }
        return Stack(
          children: [

            Container(
              height: Get.height,width:Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage('assets/myimgs/Login Page Img.jpg'),
                      fit: BoxFit.cover)),
              child: BackdropFilter( filter: ImageFilter.blur(sigmaX:3, sigmaY:3),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),

            Align(
                alignment: Alignment.center, child: Text('Welcome To Tech Info . . .',
                style: GoogleFonts.pacifico(color:Colors.white70,
                    fontSize:25,fontStyle: FontStyle.italic)
            )
            )
          ],
        );
      },),
    );
  }

  Widget_AppBar(){
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

          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/myimgs/Amazone ceo img demo.jpeg'),
          ),
        ),
      ),
      actions: [
        IconButton(
            splashColor: Colors.transparent,highlightColor:Colors.transparent,
            onPressed: () {
              setState(() {

              });
            }, icon:Icon(Bootstrap.search,size:18))
      ],
    );
  }
}
