// To parse this JSON data, do
//
//     final dosenModel = dosenModelFromJson(jsonString);

import 'dart:convert';

DosenModel dosenModelFromJson(String str) => DosenModel.fromJson(json.decode(str));

String dosenModelToJson(DosenModel data) => json.encode(data.toJson());

class DosenModel {
    String message;
    List<DataDosen> data;

    DosenModel({
        required this.message,
        required this.data,
    });

    factory DosenModel.fromJson(Map<String, dynamic> json) => DosenModel(
        message: json["message"],
        data: List<DataDosen>.from(json["data"].map((x) => DataDosen.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DataDosen {
    int id;
    String name;
    String noIdentitas;
    String email;
    dynamic emailVerifiedAt;
    String role;
    dynamic foto;
    dynamic noTelp;
    dynamic createdAt;
    dynamic updatedAt;
    dynamic isAccepted;
    dynamic angkatan;
    dynamic golongan;
    dynamic prodiId;
    dynamic tanggalLahir;
    dynamic jenisKelamin;

    DataDosen({
        required this.id,
        required this.name,
        required this.noIdentitas,
        required this.email,
        required this.emailVerifiedAt,
        required this.role,
        required this.foto,
        required this.noTelp,
        required this.createdAt,
        required this.updatedAt,
        required this.isAccepted,
        required this.angkatan,
        required this.golongan,
        required this.prodiId,
        required this.tanggalLahir,
        required this.jenisKelamin,
    });

    factory DataDosen.fromJson(Map<String, dynamic> json) => DataDosen(
        id: json["id"],
        name: json["name"],
        noIdentitas: json["no_identitas"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        role: json["role"],
        foto: json["foto"],
        noTelp: json["no_telp"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isAccepted: json["is_accepted"],
        angkatan: json["angkatan"],
        golongan: json["golongan"],
        prodiId: json["prodi_id"],
        tanggalLahir: json["tanggal_lahir"],
        jenisKelamin: json["jenis_kelamin"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "no_identitas": noIdentitas,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role": role,
        "foto": foto,
        "no_telp": noTelp,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_accepted": isAccepted,
        "angkatan": angkatan,
        "golongan": golongan,
        "prodi_id": prodiId,
        "tanggal_lahir": tanggalLahir,
        "jenis_kelamin": jenisKelamin,
    };
}
