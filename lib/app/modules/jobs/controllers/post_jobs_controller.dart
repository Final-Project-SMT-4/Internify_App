import 'package:get/get.dart';
import 'package:simag_app/app/constant/url.dart';
import 'package:simag_app/app/data/db_provider.dart';
import 'package:http/http.dart' as http;

class PostJobsController extends GetxController {
  var selectedMagang = 0.obs;
  var filepath = "";

  Future<void> postProposal() async {
    print("ini filenya : $filepath");
    final requestBaseUrl = AppUrl.baseUrl;
    final dbProvider = Get.put(DatabaseProvider());
    final token = await dbProvider.getToken();

    final url = Uri.parse('$requestBaseUrl/upload-proposal/1');

    var request = http.MultipartRequest('POST', url);
    request.fields['id'] = 1.toString();

    request.files.add(await http.MultipartFile.fromPath('proposal', filepath));

    try {
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        Get.offAllNamed("/jobs");
      } else {
        print('Failed to upload proposal: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading proposal: $error');
    }
  }
}
