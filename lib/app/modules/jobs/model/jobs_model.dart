// To parse this JSON data, do
//
//     final jobsModel = jobsModelFromJson(jsonString);

import 'dart:convert';

JobsModel jobsModelFromJson(String str) => JobsModel.fromJson(json.decode(str));

String jobsModelToJson(JobsModel data) => json.encode(data.toJson());

class JobsModel {
  String message;
  List<Datum> data;

  JobsModel({
    required this.message,
    required this.data,
  });

  factory JobsModel.fromJson(Map<String, dynamic> json) => JobsModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String namaTempat;
  String posisi;
  String alamat;
  String deskripsiPekerjaan;
  String kriteria;
  String deskripsiPerusahaan;
  String website;
  int employeeSize;
  String headOffice;
  int since;
  String specialization;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.namaTempat,
    required this.posisi,
    required this.alamat,
    required this.deskripsiPekerjaan,
    required this.kriteria,
    required this.deskripsiPerusahaan,
    required this.website,
    required this.employeeSize,
    required this.headOffice,
    required this.since,
    required this.specialization,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaTempat: json["nama_tempat"],
        posisi: json["posisi"],
        alamat: json["alamat"],
        deskripsiPekerjaan: json["deskripsi_pekerjaan"],
        kriteria: json["kriteria"],
        deskripsiPerusahaan: json["deskripsi_perusahaan"],
        website: json["website"],
        employeeSize: json["employee_size"],
        headOffice: json["head_office"],
        since: json["since"],
        specialization: json["specialization"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_tempat": namaTempat,
        "posisi": posisi,
        "alamat": alamat,
        "deskripsi_pekerjaan": deskripsiPekerjaan,
        "kriteria": kriteria,
        "deskripsi_perusahaan": deskripsiPerusahaan,
        "website": website,
        "employee_size": employeeSize,
        "head_office": headOffice,
        "since": since,
        "specialization": specialization,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
