// To parse this JSON data, do
//
//     final kelompokModel = kelompokModelFromJson(jsonString);

import 'dart:convert';

KelompokModel kelompokModelFromJson(String str) =>
    KelompokModel.fromJson(json.decode(str));

String kelompokModelToJson(KelompokModel data) => json.encode(data.toJson());

class KelompokModel {
  String message;
  DataKelompok data;

  KelompokModel({
    required this.message,
    required this.data,
  });

  factory KelompokModel.fromJson(Map<String, dynamic> json) => KelompokModel(
        message: json["message"],
        data: DataKelompok.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class DataKelompok {
  int id;
  String namaKelompok;
  int idUsers;
  int idDospem;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  List<dynamic> anggota;

  DataKelompok({
    this.id = 0,
    this.namaKelompok = '',
    this.idUsers = 0,
    this.idDospem = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.name = '',
    this.anggota = const [],
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory DataKelompok.fromJson(Map<String, dynamic> json) => DataKelompok(
        id: json["id"],
        namaKelompok: json["nama_kelompok"],
        idUsers: json["id_users"],
        idDospem: json["id_dospem"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        anggota: List<dynamic>.from(json["anggota"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_kelompok": namaKelompok,
        "id_users": idUsers,
        "id_dospem": idDospem,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "anggota": List<dynamic>.from(anggota.map((x) => x)),
      };
}
