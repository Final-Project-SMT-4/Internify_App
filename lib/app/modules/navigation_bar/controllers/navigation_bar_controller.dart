import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationBarController extends GetxController {
  late PageController pageController;

  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentPage.value);
  }

  void goToPage(int page) {
    if (pageController.hasClients) {
      currentPage.value = page;
      pageController.jumpToPage(page);
    }
  }

  void animateToPage(int page) {
    if (pageController.hasClients) {
      currentPage.value = page;
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void resetToHomePage() {
    if (pageController.hasClients) {
      currentPage.value = 0;
      pageController.jumpToPage(0);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
