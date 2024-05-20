// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simag_app/app/modules/jobs/controllers/jobs_controller.dart';

class ApplyJobs extends GetView<JobsController> {
  const ApplyJobs({super.key});

  @override
  Widget build(BuildContext context) {
    JobsController controller = Get.put(JobsController());

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 140,
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
                        Container(
                          margin: EdgeInsets.only(top: 70),
                          child: CircleAvatar(
                            radius: 56,
                            backgroundImage:
                                AssetImage("assets/images/profile.png"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Front-end Programming",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "JV Partner Indonesia",
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
                      "Upload Internship Proposal",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => controller.pickFile(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
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
                            SizedBox(width: 8.0),
                            Text(
                              'Upload Proposal',
                              style: TextStyle(color: Colors.grey.shade700),
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
          Container(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: InkWell(
              onTap: () => Get.back(),
              child: Icon(CupertinoIcons.arrow_left, size: 30),
            ),
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
                onPressed: () {},
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
      ),
    );
  }
}
