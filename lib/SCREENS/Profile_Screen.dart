// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DRAWER CLS/Drawerr_cls.dart';
import '../STATIC CLS/Static_class.dart';
import 'UpdateProfile_Screen.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shareprefs();
  }
  shareprefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Var.UserMobile = pref.getString('userMobile');
    print('UserMobile ${Var.UserMobile}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      drawer: Drawerr(),

      body: ScrollConfiguration(
        behavior: ScrollBehavior(

        ),
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height:Get.height/4-45,width:Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,image: DecorationImage(
                      image: AssetImage('assets/myimgs/Tech Info Profile Cover Image.png'),
                      fit: BoxFit.fitWidth,opacity:0.3)
                  ),
                  child:Align( alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                splashColor: Colors.transparent,highlightColor:Colors.transparent,
                                onPressed:() {
                                  scaffoldKey.currentState!.openDrawer();
                                },icon: Icon(BoxIcons.bx_grid_horizontal)
                            ),
                            Text("Profile", style: GoogleFonts.ptSansCaption(
                                fontSize:16,color:Colors.blueAccent,fontWeight:FontWeight.w600)
                            ),
                            SizedBox(width:40)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top:10,bottom:10,right:20),
                              child: SizedBox(
                                height:38,width:115,
                                child: FloatingActionButton.extended(
                                  elevation:0,
                                  shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                                  backgroundColor: Colors.black26,
                                  onPressed: () {
                                    Dialogs.Logout_Dialog(context);
                                  },icon:Icon(BoxIcons.bx_log_out, color: Colors.white,size:18),
                                    label: Text('Logout?',style:GoogleFonts.roboto(color:Colors.white))
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top:88,left:30),
                          child: Row(
                            children: [ CircleAvatar(
                                radius:55,backgroundColor:Colors.grey.shade100,
                                backgroundImage:AssetImage('assets/myimgs/Amazone ceo img demo.jpeg'),
                              ),
                              SizedBox(width:20),
                              Text("Sagar Mangroliya", style:GoogleFonts.poppins(
                                  fontSize:17,color:Colors.black,height:2.8)
                              )
                            ],
                          ),
                        ),
                        SizedBox(height:20),
                        InkWell(
                          onTap:() {
                            Navigator.push(context,MaterialPageRoute(builder:(context) {
                              return UpdateProfile_Screen();
                            },));
                          },
                          child: Container(
                              height:38,width:150,
                              decoration:BoxDecoration(
                                  color:Colors.blueAccent,borderRadius:BorderRadius.circular(7),
                                  gradient:LinearGradient(colors: [
                                    Colors.blueAccent,Colors.blue.shade300,Colors.lightBlue.shade400
                                  ])
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Update Profile',style:GoogleFonts.ptSans(color:Colors.white,fontSize:15)),
                                  Icon(Bootstrap.pencil_fill,color:Colors.white,size:15)
                                ],
                              )
                          ),
                        ),
                      ],
                    )
                ),
                Positioned(top:177,left:105,
                    child: CircleAvatar(
                      radius:11,backgroundColor:Colors.white,
                      child:CircleAvatar(radius:7,backgroundColor:Colors.green,),
                    )
                ),
              ],
            ),
            SizedBox(height:10),
            Divider(),

            Padding(
              padding: EdgeInsets.only(top:7,bottom:7,left:20),
              child: Text('Account',style:GoogleFonts.poppins(fontWeight:FontWeight.w600),),
            ),

            Padding(
              padding: EdgeInsets.only(top:5,left:10,right:10),
              child: ListTile(
                tileColor: Colors.blueGrey.shade50.withOpacity(0.5),dense:true,
                leading:CircleAvatar( radius:15,backgroundColor:Colors.blue.shade100.withOpacity(0.6),
                  child:Icon(EvaIcons.email,size:17,color:Colors.black),
                ),
                title: Text('Email-Id',style:GoogleFonts.ptSerifCaption(),),
                trailing:Text('sagar@gmail.com',style:GoogleFonts.ptSansCaption(fontSize:13.5,color:Colors.blue),),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:10,left:10,right:10),
              child: ListTile(
                tileColor: Colors.blueGrey.shade50.withOpacity(0.5),dense:true,
                leading:CircleAvatar( radius:15,backgroundColor:Colors.blue.shade100.withOpacity(0.6),
                  child:Icon(EvaIcons.phone_call,size:16,color:Colors.black),
                ),
                title: Text('Contact No.',style:GoogleFonts.ptSerifCaption(),),
                trailing:Text(Var.UserMobile == null ? '+917046379090' : '+91 ${Var.UserMobile}',
                  style:GoogleFonts.ptSansCaption(fontSize:13.5,color:Colors.blue),),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:10,left:10,right:10),
              child: ListTile(
                tileColor: Colors.blueGrey.shade50.withOpacity(0.5),dense:true,
                leading:CircleAvatar( radius:15,backgroundColor:Colors.blue.shade100.withOpacity(0.6),
                  child:Icon(Bootstrap.building_fill,size:16,color:Colors.black),
                ),
                title: Text('State',style:GoogleFonts.ptSerifCaption(),),
                trailing:Text('Gujarat',style:GoogleFonts.ptSansCaption(fontSize:13.5,color:Colors.blue),),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:10,left:10,right:10),
              child: ListTile(
                tileColor: Colors.blueGrey.shade50.withOpacity(0.5),dense:true,
                leading:CircleAvatar( radius:15,backgroundColor:Colors.blue.shade100.withOpacity(0.6),
                  child:Icon(FontAwesome.city,size:12.5,color:Colors.black),
                ),
                title: Text('City',style:GoogleFonts.ptSerifCaption(),),
                trailing:Text('Surat',style:GoogleFonts.ptSansCaption(fontSize:13.5,color:Colors.blue),),
              ),
            ),
            SizedBox(height:15),
            Divider(),

            Padding(
              padding: EdgeInsets.only(top:7,left:20),
              child: Text('Your Posts',style:GoogleFonts.poppins(fontWeight:FontWeight.w600),),
            ),
            SizedBox(height:30),

            Column(
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
            ),
            SizedBox(height:30)
          ],
        ),
      ),
    );
  }
}
