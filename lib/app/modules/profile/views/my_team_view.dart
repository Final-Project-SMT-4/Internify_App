import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:simag_app/app/modules/profile/views/member_team_view.dart';

class MyTeamView extends StatefulWidget {
  const MyTeamView({super.key});

  @override
  State<MyTeamView> createState() => _MyTeamViewState();
}

class _MyTeamViewState extends State<MyTeamView> {
  final _formKey = GlobalKey<FormBuilderState>();
  int _selectedMembers = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          child: const Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(
            top: 5,
          ),
          child: Text(
            "My Team Profile",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                width: 350,
                height: 350,
                child: Lottie.asset("assets/lottie/animation_team.json"),
              ),
              FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "How many members in a group?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormBuilderChoiceChip<int>(
                      name: 'members_group',
                      alignment: WrapAlignment.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      options: [
                        FormBuilderChipOption(
                          value: 3,
                          child: Text(
                            '3',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        FormBuilderChipOption(
                          value: 4,
                          child: Text(
                            '4',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        FormBuilderChipOption(
                          value: 5,
                          child: Text(
                            '5',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                      spacing: 10.0,
                      runSpacing: 10.0,
                      onChanged: (value) {
                        setState(() {
                          _selectedMembers = value ?? 0;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_selectedMembers != 0) {
                            Get.snackbar(
                              "Success",
                              "Form successfully created!",
                              animationDuration:
                                  const Duration(milliseconds: 200),
                              duration: const Duration(milliseconds: 1650),
                              backgroundColor:
                                  const Color.fromARGB(255, 238, 238, 238),
                              borderWidth: 5.0,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(20.0),
                              icon: const Icon(CupertinoIcons.info_circle),
                            );
                            Get.to(() =>
                                MemberTeamView(memberCount: _selectedMembers));
                          } else {
                            Get.snackbar(
                              "Error",
                              "Please select member of group!",
                              animationDuration:
                                  const Duration(milliseconds: 200),
                              duration: const Duration(milliseconds: 1650),
                              backgroundColor:
                                  const Color.fromARGB(255, 238, 238, 238),
                              borderWidth: 5.0,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(20.0),
                              icon: const Icon(CupertinoIcons.info_circle),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 70, 116, 222),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Save",
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
    );
  }
}
