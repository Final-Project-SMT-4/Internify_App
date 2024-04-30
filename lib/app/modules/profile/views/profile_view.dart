// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simag_app/app/routes/app_pages.dart';

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
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Team Leader",
                  style: TextStyle(fontSize: 18.0),
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
            routes: Routes.ABOUT,
          ),
          ButtonProfile(
            btnIcon: Icons.groups,
            btnText: "My Team Profile",
            iconColor: Color.fromARGB(255, 70, 116, 222),
            textColor: Color.fromARGB(255, 49, 46, 58),
            routes: Routes.ABOUT,
          ),
          ButtonProfile(
            btnIcon: Icons.info,
            btnText: "About",
            iconColor: Color.fromARGB(255, 70, 116, 222),
            textColor: Color.fromARGB(255, 49, 46, 58),
            routes: Routes.ABOUT,
          ),
          ButtonProfile(
            btnIcon: Icons.logout_rounded,
            btnText: "Logout",
            iconColor: Colors.red,
            textColor: Colors.red,
            routes: Routes.ABOUT,
          ),
        ],
      ),
    );
  }
}

class ButtonProfile extends StatelessWidget {
  final IconData btnIcon;
  final String btnText;
  final Color iconColor;
  final Color textColor;
  final String routes;

  const ButtonProfile({
    super.key,
    required this.btnIcon,
    required this.btnText,
    required this.iconColor,
    required this.textColor,
    required this.routes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(38, 0, 0, 0),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, -2),
              )
            ]),
        child: TextButton(
            onPressed: () => Get.toNamed(routes),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              padding: MaterialStatePropertyAll(
                EdgeInsets.only(
                  left: 20,
                  top: 23,
                  bottom: 23,
                ),
              ),
            ),
            child: Row(children: [
              Icon(
                btnIcon,
                color: iconColor,
                size: 28.0,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                btnText,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  color: textColor,
                ),
              )
            ])),
      ),
    );
  }
}
