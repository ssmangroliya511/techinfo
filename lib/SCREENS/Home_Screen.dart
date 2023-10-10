// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:getwidget/getwidget.dart';
import 'package:linkedin_clone/SCREENS/NewPost_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DRAWER CLS/Drawerr_cls.dart';
import '../STATIC CLS/Static_class.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSearch = false;

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
      backgroundColor: Colors.grey.shade100,
      key: scaffoldKey,

      floatingActionButton: SizedBox(height: 43,
        child: FloatingActionButton.extended(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            Get.to(NewPost_Screen());
        }, label: Text('Post'),icon: Icon(Icons.post_add),),
      ),

      appBar : isSearch ? Widget_SearchAppbar() : Widget_DefaultAppbar(),

      drawer: Drawerr(),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch
        ),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
          return Container(
            margin:EdgeInsets.only(top:8),
            padding: EdgeInsets.only(bottom:5),
            width:Get.width,color:Colors.white,
            child:Column(
              children: [

                /// Profile pic/Name Section .....................
                ListTile(
                  leading:CircleAvatar(
                      radius:20,backgroundColor:Colors.black12,
                      backgroundImage: AssetImage('myimgs/Amazone ceo img demo.jpg'),
                  ),
                  title:Text('Amazon india',style:GoogleFonts.robotoCondensed(fontSize:14.5,fontWeight:FontWeight.w600)),
                  subtitle:Text('Product Sales & Community',style:GoogleFonts.roboto(fontSize:12)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GFButton(
                        size:28,color:Colors.blueGrey.shade50,
                        text:'Follow',textStyle:GoogleFonts.ptSans(color:Colors.green),
                        icon:Icon(Bootstrap.plus,color:Colors.green,size:17),
                        onPressed: () {},
                      ),
                      PopupMenuButton(
                        splashRadius:1, position: PopupMenuPosition.under,
                        icon: Icon(Icons.more_vert,size:18,color:Colors.black),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(child: Text('Delete Post',style:GoogleFonts.roboto(fontSize:14)),
                              onTap:() {},
                            ),
                            PopupMenuItem(child: Text('Share Post',style:GoogleFonts.roboto(fontSize:14)),
                              onTap:() {},
                            )
                          ];
                        },
                      ),
                    ],
                  )
                ),
                SizedBox(height:5),

                /// Description Section .....................
                Container(
                  alignment: Alignment.centerLeft,
                  margin:EdgeInsets.only(left:20,right:10),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amazon GO Al Associate - WorkFrom Home',style:GoogleFonts.poppins(fontSize:12.5),),
                      SizedBox(height:10),

                      Text('Hyderabad/Delhi',style:GoogleFonts.roboto(fontSize:13),),
                      Text('http://link.in/d5XjFBe',style:GoogleFonts.roboto(fontSize:13,color:CupertinoColors.link),),
                      SizedBox(height:10),

                      Text('Join Over Channel -',style:GoogleFonts.roboto(fontSize:13),),
                      Text('http://link.in/d5XjFBe',style:GoogleFonts.roboto(fontSize:13,color:CupertinoColors.link),),
                    ],
                  ),
                ),
                SizedBox(height:10),

                /// Post Image Section .............................
                Container(
                  margin: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius:BorderRadius.circular(5  ),
                    child: Image.asset('myimgs/amazone com img demo.jpg'),
                  ),
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

                Divider(),


                /// Like Comment repost share Buttons Section .............
                Container(
                  height:47,width:Get.width/2+160,
                  // color: Colors.grey.shade100,
                  padding: EdgeInsets.only(left:20,right:20,top:6,bottom:5),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.thumb_up_alt_outlined,size:16,color:Colors.black45,),
                          Text('Like',style:GoogleFonts.ptSans(fontSize:11.5,color:Colors.black45),)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height:2),
                          Icon(FontAwesome.message,size:14,color:Colors.black45),
                          SizedBox(height:2),
                          Text('Comment',style:GoogleFonts.ptSans(fontSize:11.5,color:Colors.black45),)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(BoxIcons.bx_repost,size:20,color:Colors.black45),
                          Text('Repost',style:GoogleFonts.ptSans(fontSize:11,color:Colors.black45),),
                          SizedBox(height:2),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height:3),
                          Icon(Bootstrap.arrow_90deg_right,size:13,color:Colors.black45),
                          SizedBox(height:3),
                          Text('Share',style:GoogleFonts.ptSans(fontSize:12,color:Colors.black45),)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },),
      ),
    );
  }



  Widget_DefaultAppbar(){
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
            scaffoldKey.currentState!.openDrawer();
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child:Image.asset('myimgs/User No Profile Dp.png'),
          ),
        ),
      ),
      actions: [
        IconButton(
            splashColor: Colors.transparent,highlightColor:Colors.transparent,
            onPressed: () {
              setState(() {
                isSearch = true;
              });
            }, icon:Icon(Bootstrap.search,size:18))
      ],
    );
  }


  Widget_SearchAppbar(){
    return AppBar(
      toolbarHeight:53,
      backgroundColor:Colors.white,elevation: 0.5, centerTitle:true,
      iconTheme: IconThemeData(color:Colors.blueAccent),
      actionsIconTheme:IconThemeData(color:Colors.blueAccent),

      /// Search TextField ...........................
      title: TextField(
        onChanged: (value) {
          setState(() {});
        },
        controller:Fieldcontroller.hsearch,
        cursorColor:Colors.blueAccent,cursorWidth:1,cursorHeight:20,
        autofocus: true,
        style:GoogleFonts.ptSansCaption(fontSize:13),
        textInputAction:TextInputAction.done,
        decoration:InputDecoration(
            filled:true,fillColor:Colors.grey.shade200,
            isDense: true, hintText:'Search here . . .',
            hintStyle:GoogleFonts.ptSansCaption(fontSize:12.5),
            constraints:BoxConstraints.loose(Size.fromHeight(35)),
            contentPadding: EdgeInsets.only(top:15),
            enabledBorder: OutlineInputBorder(
              borderRadius:BorderRadius.circular(50),borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:BorderRadius.circular(50),borderSide: BorderSide.none
            ),
            prefixIcon: Icon(Bootstrap.search,size:14),
            suffixIcon: Fieldcontroller.hsearch.text.isNotEmpty ? IconButton(
                splashColor:Colors.transparent,highlightColor:Colors.transparent,
                onPressed: () { setState(() { Fieldcontroller.hsearch.text = ''; } );
            }, icon: Icon(CupertinoIcons.delete_solid,size:16,color:Colors.red)) : SizedBox()
        ),
      ),
      leadingWidth:45,
      leading: Padding(
        padding: EdgeInsets.only(left:13),
        child: InkWell(
          splashColor: Colors.transparent,highlightColor: Colors.transparent,
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child:Image.asset('myimgs/User No Profile Dp.png'),
          ),
        ),
      ),
      actions: [
        IconButton(
            splashColor: Colors.transparent,highlightColor:Colors.transparent,
            onPressed: () {
              setState(() {
                isSearch = false;
              });
            }, icon:Icon(CupertinoIcons.clear_circled,color:Colors.blueAccent,size:22))
      ],
    );
  }

}
