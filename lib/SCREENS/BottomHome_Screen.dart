
// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:linkedin_clone/MY%20PROFILE/MyProfile_Screen.dart';
import 'package:linkedin_clone/MY%20PROFILE/YourPost_Screen.dart';
import '../STATIC CLS/Static_class.dart';
import '../HOME/Home_Screen.dart';
import 'Notification_Screen.dart';

class BottomHome_Screen extends StatefulWidget {
  const BottomHome_Screen( {Key? key}) : super(key: key);

  @override
  State<BottomHome_Screen> createState() => _BottomHome_ScreenState();
}

class _BottomHome_ScreenState extends State<BottomHome_Screen> {

  static final List<Widget> _pages = <Widget>
  [
       Home_Screen(),
       YourPost_Screen(),
       Notification_Screen(),
       MyProfile_Screen(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      Var.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        return _onbackPressed();
      },
      child: Scaffold(

          body: _pages.elementAt(Var.selectedIndex),

          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation:10,showUnselectedLabels: true,
            backgroundColor: Colors.white,
            selectedIconTheme:IconThemeData(size:27),
            unselectedIconTheme:IconThemeData(size:23),
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor:Colors.black,
            unselectedLabelStyle: GoogleFonts.ptSansCaption(fontSize:11),
            selectedLabelStyle: GoogleFonts.ptSansCaption(fontSize:12),
            currentIndex:Var.selectedIndex,

            items: [
              BottomNavigationBarItem(
                  label:'Home',
                  activeIcon:Icon(HeroIcons.home,color:Colors.blueAccent,size:23),
                  icon: Icon(HeroIcons.home, color:Colors.black,size:21),
              ),
              BottomNavigationBarItem(
                  label:'Your Posts',
                  activeIcon:Icon(LineAwesome.clipboard,color:Colors.blueAccent,size:25),
                  icon: Icon(LineAwesome.clipboard_list_solid,color:Colors.black,size:22)
              ),
              BottomNavigationBarItem(
                  label:'Notification',
                  activeIcon:Icon(Iconsax.notification_status,color:Colors.blueAccent,size:24),
                  icon: Icon(Iconsax.notification_1,color:Colors.black,size:21)
              ),
              BottomNavigationBarItem(
                  label: 'Profile',
                  activeIcon:Icon(Iconsax.user_square,color:Colors.blueAccent,size:23),
                  icon: Icon(Iconsax.user_square,color:Colors.black,size:21),
              )
            ],
            onTap: _onItemTapped,
          )
      ),
    );
  }

  Future<bool> _onbackPressed() async {
    return (await Dialogs.ExitApp_Dialog(context,setState)) ?? false;
  }
}
