import 'package:get/get.dart';

import '../controllers/first_step_controller.dart';

class FirstStepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstStepController>(
      () => FirstStepController(),
    );
  }
}
