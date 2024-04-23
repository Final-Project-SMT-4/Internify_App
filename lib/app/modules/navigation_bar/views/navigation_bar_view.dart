import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simag_app/app/modules/home/views/home_view.dart';
import 'package:simag_app/app/modules/profile/views/profile_view.dart';
import 'package:simag_app/app/modules/task/views/task_view.dart';
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
          const TimelineView(),
          const TaskView(),
          const ProfileView(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
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
                  icon: CupertinoIcons.house,
                  page: 0,
                  label: "Home",
                ),
                _bottomAppBarItem(
                  context,
                  icon: CupertinoIcons.map,
                  page: 1,
                  label: "Timeline",
                ),
                _bottomAppBarItem(
                  context,
                  icon: CupertinoIcons.doc_append,
                  page: 2,
                  label: "Task",
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
