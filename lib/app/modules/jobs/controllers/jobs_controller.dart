// ignore_for_file: unnecessary_overrides, avoid_print
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simag_app/app/modules/jobs/controllers/post_jobs_controller.dart';

class JobsController extends GetxController {
  final PageController pageController = PageController();
  final PostJobsController controller = PostJobsController();
  var selectedIndex = 0.obs;
  var selectedFile = Rxn<PlatformFile>();

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

  bool validate() {
    if (selectedFile.value == null) {
      return false;
    }
    return true;
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      // PlatformFile file = result.files.first;
      selectedFile.value = result.files.first;
      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
    } else {
      print("Batal Pick File");
    }
  }

  void removeFile() {
    selectedFile.value = null;
    controller.filepath = "";
    print("File terhapus");
  }
}
