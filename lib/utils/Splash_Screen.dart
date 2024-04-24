// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                height: 350,
                child: Lottie.asset("assets/lottie/animation_simag.json"),
              ),
              const Text(
                "Internify.",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 70, 116, 222),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
