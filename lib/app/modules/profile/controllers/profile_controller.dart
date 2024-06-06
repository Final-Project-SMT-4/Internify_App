// ignore_for_file: unnecessary_overrides, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simag_app/app/constant/url.dart';
import 'package:simag_app/app/modules/profile/views/member_team_view.dart';
import 'package:simag_app/app/routes/app_pages.dart';

class ProfileController extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  bool _isLoading = false;
  String _resMessage = "";
  String _message = "";
  Map<String, dynamic> _userData = {};
  List<String> _degree = [];

  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  String get message => _message;
  Map<String, dynamic> get userData => _userData;
  List<String> get degree => _degree;

  void getData({
    required int idUser,
    required String token,
    BuildContext? context,
  }) async {
    String url = "$requestBaseUrl/get-user";

    final body = {
      "id_user": idUser,
    };
    print(body);

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      if (req.statusCode == 200) {
        final res = json.decode(req.body);

        print(res);

        _userData = res["response"];
        _resMessage = "Success";

        notifyListeners();
      } else {
        final res = json.decode(req.body);

        print(res);

        _resMessage = res["message"];

        notifyListeners();
      }
    } on SocketException catch (_) {
      _resMessage = "Internet connection is not available";
    } catch (e) {
      _resMessage = "Please try again";
      notifyListeners();

      print(e);
    }
  }

  Future<void> getDataProdi() async {
    String url = "$requestBaseUrl/get-prodi";

    try {
      http.Response req = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (req.statusCode == 200) {
        final res = json.decode(req.body);

        print(res);

        _degree = (res["response"] as List)
            .map((prodi) => "${prodi["id"]}. ${prodi["nama_prodi"]}")
            .toList();
        _resMessage = "Success";

        notifyListeners();
      } else {
        final res = json.decode(req.body);

        print(res);

        _resMessage = res["message"];

        notifyListeners();
      }
    } on SocketException catch (_) {
      _resMessage = "Internet connection is not available";
    } catch (e) {
      _resMessage = "Please try again";
      notifyListeners();

      print(e);
    }
  }

  void updateProfile({
    required int idUser,
    required String token,
    required String name,
    required String nim,
    required String email,
    required int? prodiId,
    required String noTelp,
    required DateTime tanggalLahir,
    required String gender,
    required String college,
    required String group,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/update-user";

    final body = {
      "id": idUser,
      "name": name,
      "nim": nim,
      "email": email,
      "prodi_id": prodiId,
      "no_telp": noTelp,
      "tanggal_lahir": tanggalLahir.toIso8601String(),
      "gender": gender,
      "angkatan": college,
      "golongan": group,
    };
    print(body);

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      if (req.statusCode == 200) {
        final res = json.decode(req.body);

        print(res);

        _isLoading = true;
        _message = "Successfully Update Profile";

        notifyListeners();

        Get.back();
      } else {
        final res = json.decode(req.body);

        print(res);

        _isLoading = false;
        _message = res["message"];

        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _message = "Internet connection is not available";
    } catch (e) {
      _isLoading = false;
      _message = "Please try again";
      notifyListeners();

      print(e);
    }
  }

  Future<void> insertMyTeam(List<MemberData> membersData, String token) async {
    _isLoading = true;
    notifyListeners();

    List<Map<String, dynamic>> anggota = membersData.map((member) {
      return {
        'nim': member.nim,
        'nama': member.fullname,
        'id_prodi': member.prodiId,
        'angkatan': member.angkatan,
        'golongan': member.golongan,
        'email': member.email,
        'no_telp': member.phoneNumber,
        'tanggal_lahir': member.dateOfBirth!.toIso8601String(),
        'gender': member.gender,
      };
    }).toList();

    String url = "$requestBaseUrl/create-kelompok";
    final body = jsonEncode({
      'anggota': anggota,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);

        print(res);

        _isLoading = false;
        _message = "Successfully Created Team";

        notifyListeners();
        Get.until((route) => Get.currentRoute == Routes.NAVIGATION_BAR);
      } else {
        final res = json.decode(response.body);

        print(res);

        _isLoading = false;
        _message = res["message"];

        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _message = "Internet connection is not available";
    } catch (e) {
      _isLoading = false;
      _message = "Please try again";
      notifyListeners();

      print(e);
    }
  }

  void clear() {
    _isLoading = false;
    _message = "";

    notifyListeners();
  }
}
