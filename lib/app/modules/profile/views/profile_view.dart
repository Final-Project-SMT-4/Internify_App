// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 200,
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 72, 71, 156),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.png"),
                backgroundColor: Colors.transparent,
                radius: 48.5,
              ),
              SizedBox(
                width: 9,
              ),
              Text(
                "Budiman",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              SizedBox(
                width: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Team Leader",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 12,
                  )
                ],
              )
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 249, 249, 249),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 34,
            ),
            ButtonProfile(
              btnIcon: Icons.person,
              btnText: "My Profile",
              iconColor: Color.fromARGB(255, 70, 116, 222),
              textColor: Color.fromARGB(255, 49, 46, 58),
            ),
            ButtonProfile(
              btnIcon: Icons.groups,
              btnText: "My Team Profile",
              iconColor: Color.fromARGB(255, 70, 116, 222),
              textColor: Color.fromARGB(255, 49, 46, 58),
            ),
            ButtonProfile(
              btnIcon: Icons.info,
              btnText: "About",
              iconColor: Color.fromARGB(255, 70, 116, 222),
              textColor: Color.fromARGB(255, 49, 46, 58),
            ),
            ButtonProfile(
              btnIcon: Icons.logout_rounded,
              btnText: "Logout",
              iconColor: Colors.red,
              textColor: Colors.red,
            ),
          ],
        ));
  }
}

class ButtonProfile extends StatelessWidget {
  final IconData btnIcon;
  final String btnText;
  final Color iconColor;
  final Color textColor;

  const ButtonProfile({
    super.key,
    required this.btnIcon,
    required this.btnText,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: EdgeInsets.only(left: 20, top: 23, bottom: 23),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(38, 0, 0, 0),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, -2))
          ]),
      child: Row(
        children: [
          Icon(
            btnIcon,
            color: iconColor,
            size: 24,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            btnText,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14, color: textColor),
          )
        ],
      ),
    );
  }
}
