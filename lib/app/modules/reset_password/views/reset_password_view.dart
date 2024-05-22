// ignore_for_file: non_constant_identifier_names, deprecated_member_use, must_be_immutable

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simag_app/app/provider/auth_provider.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  ResetPasswordView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  final _obscureNew = true.obs;
  final _obscureRe_enter = true.obs;

  // Variables to track back button
  int _backButtonPressCount = 0;
  late Timer _timer;

  // Function to check if the keyboard is visible
  bool isKeyboardVisible(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.viewInsets.bottom > 0;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        Get.arguments as Map<String, dynamic>?;
    final int idUser = arguments?['id_user'] ?? 0;

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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reset Password",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 70, 116, 222),
                      ),
                    ),
                  ),
                  Text(
                    "Create a new password and ensure it differs from previous ones for security.",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Password :",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => FormBuilderTextField(
                            name: 'password',
                            keyboardType: TextInputType.visiblePassword,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                CupertinoIcons.lock,
                                size: 18.0,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureNew.value
                                      ? CupertinoIcons.eye
                                      : CupertinoIcons.eye_slash,
                                  size: 18.0,
                                ),
                                onPressed: () {
                                  _obscureNew.toggle();
                                },
                              ),
                              hintText: "New Password",
                              hintStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 17,
                                horizontal: 17,
                              ),
                            ),
                            obscureText: _obscureNew.value,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.minLength(8),
                              FormBuilderValidators.required(),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Confirm Password :",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => FormBuilderTextField(
                            name: 'confirmPassword',
                            keyboardType: TextInputType.visiblePassword,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                CupertinoIcons.lock,
                                size: 18.0,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureRe_enter.value
                                      ? CupertinoIcons.eye
                                      : CupertinoIcons.eye_slash,
                                  size: 18.0,
                                ),
                                onPressed: () {
                                  _obscureRe_enter.toggle();
                                },
                              ),
                              hintText: "Re-enter Password",
                              hintStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 17,
                                horizontal: 17,
                              ),
                            ),
                            obscureText: _obscureRe_enter.value,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.minLength(8),
                              FormBuilderValidators.required(),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 35.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50.0,
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
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        final formData =
                                            _formKey.currentState!.value;

                                        final String password =
                                            formData['password'];
                                        final String confirmPassword =
                                            formData['confirmPassword'];

                                        if (confirmPassword == password) {
                                          if (auth.responseData != 0) {
                                            auth.resetPassword(
                                                idUser: auth.responseData,
                                                password: confirmPassword
                                                    .toString()
                                                    .trim());
                                          } else {
                                            if (idUser != 0) {
                                              auth.resetPassword(
                                                  idUser: idUser,
                                                  password: confirmPassword
                                                      .toString()
                                                      .trim());
                                            }
                                          }
                                        } else {
                                          Get.snackbar(
                                            "Information",
                                            "Password And Confirm Password Not Match",
                                            animationDuration: const Duration(
                                                milliseconds: 300),
                                            duration: const Duration(
                                                milliseconds: 1650),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 238, 238, 238),
                                            borderWidth: 5.0,
                                            snackPosition: SnackPosition.BOTTOM,
                                            margin: const EdgeInsets.all(20.0),
                                            icon: const Icon(
                                              CupertinoIcons
                                                  .checkmark_alt_circle,
                                            ),
                                          );
                                        }
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
                                      "Reset Password",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ),
                                    ),
                            );
                          }),
                        ),
                      ],
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
