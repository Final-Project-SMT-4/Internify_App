import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simag_app/app/modules/home/utils/dashboard_box.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final List myDashboard = [
    [
      "Completed",
      "10",
      CupertinoIcons.check_mark_circled_solid,
      const Color.fromARGB(255, 125, 231, 198),
    ],
    [
      "Pending",
      "12",
      Icons.pending,
      const Color.fromARGB(255, 125, 136, 231),
    ],
    [
      "On Going",
      "2",
      CupertinoIcons.rocket_fill,
      const Color.fromARGB(255, 129, 232, 158),
    ],
    [
      "Canceled",
      "5",
      CupertinoIcons.xmark_circle_fill,
      const Color.fromARGB(255, 231, 125, 125),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 5.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 0.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, Budiman",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Let’s make this day productive !",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/profile.png"),
                      backgroundColor: Colors.transparent,
                      radius: 25,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    "My Dashboard",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: myDashboard.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return DashboardBox(
                        itemName: myDashboard[index][0],
                        numberTask: myDashboard[index][1],
                        icon: myDashboard[index][2],
                        color: myDashboard[index][3],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
