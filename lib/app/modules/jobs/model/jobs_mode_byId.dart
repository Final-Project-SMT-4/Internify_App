// To parse this JSON data, do
//
//     final jobsModelById = jobsModelByIdFromJson(jsonString);

import 'dart:convert';

JobsModelById jobsModelByIdFromJson(String str) =>
    JobsModelById.fromJson(json.decode(str));

String jobsModelByIdToJson(JobsModelById data) => json.encode(data.toJson());

class JobsModelById {
  String message;
  Data data;

  JobsModelById({
    required this.message,
    required this.data,
  });

  factory JobsModelById.fromJson(Map<String, dynamic> json) => JobsModelById(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
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

    Data({
    this.id = 0,
    this.namaTempat = '',
    this.posisi = '',
    this.alamat = '',
    this.deskripsiPekerjaan = '',
    this.kriteria = '',
    this.deskripsiPerusahaan = '',
    this.website = '',
    this.employeeSize = 0,
    this.headOffice = '',
    this.since = 0,
    this.specialization = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
