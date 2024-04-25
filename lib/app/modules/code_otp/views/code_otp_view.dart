import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simag_app/app/routes/app_pages.dart';

import '../controllers/code_otp_controller.dart';

class CodeOtpView extends GetView<CodeOtpController> {
  CodeOtpView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  // Function to check if the keyboard is visible
  bool isKeyboardVisible(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.viewInsets.bottom > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          text: "user@gmail.com",
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
                              " enter 5 digit code that mentioned in the email.",
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
                      length: 5,
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
                        inactiveColor: const Color.fromARGB(255, 225, 225, 225),
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
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Get.offAllNamed(Routes.RESET_PASSWORD),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 70, 116, 222),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Verify Code",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.offAllNamed(Routes.REGISTER),
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
                                "Resend Email",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
