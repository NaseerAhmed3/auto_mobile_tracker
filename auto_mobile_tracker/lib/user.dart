import 'package:auto_mobile_tracker/components.dart';
import 'package:auto_mobile_tracker/login.dart';
import 'package:auto_mobile_tracker/notifcation.dart';
import 'package:auto_mobile_tracker/user_home.dart';
import 'package:auto_mobile_tracker/user_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    const UserHome(),
    const UserSetting(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> logout(BuildContext context) async {
      const CircularProgressIndicator();
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.menu),
        //   color: Colors.black,
        // ),
        centerTitle: true,
        title: Consttext(
            ctext: "Auto Tracking System",
            kfontw: FontWeight.w500,
            kfonts: 20.0,
            kcolor: kcolor),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => const Notificationss(),
        //         ),
        //       );
        //     },
        //     icon: Icon(Icons.notifications),
        //     // iconSize: 10,
        //     color: Colors.black,
        //   )
        // ],
      ),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Color(0xffCF6F80),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Color(0xffCF6F80),
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.request_page),
              //   label: 'Request',
              //   backgroundColor: Colors.yellowAccent,
              // ),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: selectedIndex,
            selectedItemColor: Colors.white,
            iconSize: 20,
            onTap: onItemTapped,
            elevation: 0),
      ),
    );
  }
}
