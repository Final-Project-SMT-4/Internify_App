// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simag_app/app/modules/home/views/home_view.dart';
import 'package:simag_app/app/modules/profile/views/profile_view.dart';
import 'package:simag_app/app/modules/jobs/views/jobs_view.dart';
import 'package:simag_app/app/modules/timeline/views/timeline_view.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'package:get/get.dart';

import '../controllers/navigation_bar_controller.dart';

class NavigationBarView extends GetView<NavigationBarController> {
  const NavigationBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.init();

    return Scaffold(
      body: PageView(
        onPageChanged: controller.animateToPage,
        controller: controller.pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          HomeView(),
          const JobsView(),
          const TimelineView(),
          const ProfileView(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(38, 0, 0, 0),
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.white,
            notchMargin: 10.0,
            elevation: 0.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _bottomAppBarItem(
                      context,
                      icon: CupertinoIcons.home,
                      page: 0,
                      label: "Home",
                    ),
                    _bottomAppBarItem(
                      context,
                      icon: CupertinoIcons.briefcase,
                      page: 1,
                      label: "Jobs",
                    ),
                    _bottomAppBarItem(
                      context,
                      icon: CupertinoIcons.map,
                      page: 2,
                      label: "Timeline",
                    ),
                    _bottomAppBarItem(
                      context,
                      icon: CupertinoIcons.person,
                      page: 3,
                      label: "Profile",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(
    BuildContext context, {
    required IconData icon,
    required int page,
    required String label,
  }) {
    return ZoomTapAnimation(
      onTap: () => controller.goToPage(page),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: controller.currentPage.value == page
                  ? const Color.fromARGB(255, 70, 116, 222)
                  : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                color: controller.currentPage.value == page
                    ? const Color.fromARGB(255, 70, 116, 222)
                    : Colors.grey,
                fontSize: 13,
                fontWeight: controller.currentPage.value == page
                    ? FontWeight.w600
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
