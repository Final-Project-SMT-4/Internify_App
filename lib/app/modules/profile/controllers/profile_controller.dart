// ignore_for_file: unnecessary_overrides, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simag_app/app/constant/url.dart';

class ProfileController extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  String _resMessage = "";
  Map<String, dynamic> _userData = {};

  String get resMessage => _resMessage;
  Map<String, dynamic> get userData => _userData;

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
}
