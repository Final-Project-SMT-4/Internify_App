// ignore_for_file: must_be_immutable, deprecated_member_use

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:simag_app/app/provider/auth_provider.dart';

import '../controllers/code_otp_controller.dart';

class CodeOtpView extends GetView<CodeOtpController> {
  CodeOtpView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  // Variables to track back button
  int _backButtonPressCount = 0;
  late Timer _timer;

  // Variable to store the OTP code
  String _otpCode = '';

  // Function to check if the keyboard is visible
  bool isKeyboardVisible(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.viewInsets.bottom > 0;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        Get.arguments as Map<String, dynamic>;
    final String email = arguments['email'];

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
        body: Center(
          child: SingleChildScrollView(
            physics: isKeyboardVisible(context)
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Code OTP",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 37,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 70, 116, 222),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "We’ve sent a reset code to ",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        children: [
                          TextSpan(
                            text: email,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          TextSpan(
                            text:
                                " enter 4 digit code that mentioned in the email.",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    FormBuilder(
                      key: _formKey,
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        pastedTextStyle: const TextStyle(
                          color: Color.fromARGB(255, 100, 141, 219),
                          fontWeight: FontWeight.bold,
                        ),
                        obscureText: true,
                        obscuringWidget: const Icon(
                          CupertinoIcons.lock_fill,
                          size: 20,
                          color: Color.fromARGB(255, 84, 84, 84),
                        ),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15.0),
                          fieldHeight: 55,
                          fieldWidth: 50,
                          activeFillColor: Colors.white,
                          inactiveColor:
                              const Color.fromARGB(255, 225, 225, 225),
                          activeColor: const Color.fromARGB(255, 100, 141, 219),
                        ),
                        cursorColor: Colors.black,
                        animationType: AnimationType.fade,
                        animationDuration: const Duration(milliseconds: 300),
                        keyboardType: TextInputType.number,
                        textStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            height: 1.6,
                          ),
                        ),
                        onCompleted: (value) {
                          _otpCode = value;

                          Provider.of<AuthenticationProvider>(context,
                                  listen: false)
                              .codeOTP(otp: value.toString().trim());
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Consumer<AuthenticationProvider>(
                          builder: (context, auth, child) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (auth.resMessage != '') {
                            Get.snackbar(
                              "Information",
                              auth.resMessage,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              duration: const Duration(milliseconds: 1650),
                              backgroundColor:
                                  const Color.fromARGB(255, 238, 238, 238),
                              borderWidth: 5.0,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(20.0),
                              icon: const Icon(
                                CupertinoIcons.checkmark_alt_circle,
                              ),
                            );

                            auth.clear();
                          }
                        });
                        return ElevatedButton(
                          onPressed: auth.isLoading
                              ? null
                              : () {
                                  if (_otpCode != '') {
                                    auth.codeOTP(
                                        otp: _otpCode.toString().trim());
                                  } else {
                                    Get.snackbar(
                                      "Information",
                                      "Code OTP Cannot Empty",
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      duration:
                                          const Duration(milliseconds: 1650),
                                      backgroundColor: const Color.fromARGB(
                                          255, 238, 238, 238),
                                      borderWidth: 5.0,
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: const EdgeInsets.all(20.0),
                                      icon: const Icon(
                                        CupertinoIcons.checkmark_alt_circle,
                                      ),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: auth.isLoading
                                ? Colors.grey
                                : const Color.fromARGB(255, 70, 116, 222),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: auth.isLoading
                              ? Text(
                                  "Loading ...",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                )
                              : Text(
                                  "Verify Code",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Obx(
                        () => GestureDetector(
                          onTap: controller.canResendEmail.value
                              ? () {
                                  controller.resendEmail();

                                  Provider.of<AuthenticationProvider>(context,
                                          listen: false)
                                      .resendCodeOTP(email: email);
                                }
                              : null,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Haven’t got the email?",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    controller.canResendEmail.value
                                        ? "Resend Email"
                                        : "Resend in 0.${controller.resendCountDown.value}",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 49, 46, 58),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
