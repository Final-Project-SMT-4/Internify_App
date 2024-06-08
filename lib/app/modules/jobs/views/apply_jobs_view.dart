// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simag_app/app/modules/jobs/controllers/fetch_jobs_controller.dart';
import 'package:simag_app/app/modules/jobs/controllers/jobs_controller.dart';
import 'package:simag_app/app/modules/jobs/controllers/post_jobs_controller.dart';
import 'package:simag_app/app/modules/jobs/model/dosen_model.dart';

class ApplyJobs extends GetView<JobsController> {
  ApplyJobs({super.key});
  PostJobsController postController = Get.put(PostJobsController());
  FetchJobsByIdController fetchJobsByIdController = Get.find();
  FetchDosenController fetchDosenController = Get.put(FetchDosenController());

  void _submit() {
    if (controller.validate() && fetchDosenController.isValidDosen.value) {
      postController.filepath = controller.selectedFile.value!.path!;
      postController.postProposal();
      print("Form valid and submitted");
    } else {
      if (fetchDosenController.isValidDosen.value == false) {
        Get.snackbar(
          "Error",
          "Please select a supervisor",
          animationDuration: Duration(milliseconds: 300),
          duration: Duration(milliseconds: 1650),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderWidth: 5.0,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(20.0),
          icon: Icon(CupertinoIcons.info_circle),
        );
      } else if (controller.selectedFile.value == null) {
        Get.snackbar(
          "Error",
          "File Is Required",
          animationDuration: Duration(milliseconds: 300),
          duration: Duration(milliseconds: 1650),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderWidth: 5.0,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(20.0),
          icon: Icon(CupertinoIcons.info_circle),
        );
      }
      print("Form not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(
        () {
          if (fetchJobsByIdController.jobsModel.value.message.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final job = fetchJobsByIdController.jobsModel.value.data;
            return Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              color: Colors.white,
                              height: 70,
                            ),
                            Container(
                              color: Color.fromARGB(255, 242, 242, 242),
                              height: 140,
                            ),
                          ],
                        ),
                        Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 56,
                                backgroundImage:
                                    AssetImage("assets/images/profile.png"),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  job.posisi,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                job.namaTempat,
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 17,
                          ),
                          Text(
                            "Choose Supervisor",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade400),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Obx(
                                  () {
                                    return DropdownButton<DataDosen>(
                                      menuMaxHeight: 400,
                                      isExpanded: true,
                                      underline: SizedBox.shrink(),
                                      value: fetchDosenController
                                          .selectedDosen.value,
                                      items: fetchDosenController.dosenList
                                          .map((DataDosen data) {
                                        return DropdownMenuItem<DataDosen>(
                                          value: data,
                                          child: Text(data.name),
                                        );
                                      }).toList(),
                                      onChanged: (DataDosen? newValue) {
                                        if (newValue != null) {
                                          fetchDosenController
                                              .selectedDosen.value = newValue;
                                          fetchDosenController
                                              .validateSelection();
                                        }
                                      },
                                    );
                                  },
                                ),
                                Obx(
                                  () {
                                    return fetchDosenController
                                            .isValidDosen.value
                                        ? SizedBox.shrink()
                                        : Text(
                                            'Please select a valid option',
                                            style: TextStyle(color: Colors.red),
                                          );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          Text(
                            "Upload Internship Proposal",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add your Proposal to apply for a job",
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          Obx(
                            () => controller.selectedFile.value == null
                                ? SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () => controller.pickFile(),
                                      style: OutlinedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.0, horizontal: 32.0),
                                        side: BorderSide(
                                            color: Colors.grey.shade400),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.upload_file,
                                              color: Colors.grey.shade700),
                                          SizedBox(width: 8.0),
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
                                    padding: EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.picture_as_pdf,
                                            color: Colors.red),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                            controller.selectedFile.value!.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          '${(controller.selectedFile.value!.size / 1024).toStringAsFixed(1)} Kb',
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                        SizedBox(width: 8.0),
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: controller.removeFile,
                                        ),
                                      ],
                                    ),
                                  ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                    color: Colors.white,
                    height: 78,
                    child: TextButton(
                      onPressed: _submit,
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 70, 116, 222),
                        ),
                      ),
                      child: Text(
                        "Apply Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
