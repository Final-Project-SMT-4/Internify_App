import 'package:get/get.dart';
import 'package:simag_app/app/constant/url.dart';
import 'package:simag_app/app/data/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:simag_app/app/modules/jobs/controllers/fetch_jobs_controller.dart';
import 'package:simag_app/app/modules/navigation_bar/controllers/navigation_bar_controller.dart';
import 'package:simag_app/app/routes/app_pages.dart';

class PostJobsController extends GetxController {
  var selectedMagang = 0.obs;
  var filepath = "";

  Future<void> postProposal() async {
    final requestBaseUrl = AppUrl.baseUrl;
    final dbProvider = Get.put(DatabaseProvider());
    final token = await dbProvider.getToken();

    final FetchKelompokController fetchKelompok =
        Get.put(FetchKelompokController());
    await fetchKelompok.fetchKelompok();
    final idKelompok = fetchKelompok.kelompokModel.value.data.id;

    final url = Uri.parse('$requestBaseUrl/upload-proposal/$idKelompok');

    var request = http.MultipartRequest('POST', url);
    request.fields['id'] = idKelompok.toString();

    request.files.add(await http.MultipartFile.fromPath('proposal', filepath));

    try {
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        Get.offAllNamed(Routes.NAVIGATION_BAR);
      } else {
        print('Failed to upload proposal: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading proposal: $error');
    }
  }
}
