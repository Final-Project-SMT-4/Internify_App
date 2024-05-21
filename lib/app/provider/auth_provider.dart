// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simag_app/app/Constant/url.dart';
import 'package:http/http.dart' as http;
import 'package:simag_app/app/data/db_provider.dart';
import 'package:simag_app/app/routes/app_pages.dart';

class AuthenticationProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  bool _isLoading = false;
  String _resMessage = "";

  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/login";

    final body = {
      "email": email,
      "password": password,
    };
    print(body);

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (req.statusCode == 200) {
        final res = json.decode(req.body);

        print(req.body);

        _isLoading = true;
        _resMessage = "Login Success";

        notifyListeners();

        // Save User Data & Navigate To Dashboard
        final userId = res["response"]["user"]["id"];
        final token = res["response"]["token"];

        DatabaseProvider().saveToken(token);
        DatabaseProvider().saveUserId(userId);

        Get.offAllNamed(Routes.NAVIGATION_BAR);
      } else {
        final res = json.decode(req.body);

        print(res);

        _isLoading = false;
        _resMessage = res["message"];

        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();

      print(e);
    }
  }

  void clear() {
    _isLoading = false;
    _resMessage = "";

    notifyListeners();
  }
}
