// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/jobs_controller.dart';

class JobsView extends GetView<JobsController> {
  const JobsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          backgroundColor: Color.fromARGB(255, 72, 71, 156),
          title: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15, 12, 15, 12),
                    prefixIcon: Icon(CupertinoIcons.search),
                    hintText: "Search",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15, 12, 15, 12),
                    prefixIcon: Icon(CupertinoIcons.location_solid),
                    hintText: "Location",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(38, 0, 0, 0),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(0, -2))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.png"),
                  backgroundColor: Colors.transparent,
                  radius: 26,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Front-end Proggrammer",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Text(
                  "JV Partner Indonesia",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Location : Komplek Pertokoan Sawojajar Jalan Danau Toba Blok C22, Sawojajar, Kec. Kedungkandang, Kota Malang, Jawa Timur 56138",
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          foregroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 21, 10, 51)),
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(51, 246, 127, 202),
                          ),
                        ),
                        onPressed: () {},
                        child: Text("About"),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          foregroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 21, 10, 51),
                          ),
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(51, 70, 116, 222),
                          ),
                        ),
                        onPressed: () {},
                        child: Text("Apply"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
