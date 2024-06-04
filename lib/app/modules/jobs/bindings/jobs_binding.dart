import 'package:get/get.dart';
import 'package:simag_app/app/data/db_provider.dart';
import 'package:simag_app/app/modules/jobs/controllers/fetch_jobs_controller.dart';

import '../controllers/jobs_controller.dart';

class JobsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobsController>(
      () => JobsController(),
    );
    Get.lazyPut<DatabaseProvider>(
      () => DatabaseProvider(),
    );
    Get.lazyPut<FetchJobsController>(
      () => FetchJobsController(),
    );
    Get.lazyPut<FetchJobsControllerById>(
      () => FetchJobsControllerById(),
    );
  }
}
