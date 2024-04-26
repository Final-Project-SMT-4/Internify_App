import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                width: 160,
                height: 160,
                child: Image.asset("assets/logo/logo.png"),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Internify.",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 70, 116, 222),
                  ),
                ),
              ),
              const SizedBox(
                height: 100.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 42.0,
                    child: Text(
                      "Find Your",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 70, 116, 222),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 42.0,
                    child: Text(
                      "Dream Internship",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 246, 127, 202),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 42.0,
                    child: Text(
                      "Here!",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 70, 116, 222),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Explore all the most exciting job roles based on your interest and study major.",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 49, 46, 58),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 70, 116, 222),
            onPressed: () => Get.offAllNamed(Routes.LOGIN),
            child: const Padding(
              padding: EdgeInsets.only(bottom: 3.0),
              child: Icon(
                CupertinoIcons.arrow_right,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
