// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../DRAWER CLS/Drawerr_cls.dart';
import 'BottomHome_Screen.dart';

class Notification_Screen extends StatefulWidget {
  const Notification_Screen({Key? key}) : super(key: key);

  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {

  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey1,
      backgroundColor:Colors.white,
      appBar : Widget_Appbar(),

      drawer: Drawerr(),

      body:ScrollConfiguration(
        behavior: ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
        child: ListView.builder(
          padding:EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(bottom:10),
              child: ListTile(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  contentPadding:EdgeInsets.symmetric(vertical:5,horizontal:10),
                  shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
                  tileColor: Colors.grey.shade100,dense:true,
                  leading:CircleAvatar( radius:18,backgroundColor:Colors.black12,
                    child:Icon(Icons.notifications_none,size:18,color:Colors.black),
                  ),
                  title: Text('Bitinfo',style:GoogleFonts.roboto(color:Colors.blueAccent,fontSize:14)),
                  subtitle: Text('Bitinfo post a flutter Communication topic',style:GoogleFonts.ptSans(),),
                  trailing: GFButton(
                    size:28,color: Colors.white,
                    borderSide:BorderSide(color:Colors.blue,width:0.5),
                    shape:GFButtonShape.pills,
                    text:'View Post',textStyle:GoogleFonts.roboto(color:Colors.black,fontSize:11),
                    onPressed: () {
                      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) {
                         return BottomHome_Screen();
                      },));
                    },)
              ),
            );
          },
        ),
      )
    );
  }

  Widget_Appbar(){
    return  AppBar(
      toolbarHeight:55,
      backgroundColor:Colors.white,elevation: 0.5, centerTitle:true,
      iconTheme: IconThemeData(color:Colors.blueAccent),
      actionsIconTheme:IconThemeData(color:Colors.blueAccent),
      title: Text("Notifications", style: GoogleFonts.ptSansCaption(
          fontSize:16,color:Colors.blueAccent,fontWeight:FontWeight.w600)),
      leading:IconButton(
          splashColor: Colors.transparent,highlightColor:Colors.transparent,
          onPressed:() {
            scaffoldKey1.currentState!.openDrawer();
          },icon: Icon(BoxIcons.bx_grid_horizontal)
      ),
      actions: [
        IconButton(
            splashColor: Colors.transparent,highlightColor:Colors.transparent,
            onPressed:() {
            },icon: Icon(Iconsax.notification,size:20)
        ),
      ],
    );
}
}
