import 'package:get/get.dart';
import 'package:simag_app/app/constant/url.dart';
import 'package:simag_app/app/data/db_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simag_app/app/modules/timeline/model/dosen_model.dart';
import 'package:simag_app/app/modules/timeline/model/kelompok_model.dart';
import 'package:simag_app/app/modules/timeline/model/alur_magang_model.dart';

class FetchKelompokController extends GetxController {
  var kelompokModel = KelompokModel(
      message: '',
      response: DataKelompok(
          id: 0,
          namaKelompok: '',
          idUsers: 0,
          idDospem: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          namaDosen: '',
          anggota: [])).obs;

  @override
  void onInit() {
    super.onInit();
    fetchKelompok();
  }

  Future<void> fetchKelompok() async {
    final requestBaseUrl = AppUrl.baseUrl;
    final dbProvider = Get.put(DatabaseProvider());
    final token = await dbProvider.getToken();
    final idUSer = await dbProvider.getUserId();

    final url = Uri.parse('$requestBaseUrl/get-kelompok');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'id': idUSer.toString(),
      },
    );

    if (response.statusCode == 200) {
      kelompokModel.value = kelompokModelFromJson(response.body);
    } else {
      throw Exception('Failed to load kelompok');
    }
  }
}

class FetchDosenController extends GetxController {
  var dosenList = <DataDosen>[].obs;
  var selectedDosen = DataDosen(
    id: 0,
    name: 'Select supervisor',
    noIdentitas: '',
    email: '',
    emailVerifiedAt: null,
    role: '',
    foto: null,
    noTelp: null,
    createdAt: null,
    updatedAt: null,
    isAccepted: null,
    angkatan: null,
    golongan: null,
    prodiId: null,
    tanggalLahir: null,
    jenisKelamin: null,
  ).obs;
  var isValidDosen = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDosen();
  }

  Future<List<DataDosen>> fetchDosen() async {
    final requestBaseUrl = AppUrl.baseUrl;
    final dbProvider = Get.put(DatabaseProvider());
    final token = await dbProvider.getToken();

    final response = await http.get(
      Uri.parse('$requestBaseUrl/get-dosen'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var dosenData = DosenModel.fromJson(data);
      dosenList.assignAll(dosenData.data);
      dosenList.insert(0, selectedDosen.value); // Add a default option
      return dosenList.toList();
    } else {
      throw Exception('Failed to load dosen');
    }
  }

  void validateSelection() {
    if (selectedDosen.value.id == 0) {
      isValidDosen.value = false;
    } else {
      isValidDosen.value = true;
    }
  }
}

class FetchAlurMagangController extends GetxController {
  var alurMagangModel = AlurMagangModel(
          message: '', data: Data(message: '', dataAlurMagang: null))
      .obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchAlurMagang();
    super.onInit();
  }

  Future<void> fetchAlurMagang() async {
    isLoading.value = true;
    final requestBaseUrl = AppUrl.baseUrl;
    final dbProvider = Get.put(DatabaseProvider());
    final token = await dbProvider.getToken();
    final url = Uri.parse('$requestBaseUrl/get-alur-magang');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      alurMagangModel.value = alurMagangModelFromJson(response.body);
      print(url);
      print(response.body);
    } else {
      throw Exception('Failed to load alur magang');
    }
    isLoading.value = false;
  }
}
