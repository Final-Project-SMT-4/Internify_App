// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simag_app/app/data/db_provider.dart';
import 'package:simag_app/app/routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 320,
                height: 320,
                child: Lottie.asset("assets/lottie/animation_simag.json"),
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
            ],
          ),
        ),
      ),
    );
  }
}

void navigate() {
  Future.delayed(const Duration(milliseconds: 1750), () {
    DatabaseProvider().getToken().then((value) {
      if (value == '') {
        Get.offAllNamed(Routes.FIRST_STEP);
      } else {
        Get.offAllNamed(Routes.NAVIGATION_BAR);
      }
    });
  });
}
