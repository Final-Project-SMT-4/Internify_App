// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:simag_app/app/constant/url.dart';
import 'package:simag_app/app/data/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:simag_app/app/modules/jobs/controllers/fetch_jobs_controller.dart';
import 'package:simag_app/app/routes/app_pages.dart';

class PostJobsController extends GetxController {
  var selectedMagang = 0.obs;
  var filepath = "";

  Future<void> postProposal() async {
    //gettoken
    final requestBaseUrl = AppUrl.baseUrl;
    final dbProvider = Get.put(DatabaseProvider());
    final token = await dbProvider.getToken();

    //get id kelompok
    final FetchKelompokController fetchKelompok =
        Get.put(FetchKelompokController());
    await fetchKelompok.fetchKelompok();
    final idKelompok = fetchKelompok.kelompokModel.value.data.id;

    //get id tempat magang
    final FetchJobsControllerById fetchJobsById = Get.find();
    final idTempatMagang = fetchJobsById.selectedMagang;

    //prepare post proposal
    final urlProposal =
        Uri.parse('$requestBaseUrl/upload-proposal/$idKelompok');
    var requestProposal = http.MultipartRequest('POST', urlProposal);
    requestProposal.fields['id'] = idKelompok.toString();
    requestProposal.files
        .add(await http.MultipartFile.fromPath('proposal', filepath));

    try {
      //post tempat magang
      final urlTempatMagang =
          Uri.parse('$requestBaseUrl/insert-tempat-magang-by-id/$idKelompok');

      final responseTempatMagang = await http.post(
        urlTempatMagang,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'id_tempat_magang': idTempatMagang.toString(),
        },
      );

      //post proposal
      requestProposal.headers['Authorization'] = 'Bearer $token';
      requestProposal.headers['Accept'] = 'application/json';
      final streamedResponse = await requestProposal.send();
      final responseProposal = await http.Response.fromStream(streamedResponse);

      if (responseProposal.statusCode == 200 &&
          responseTempatMagang.statusCode == 200) {
        print('Response: ${responseProposal.body}');
        print('Response: ${responseTempatMagang.body}');
        Get.offAllNamed(Routes.NAVIGATION_BAR);
      } else {
        print('Failed to upload proposal: ${responseProposal.statusCode}');
        print(
            'Failed to insert tempat magang: ${responseTempatMagang.statusCode}');
        print('Response: ${responseProposal.body}');
        print('Response: ${responseTempatMagang.body}');
      }
    } catch (error) {
      print('Error uploading alur magang: $error');
    }
  }
}