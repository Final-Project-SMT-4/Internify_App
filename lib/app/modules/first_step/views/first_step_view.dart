// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simag_app/app/routes/app_pages.dart';

class FirstStepView extends StatelessWidget {
  FirstStepView({Key? key}) : super(key: key);

  // Variables to track back button
  int _backButtonPressCount = 0;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_backButtonPressCount == 0) {
          // start a timer to reset the count if not pressed again
          _backButtonPressCount++;
          _timer = Timer(const Duration(seconds: 1), () {
            _backButtonPressCount = 0;
          });
          // Show a snackbar or toast indicating press again to exit
          Get.snackbar(
            "Information",
            "Press again to exit",
            animationDuration: const Duration(milliseconds: 200),
            duration: const Duration(milliseconds: 1650),
            backgroundColor: const Color.fromARGB(255, 238, 238, 238),
            borderWidth: 5.0,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(20.0),
            icon: const Icon(CupertinoIcons.info_circle),
          );
          return false; // Do not exit the app yet
        } else {
          // Second press within the timer duration, exit the app
          _timer.cancel(); // Cancel the timer
          return true; // Allow the app to exit
        }
      },
      child: Scaffold(
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
              padding: EdgeInsets.only(top: 3.0),
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
