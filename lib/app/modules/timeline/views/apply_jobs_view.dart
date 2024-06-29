import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simag_app/app/modules/timeline/controllers/fetch_jobs_controller.dart';
import 'package:simag_app/app/modules/timeline/controllers/post_jobs_controller.dart';

import '../controllers/timeline_controller.dart';
import '../model/dosen_model.dart';

class ApplyJobs extends GetView<TimelineController> {
  ApplyJobs({Key? key}) : super(key: key);

  @override
  final TimelineController controller = Get.put(TimelineController());
  final PostJobsController postController = Get.put(PostJobsController());
  final FetchAlurMagangController fetchAlurMagangController =
      Get.put(FetchAlurMagangController());
  final FetchDosenController fetchDosenController =
      Get.put(FetchDosenController());
  final _companyNameController = TextEditingController();
  final _positionController = TextEditingController();

  void _submit() {
    if (controller.validate() &&
        fetchDosenController.isValidDosen.value &&
        _companyNameController.text.isNotEmpty &&
        _positionController.text.isNotEmpty) {
      postController.tempatMagang = _companyNameController.text;
      postController.posisiMagang = _positionController.text;
      postController.filepath = controller.selectedFile.value!.path!;
      postController.postProposal();
      print("Form valid and submitted");
    } else {
      if (_companyNameController.text.isEmpty ||
          _positionController.text.isEmpty) {
        Get.snackbar("Error", "Please fill in company name and position",
            animationDuration: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 1650),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            borderWidth: 5.0,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(20.0),
            icon: const Icon(CupertinoIcons.info_circle));
      } else if (fetchDosenController.isValidDosen.value == false) {
        Get.snackbar(
          "Error",
          "Please select a supervisor",
          animationDuration: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 1650),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderWidth: 5.0,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(20.0),
          icon: const Icon(CupertinoIcons.info_circle),
        );
      } else if (controller.selectedFile.value == null) {
        Get.snackbar(
          "Error",
          "File Is Required",
          animationDuration: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 1650),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderWidth: 5.0,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(20.0),
          icon: const Icon(CupertinoIcons.info_circle),
        );
      }
      print("Form not valid");
    }
  }

  void _submitRevisi() {
    if (controller.validate()) {
      postController.filepath = controller.selectedFile.value!.path!;
      postController.postRevisi();
      print("Form valid and submitted");
    } else {
      if (controller.selectedFile.value == null) {
        Get.snackbar(
          "Error",
          "File Is Required",
          animationDuration: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 1650),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderWidth: 5.0,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(20.0),
          icon: const Icon(CupertinoIcons.info_circle),
        );
      }
      print("Form not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Apply Jobs",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 72, 71, 156),
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Obx(() {
        if (fetchAlurMagangController
                .alurMagangModel.value.data.dataAlurMagang?.statusProposal ==
            'menunggu konfirmasi') {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 17,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Company's Name",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: fetchAlurMagangController.alurMagangModel
                              .value.data.dataAlurMagang?.tempatMagang,
                          border: InputBorder.none,
                        ),
                        enabled: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Internship Position",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: fetchAlurMagangController.alurMagangModel
                              .value.data.dataAlurMagang?.namaPosisi,
                          border: InputBorder.none,
                        ),
                        enabled: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (fetchAlurMagangController
                .alurMagangModel.value.data.dataAlurMagang?.statusProposal ==
            'revisi') {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 17,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Company's Name",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: fetchAlurMagangController.alurMagangModel
                              .value.data.dataAlurMagang?.tempatMagang,
                          border: InputBorder.none,
                        ),
                        enabled: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Internship Position",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: fetchAlurMagangController.alurMagangModel
                              .value.data.dataAlurMagang?.namaPosisi,
                          border: InputBorder.none,
                        ),
                        enabled: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 17,
                ),
                const Text(
                  "Upload revised Proposal",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Add your revised Proposal",
                ),
                const SizedBox(
                  height: 17,
                ),
                Obx(
                  () => controller.selectedFile.value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => controller.pickFile(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 32.0),
                              side: BorderSide(color: Colors.grey.shade400),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.upload_file,
                                    color: Colors.grey.shade700),
                                const SizedBox(width: 8.0),
                                Text(
                                  'Upload Proposal',
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.picture_as_pdf,
                                  color: Colors.red),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  controller.selectedFile.value!.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                '${(controller.selectedFile.value!.size / 1024).toStringAsFixed(1)} Kb',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              const SizedBox(width: 8.0),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: controller.removeFile,
                              ),
                            ],
                          ),
                        ),
                )
              ],
            ),
          );
        } else if (fetchAlurMagangController
                .alurMagangModel.value.data.dataAlurMagang?.statusProposal ==
            'diterima') {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 17,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Company's Name",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: fetchAlurMagangController.alurMagangModel
                              .value.data.dataAlurMagang?.tempatMagang,
                          border: InputBorder.none,
                        ),
                        enabled: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Internship Position",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: fetchAlurMagangController.alurMagangModel
                              .value.data.dataAlurMagang?.namaPosisi,
                          border: InputBorder.none,
                        ),
                        enabled: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 17,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Company's Name",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: _companyNameController,
                          decoration: const InputDecoration(
                            hintText: "Enter Company's Name",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter company's name";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Internship Position",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: _positionController,
                          decoration: const InputDecoration(
                            hintText: "Enter Position",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter internship position";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 17,
                      ),
                      const Text(
                        "Choose Supervisor",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade400),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Obx(
                              () {
                                return DropdownButton<DataDosen>(
                                  menuMaxHeight: 400,
                                  isExpanded: true,
                                  underline: const SizedBox.shrink(),
                                  value:
                                      fetchDosenController.selectedDosen.value,
                                  items: fetchDosenController.dosenList
                                      .map((DataDosen data) {
                                    return DropdownMenuItem<DataDosen>(
                                      value: data,
                                      child: Text(data.name),
                                    );
                                  }).toList(),
                                  onChanged: (DataDosen? newValue) {
                                    if (newValue != null) {
                                      fetchDosenController.selectedDosen.value =
                                          newValue;
                                      fetchDosenController.validateSelection();
                                    }
                                  },
                                );
                              },
                            ),
                            Obx(
                              () {
                                return fetchDosenController.isValidDosen.value
                                    ? const SizedBox.shrink()
                                    : const Text(
                                        'Please select a valid option',
                                        style: TextStyle(color: Colors.red),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      const Text(
                        "Upload Internship Proposal",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Add your Proposal to apply for a job",
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Obx(
                        () => controller.selectedFile.value == null
                            ? SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () => controller.pickFile(),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 32.0),
                                    side:
                                        BorderSide(color: Colors.grey.shade400),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.upload_file,
                                          color: Colors.grey.shade700),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        'Upload Proposal',
                                        style: TextStyle(
                                            color: Colors.grey.shade700),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.picture_as_pdf,
                                        color: Colors.red),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        controller.selectedFile.value!.name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      '${(controller.selectedFile.value!.size / 1024).toStringAsFixed(1)} Kb',
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                    const SizedBox(width: 8.0),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: controller.removeFile,
                                    ),
                                  ],
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
        color: Colors.white,
        height: 78,
        child: Obx(
          () {
            if (fetchAlurMagangController.alurMagangModel.value.data
                    .dataAlurMagang?.statusProposal ==
                'menunggu konfirmasi') {
              return TextButton(
                onPressed: () {
                  Get.snackbar("Info", "Verification in progress",
                      animationDuration: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 1650),
                      backgroundColor: Colors.grey,
                      colorText: Colors.white,
                      borderWidth: 5.0,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.all(20.0),
                      icon: const Icon(CupertinoIcons.info_circle));
                },
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: const MaterialStatePropertyAll(
                    Colors.grey,
                  ),
                ),
                child: const Text(
                  "Verfication in progress",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else if (fetchAlurMagangController.alurMagangModel.value.data
                    .dataAlurMagang?.statusProposal ==
                'revisi') {
              return TextButton(
                onPressed: _submitRevisi,
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 70, 116, 222),
                  ),
                ),
                child: const Text(
                  "Upload Revised Proposal",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else if (fetchAlurMagangController.alurMagangModel.value.data
                    .dataAlurMagang?.statusProposal ==
                'diterima') {
              return TextButton(
                onPressed: () {
                  Get.snackbar("Info", "Go to next step",
                      animationDuration: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 1650),
                      backgroundColor: Color.fromARGB(255, 70, 116, 222),
                      colorText: Colors.white,
                      borderWidth: 5.0,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.all(20.0),
                      icon: const Icon(CupertinoIcons.info_circle));
                },
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 70, 116, 222),
                  ),
                ),
                child: const Text(
                  "Your proposal is accepted",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return TextButton(
                onPressed: _submit,
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 70, 116, 222),
                  ),
                ),
                child: const Text(
                  "Apply Now",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
