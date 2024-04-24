import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simag_app/app/routes/app_pages.dart';

import '../controllers/first_step_controller.dart';

class FirstStepView extends GetView<FirstStepController> {
  const FirstStepView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 170,
                height: 170,
                child: Image.asset("assets/logo/logo.png"),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Internify.",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 70, 116, 222),
                ),
              ),
              const SizedBox(
                height: 100.0,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.0,
                    child: Text(
                      "Find Your",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 70, 116, 222),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                    child: Text(
                      "Dream Internship",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 246, 127, 202),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                    child: Text(
                      "Here!",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 70, 116, 222),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Explore all the most exciting job roles based on your interest and study major.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 49, 46, 58),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 70, 116, 222),
            onPressed: () => Get.offAllNamed(Routes.LOGIN),
            child: const Icon(
              CupertinoIcons.arrow_right,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
