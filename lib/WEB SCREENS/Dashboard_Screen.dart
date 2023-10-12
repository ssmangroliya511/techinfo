// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names, avoid_print

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:linkedin_clone/SCREENS/NewPost_Screen.dart';
import 'package:linkedin_clone/WEB%20SCREENS/Web_HomeScreen.dart';
import 'package:linkedin_clone/WEB%20SCREENS/Web_SettingScreen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../SCREENS/Profile_Screen.dart';
import '../STATIC CLS/Static_class.dart';

class Dashboard_Screen extends StatefulWidget {
  const Dashboard_Screen({Key? key}) : super(key: key);

  @override
  State<Dashboard_Screen> createState() => _Dashboard_ScreenState();
}

class _Dashboard_ScreenState extends State<Dashboard_Screen> {

  bool isCollapse = false;

  @override
  void initState() {
    super.initState();
     packageINFO();
  }
  packageINFO() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Var.AppVersion = packageInfo.version;
    setState(() {});
  }

  GoogleFonts textStyle = GoogleFonts();

  List<Widget> Screens = [
    Center(child: Web_HomeScreen()),
    Center(child: Profile_Screen()),
    Center(child: NewPost_Screen()),
    Center(child: Web_SettingScreen()),
  ];

  // int Var.selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ResponsiveBuilder(builder: (context, sizingInformation) {
        if(sizingInformation.deviceScreenType == DeviceScreenType.desktop){
          return Row(
            children: [
              Padding( padding: EdgeInsets.all(10),
                child: SizedBox(
                  width:isCollapse ? 80 : Get.width/6+55,
                  child: Card(
                    elevation:15,color:Colors.blueGrey.shade700,
                    shape:RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(15)
                    ),
                    child: Drawer(
                        backgroundColor: Colors.blueGrey.shade700,
                        shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)
                        ),
                        child: ListView(
                          padding: EdgeInsets.all(10),
                          children: [
                            isCollapse ?  CircleAvatar(
                              radius:35,backgroundImage: AssetImage('assets/myimgs/Amazone ceo img demo.jpeg'),
                            ) :
                            Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: Colors.white,borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Colors.white,Colors.white70,Colors.white
                                  ])
                              ),
                              child: Column(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(height:5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right:90),
                                        child: CircleAvatar(
                                          radius:35,
                                          backgroundImage: AssetImage('assets/myimgs/Amazone ceo img demo.jpeg'),
                                        ),
                                      ),

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

                                  Text(' Sagar Mangroliya',style:GoogleFonts.robotoSlab(
                                      fontSize:19,fontWeight:FontWeight.w600,color: Colors.lightBlue.shade700)
                                  ),
                                  SizedBox(height:3),

                                  Text('+91 7046379090',style:GoogleFonts.ptSans(fontSize:14,color:Colors.black),)
                                ],
                              ),
                            ),
                            SizedBox(height: 20),

                            /// LISTTILS...........
                            ListTile(
                              shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                              leading: Icon(Iconsax.home, color: Var.selectedIndex == 0 ?
                              Colors.lightBlue : Colors.white,size:23),

                              title: Text("DASHBOARD",style: GoogleFonts.ptSansCaption(fontSize:14,
                                  color: Var.selectedIndex == 0 ? Colors.lightBlue : Colors.white
                              )),
                              selectedTileColor: Var.selectedIndex == 0 ?  Colors.white12 : Colors.transparent,
                              dense:true, selected: true,
                              trailing: Icon(CupertinoIcons.right_chevron,size:15,
                                  color: Var.selectedIndex == 0 ? Colors.lightBlue : Colors.white),
                              onTap: () {
                                setState(() {
                                  Var.selectedIndex = 0;
                                });
                              },
                            ),
                            SizedBox(height:10),

                            ListTile(
                              shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                              leading: Icon(HeroIcons.user_circle,
                                  color: Var.selectedIndex == 1 ? Colors.lightBlue : Colors.white,size:23),
                              title: Text("ACCOUNT",style: GoogleFonts.ptSansCaption(fontSize:14,
                                  color: Var.selectedIndex == 1 ? Colors.lightBlue : Colors.white
                              )),
                              trailing: Icon(CupertinoIcons.right_chevron,size:15,
                                  color: Var.selectedIndex == 1 ? Colors.lightBlue : Colors.white),
                              dense:true, selected: true,
                              selectedTileColor: Var.selectedIndex == 1 ?  Colors.white12 : Colors.transparent,
                              onTap: () {
                                setState(() {
                                  Var.selectedIndex = 1;
                                });
                              },
                            ),
                            SizedBox(height:10),

                            ListTile(
                              shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                              leading: Icon(Icons.post_add,
                                  color: Var.selectedIndex == 2 ? Colors.lightBlue : Colors.white,size:23),
                              title: Text("MAKE POSTS",style: GoogleFonts.ptSansCaption(fontSize:14,
                                  color: Var.selectedIndex == 2 ? Colors.lightBlue : Colors.white
                              )),
                              trailing: Icon(CupertinoIcons.right_chevron,size:15,
                                  color: Var.selectedIndex == 2 ? Colors.lightBlue : Colors.white),
                              dense:true, selected: true,
                              selectedTileColor: Var.selectedIndex == 2 ?  Colors.white12 : Colors.transparent,
                              onTap: () {
                                setState(() {
                                  Var.selectedIndex = 2;
                                });
                              },
                            ),
                            SizedBox(height:10),

                            ListTile(
                              shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                              leading: Icon(Iconsax.setting,
                                  color: Var.selectedIndex == 3 ? Colors.lightBlue : Colors.white,size:23),
                              title: Text("SETTINGS",style: GoogleFonts.ptSansCaption(fontSize:14,
                                  color: Var.selectedIndex == 3 ? Colors.lightBlue : Colors.white
                              )),
                              trailing: Icon(CupertinoIcons.right_chevron,size:15,
                                  color: Var.selectedIndex == 3 ? Colors.lightBlue : Colors.white),
                              dense:true, selected: true,
                              selectedTileColor: Var.selectedIndex == 3 ?  Colors.white12 : Colors.transparent,
                              onTap: () {
                                setState(() {
                                  Var.selectedIndex = 3;
                                });
                              },
                            ),
                            SizedBox(height:10),

                            ListTile(
                              shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                              leading: Icon(Icons.info, color: Colors.white,size:23),
                              title: Text("ABOUT",style:GoogleFonts.ptSansCaption(fontSize:14,color:Colors.white)),
                              dense:true,
                              onTap: () {},
                            ),
                            SizedBox(height:10),

                            ListTile(
                              shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                              leading: Icon(EvaIcons.log_out, color: Colors.red), dense:true,
                              title: Text("SIGN OUT",style:GoogleFonts.ptSansCaption(fontSize:14,color:Colors.red)),
                              onTap: ()  {
                                Dialogs.Logout_Dialog(context);
                              },
                            ),
                            SizedBox(height:10),

                            /// Drawer Close btn.................
                            isCollapse ?
                            InkWell(
                                splashColor:Colors.transparent,highlightColor:Colors.transparent,
                                hoverColor:Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    isCollapse = false;
                                  });
                                },child: CircleAvatar(
                                backgroundColor: Colors.white12,
                                child:Icon(CupertinoIcons.clear,color:Colors.green,size:16))
                            )
                                :
                            /// Drawer Open btn.................
                            ListTile(
                              dense:true,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                              leading: Icon(Bootstrap.arrow_left_circle, color: Colors.green,size:20),
                              title: Text("Collapse",style:GoogleFonts.ptSansCaption(fontSize:14,color:Colors.green)),
                              onTap: ()  {
                                setState(() {
                                  isCollapse = true;
                                });
                              },
                            ),
                            SizedBox(height:150),

                            !isCollapse ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height:22,width:21,alignment: Alignment.center,
                                  padding: EdgeInsets.only(left:2),
                                  margin: EdgeInsets.only(right:1),
                                  decoration:BoxDecoration(color:Colors.blueAccent,borderRadius:BorderRadius.circular(3)),
                                  child:Text('T',style:GoogleFonts.pacifico(fontSize:18.5,height:1.5,color: Colors.white)),
                                ),
                                Text("ech Info", style: GoogleFonts.ptSansCaption(
                                    fontSize:18,color:Colors.blueAccent,fontWeight:FontWeight.w300,height:1.5)
                                ),
                              ],
                            ) : SizedBox()

                            // Var.AppVersion == null ? SizedBox() : Padding
                            //   (padding: EdgeInsets.only(top:200,left:100),
                            //     child:Text("Version ${Var.AppVersion}",
                            //         style:GoogleFonts.aBeeZee(fontSize: 14.5,color: Colors.blueAccent.shade200))
                            // ),



                          ],
                        )
                    ),
                  ),
                ),
              ),

              /// Make it take the rest of the available width
              Expanded(
                child: Screens.elementAt(Var.selectedIndex),
              )
            ],
          );
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
       },
      ),
    );
  }
}
