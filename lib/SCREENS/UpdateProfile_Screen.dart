// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:linkedin_clone/SCREENS/BottomHome_Screen.dart';
import '../STATIC CLS/Static_class.dart';

class UpdateProfile_Screen extends StatefulWidget {
  const UpdateProfile_Screen({Key? key}) : super(key: key);

  @override
  State<UpdateProfile_Screen> createState() => _UpdateProfile_ScreenState();
}

class _UpdateProfile_ScreenState extends State<UpdateProfile_Screen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widget_Appbar(),

      body:SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child:Column(
          children: [
            SizedBox(height:15),

            Align( alignment: Alignment.center,
                child: CircleAvatar(
                    radius:55,backgroundColor:Colors.grey.shade200,
                    child:Icon(Bootstrap.camera,size:30),
                )
            ),
            SizedBox(height:15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(EvaIcons.info_outline,size:17,color: Colors.blueAccent),SizedBox(width:5),
                Text('Tap Camera Icon to Update your Profile Picture.',
                    style:GoogleFonts.robotoFlex(color:Colors.blueAccent,fontSize:13)),
              ],
            ),
            SizedBox(height:20),

            Container(
              height:Get.height/2+20,width:Get.width,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(10),
              decoration:BoxDecoration(
                border: Border.all(color:Colors.black,width:0.5),
                color: Colors.white,borderRadius:BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:10),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Update your Name -',style:GoogleFonts.robotoCondensed(),),
                  ),
                  TextField(
                     onChanged: (value) { setState(() {}); },
                     controller:Fieldcontroller.uname,
                     cursorColor:Colors.black,style:GoogleFonts.roboto(fontSize:14),
                     textInputAction:TextInputAction.next,
                     textCapitalization: TextCapitalization.words,
                     decoration:InputDecoration(
                        isDense: true,filled:true,fillColor:Colors.grey.shade200,
                        hintText:'Enter Name',counterText:'',
                        hintStyle:GoogleFonts.roboto(fontSize:13,color:Colors.black45),
                        constraints: BoxConstraints( maxHeight:45 ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(30),borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(30),
                            borderSide: BorderSide(color:Colors.blueAccent,width:0.7)
                        ),
                        prefixIcon:Icon(EvaIcons.person,color:Colors.blue),
                        suffixIcon:Fieldcontroller.uname.text.isNotEmpty ? IconButton(onPressed: (){
                          setState(() {
                            Fieldcontroller.uname.text = '';
                          });
                        }, icon: Icon(CupertinoIcons.clear,size:15,color:Colors.blue)
                        ) : null
                    ),
                  ),
                  SizedBox(height:17),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Update your Email -',style:GoogleFonts.robotoCondensed(),),
                  ),
                  TextField(
                    onChanged: (value) { setState(() {}); },
                    controller:Fieldcontroller.uemailid,
                    cursorColor:Colors.black,style:GoogleFonts.roboto(fontSize:14),
                    textInputAction:TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration:InputDecoration(
                        isDense: true,filled:true,fillColor:Colors.grey.shade200,
                        hintText:'Enter Email',counterText:'',
                        constraints: BoxConstraints( maxHeight:45 ),
                        hintStyle:GoogleFonts.roboto(fontSize:13,color:Colors.black45),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(30),borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(30),
                            borderSide: BorderSide(color:Colors.blueAccent,width:0.7)
                        ),
                        prefixIcon:Icon(EvaIcons.email,color:Colors.blue),
                        suffixIcon:Fieldcontroller.uemailid.text.isNotEmpty ? IconButton(onPressed: (){
                          setState(() {
                            Fieldcontroller.uemailid.text = '';
                          });
                        }, icon: Icon(CupertinoIcons.clear,size:15,color:Colors.blue)
                        ) : null
                    ),
                  ),
                  SizedBox(height:17),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Update your State -',style:GoogleFonts.robotoCondensed(),),
                  ),
                  TextField(
                    onChanged: (value) { setState(() {}); },
                    controller:Fieldcontroller.ustate,
                    cursorColor:Colors.black,style:GoogleFonts.roboto(fontSize:14),
                    textInputAction:TextInputAction.next,
                    decoration:InputDecoration(
                        isDense: true,filled:true,fillColor:Colors.grey.shade200,
                        hintText:'Enter State',counterText:'',
                        constraints: BoxConstraints( maxHeight:45 ),
                        hintStyle:GoogleFonts.roboto(fontSize:13,color:Colors.black45),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(30),borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(30),
                            borderSide: BorderSide(color:Colors.blueAccent,width:0.7)
                        ),
                        prefixIcon:Icon(Bootstrap.building_fill,color:Colors.blue,size:15),
                        suffixIcon:Fieldcontroller.ustate.text.isNotEmpty ? IconButton(onPressed: (){
                          setState(() {
                            Fieldcontroller.ustate.text = '';
                          });
                        }, icon: Icon(CupertinoIcons.clear,size:15,color:Colors.blue)
                        ) : null
                    ),
                  ),
                  SizedBox(height:17),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Update your City -',style:GoogleFonts.robotoCondensed(),),
                  ),
                  TextField(
                    onChanged: (value) { setState(() {}); },
                    controller:Fieldcontroller.ucity,
                    cursorColor:Colors.black,style:GoogleFonts.roboto(fontSize:14),
                    textInputAction:TextInputAction.done,
                    decoration:InputDecoration(
                        isDense: true,filled:true,
                        fillColor:Colors.grey.shade200,
                        hintText:'Enter City',counterText:'',
                        constraints: BoxConstraints( maxHeight:45 ),
                        hintStyle:GoogleFonts.roboto(fontSize:13,color:Colors.black45),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(30),borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(30),
                            borderSide: BorderSide(color:Colors.blueAccent,width:0.7)
                        ),
                        prefixIcon:Icon(FontAwesome.city,color:Colors.blue,size:12.5),
                        suffixIcon:Fieldcontroller.ucity.text.isNotEmpty ? IconButton(onPressed: (){
                          setState(() {
                            Fieldcontroller.ucity.text = '';
                          });
                        }, icon: Icon(CupertinoIcons.clear,size:15,color:Colors.blue)
                        ) : null
                    ),
                  ),
                  SizedBox(height:17),
                ],
              ),
            ),
            SizedBox(height:20),

            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) {
                  return BottomHome_Screen();
                },));
              },
              child: Container(
                  height:40,width:200,
                  decoration:BoxDecoration(
                      color:Colors.blueAccent,borderRadius:BorderRadius.circular(7),
                      gradient:LinearGradient(colors: [
                        Colors.blueAccent,Colors.blue.shade300,Colors.lightBlue.shade400
                      ])
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Save Profile',style:GoogleFonts.ptSans(color:Colors.white,fontSize:16)),
                      SizedBox(width:10),
                      Icon(IonIcons.save,color:Colors.white,size:16)
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget_Appbar(){
  return AppBar(
    backgroundColor:Colors.white,elevation:0,centerTitle:true,
    iconTheme: IconThemeData(color:Colors.blueAccent),
    title: Text("Update Profile", style: GoogleFonts.ptSansCaption(
           fontSize:16,color:Colors.blueAccent,fontWeight:FontWeight.w600)
    ),
  );
}
