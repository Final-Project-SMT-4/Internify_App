// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, avoid_print, unused_element, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:simag_app/app/modules/jobs/controllers/fetch_jobs_controller.dart';
import 'package:url_launcher/link.dart';
import 'package:get/get.dart';

class Page2About extends StatelessWidget {
  const Page2About({super.key});

  @override
  Widget build(BuildContext context) {
    final FetchJobsByIdController fetchController = Get.find();
    print(fetchController);

    return Obx(() {
      if (fetchController.jobsModel.value.message.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        final job = fetchController.jobsModel.value.data;

        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _contentAboutCompany(
                  title: "About Company",
                  desc: job.deskripsiPerusahaan,
                ),
                Text(
                  "Website",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Link(
                  target: LinkTarget.defaultTarget,
                  uri: Uri.parse(job.website),
                  builder: (context, followLink) => InkWell(
                    onTap: followLink,
                    child: Text(
                      job.website,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                _contentAboutCompany(
                  title: "Employee size",
                  desc: job.employeeSize.toString(),
                ),
                _contentAboutCompany(
                  title: "Head Office",
                  desc: job.headOffice,
                ),
                _contentAboutCompany(
                  title: "Since",
                  desc: job.since.toString(),
                ),
                _contentAboutCompany(
                  title: "Specialization",
                  desc: job.specialization,
                ),
                SizedBox(
                  height: 75,
                )
              ],
            ),
          ),
        );
      }
    });
  }
}

class _contentAboutCompany extends StatelessWidget {
  final String title;
  final String desc;

  const _contentAboutCompany({
    super.key,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          desc,
        ),
        SizedBox(
          height: 17,
        ),
      ]),
    );
  }
}
