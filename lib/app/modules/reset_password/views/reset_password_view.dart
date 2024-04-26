import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simag_app/app/modules/forget_password/views/forget_password_view.dart';
import 'package:simag_app/app/routes/app_pages.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  ResetPasswordView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  final _obscureNew = true.obs;
  final _obscureRe_enter = true.obs;

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
                            FormBuilderValidators.equalLength(8),
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
                            FormBuilderValidators.equalLength(8),
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
                        child: ElevatedButton(
                          onPressed: () => Get.offAllNamed(Routes.LOGIN),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 70, 116, 222),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Reset Password",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
