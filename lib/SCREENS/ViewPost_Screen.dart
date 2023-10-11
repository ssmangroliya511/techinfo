// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:linkedin_clone/SCREENS/NewPost_Screen.dart';

class ViewPost_Screen extends StatefulWidget {
  const ViewPost_Screen({Key? key}) : super(key: key);

  @override
  State<ViewPost_Screen> createState() => _ViewPost_ScreenState();
}

class _ViewPost_ScreenState extends State<ViewPost_Screen> {
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey1,

      appBar : Widget_Appbar(),

      body:ScrollConfiguration(behavior: ScrollBehavior(),
        child: Center(
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
                Text('You Not Create Any Post Yet !!',style:GoogleFonts.ptSans(fontSize:13,color:Colors.black45),),
                SizedBox(height:5),
                GFButton(onPressed:() {
                      Navigator.push(context,MaterialPageRoute(builder:(context) {
                       return NewPost_Screen();
                     },));
                   },
                   text: 'Create Post ?', textStyle: GoogleFonts.ptSans(),
                   icon: Icon(Icons.post_add_rounded,color:Colors.white,size:20),
                )
              ],
            ),
         )
       ),
     );
  }

  Widget_Appbar(){
    return AppBar(
      toolbarHeight:55,
      backgroundColor:Colors.white,elevation:0.5, centerTitle:true,
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
}

