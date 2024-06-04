import 'package:get/get.dart';
import 'package:simag_app/app/constant/url.dart';
import 'package:simag_app/app/data/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:simag_app/app/modules/jobs/model/jobs_mode_byId.dart';
import 'package:simag_app/app/modules/jobs/model/jobs_model.dart';

class FetchJobsController extends GetxController {
  var jobsModel = JobsModel(message: '', data: []).obs;

  @override
  void onReady() {
    super.onReady();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    final requestBaseUrl = AppUrl.baseUrl;
    final dbProvider = Get.put(DatabaseProvider());
    final token = await dbProvider.getToken();

    final url = Uri.parse('$requestBaseUrl/get-tempat-magang');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      jobsModel.value = jobsModelFromJson(response.body);
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}

class FetchJobsControllerById extends GetxController {
  var jobsModel = JobsModelById(message: '', data: Data()).obs;
  var selectedMagang = 0.obs;

  Future<void> fetchJobsById() async {
    final requestBaseUrl = AppUrl.baseUrl;
    final dbProvider = Get.put(DatabaseProvider());
    final token = await dbProvider.getToken();

    final url =
        Uri.parse('$requestBaseUrl/get-tempat-magang?id=$selectedMagang');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      jobsModel.value = jobsModelByIdFromJson(response.body);
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}
