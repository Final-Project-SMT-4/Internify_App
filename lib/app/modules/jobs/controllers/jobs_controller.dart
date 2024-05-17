// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobsController extends GetxController {
  final PageController pageController = PageController();
  var selectedIndex = 0.obs;

  void setPage(int index) {
    pageController.jumpToPage(index);
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
