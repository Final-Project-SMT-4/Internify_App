// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simag_app/app/data/db_provider.dart';

import '../controllers/profile_controller.dart';

class MemberTeamView extends StatefulWidget {
  final int memberCount;
  const MemberTeamView({Key? key, required this.memberCount}) : super(key: key);

  @override
  State<MemberTeamView> createState() => _MemberTeamViewState();
}

class _MemberTeamViewState extends State<MemberTeamView> {
  final List<GlobalKey<FormBuilderState>> _formKeys = [];
  int currentPage = 0;
  int id = 0;
  String token = "";
  List<MemberData> membersData = [];

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
    final degreeProvider =
        Provider.of<ProfileController>(context, listen: false);
    degreeProvider.getDataProdi();

    // Initialize member data list based on the member count
    for (int i = 0; i < widget.memberCount; i++) {
      _formKeys.add(GlobalKey<FormBuilderState>());
      membersData.add(MemberData());
    }
  }

  Future<void> _fetchInitialData() async {
    int fetchedId = await DatabaseProvider().getUserId();
    String fetchedToken = await DatabaseProvider().getToken();

    setState(() {
      id = fetchedId;
      token = fetchedToken;
    });

    Provider.of<ProfileController>(context, listen: false)
        .getData(idUser: id, token: token);
  }

  // Function to extract the numeric ID from the degree string
  int? extractDegreeId(String degreeString) {
    final RegExp regex = RegExp(r'^\d+');
    final match = regex.firstMatch(degreeString);
    if (match != null) {
      return int.tryParse(match.group(0)!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            if (currentPage > 0) {
              setState(() {
                currentPage--;
              });
            } else {
              Navigator.pop(context);
            }
          },
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
            "Team Member",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              IndexedStack(
                index: currentPage,
                children: List.generate(
                  widget.memberCount,
                  (index) => buildMemberForm(index),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentPage > 0)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentPage--;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Back",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKeys[currentPage]
                          .currentState!
                          .saveAndValidate()) {
                        membersData[currentPage] =
                            MemberData.fromFormBuilderState(
                                _formKeys[currentPage].currentState!);

                        // print(
                        //     'Member ${currentPage + 1} data: ${membersData[currentPage]}');

                        if (currentPage < widget.memberCount - 1) {
                          setState(() {
                            currentPage++;
                          });
                        } else {
                          // print('All forms completed');
                          // print("All Data ${membersData}");
                          // Proceed with the next action, like navigating to save all data
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 70, 116, 222),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      currentPage < widget.memberCount - 1 ? "Next" : "Finish",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMemberForm(int index) {
    final degreeProvider = Provider.of<ProfileController>(context);

    return FormBuilder(
      key: _formKeys[index],
      onChanged: () {
        _formKeys[index].currentState!.save();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Team Member ${index + 1}",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Fullname :",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          FormBuilderTextField(
            name: "Fullname",
            keyboardType: TextInputType.name,
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
              hintText: "Fullname",
              hintStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.white),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 17,
                horizontal: 17,
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "NIM :",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          FormBuilderTextField(
            name: "NIM",
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
              hintText: "NIM",
              hintStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.white),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 17,
                horizontal: 17,
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Degree Program :",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          degreeProvider.degree.isNotEmpty
              ? FormBuilderDropdown<String>(
                  name: "degree",
                  isExpanded: false,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  items: degreeProvider.degree
                      .map(
                        (degree) => DropdownMenuItem(
                          value: degree,
                          child: Text(
                            degree,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  decoration: InputDecoration(
                    hintText: "Degree Program",
                    hintStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 17,
                      horizontal: 17,
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                )
              : Text(
                  "Loading ...",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Date Of Birth :",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          FormBuilderDateTimePicker(
            name: "DateOfBirth",
            inputType: InputType.date,
            format: DateFormat("dd/MM/yyyy"),
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
              hintText: "Hari/Bulan/Tahun",
              hintStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              suffix: const Icon(CupertinoIcons.calendar),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.white),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 17,
                horizontal: 17,
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Gender :",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          FormBuilderRadioGroup(
            name: "Gender",
            activeColor: const Color.fromARGB(255, 255, 178, 55),
            wrapAlignment: WrapAlignment.spaceBetween,
            options: [
              'Male',
              'Female',
            ]
                .map(
                  (gender) => FormBuilderFieldOption(
                    value: gender,
                  ),
                )
                .toList(),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.white),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 17,
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Email Address :",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          FormBuilderTextField(
            name: "EmailAddress",
            keyboardType: TextInputType.emailAddress,
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
              hintText: "Email Address",
              hintStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.white),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 17,
                horizontal: 17,
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Phone Number :",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          FormBuilderTextField(
            name: "PhoneNumber",
            keyboardType: TextInputType.number,
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
              hintText: "Phone Number",
              hintStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "+62",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.white),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 17,
                horizontal: 17,
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
        ],
      ),
    );
  }
}

// Define a class to hold member data
class MemberData {
  String? fullname;
  String? nim;
  String? department;
  DateTime? dateOfBirth;
  String? gender;
  String? emailAddress;
  String? phoneNumber;

  // Constructor
  MemberData({
    this.fullname,
    this.nim,
    this.department,
    this.dateOfBirth,
    this.gender,
    this.emailAddress,
    this.phoneNumber,
  });

  // Method to create MemberData from FormBuilderState
  factory MemberData.fromFormBuilderState(FormBuilderState formState) {
    return MemberData(
      fullname: formState.fields['Fullname']!.value,
      nim: formState.fields['NIM']!.value,
      department: formState.fields['department']!.value,
      dateOfBirth: formState.fields['DateOfBirth']!.value,
      gender: formState.fields['Gender']!.value,
      emailAddress: formState.fields['EmailAddress']!.value,
      phoneNumber: formState.fields['PhoneNumber']!.value,
    );
  }

  @override
  String toString() {
    return 'Fullname: $fullname, NIM: $nim, Department: $department, DateOfBirth: $dateOfBirth, Gender: $gender, EmailAddress: $emailAddress, PhoneNumber: $phoneNumber';
  }
}
