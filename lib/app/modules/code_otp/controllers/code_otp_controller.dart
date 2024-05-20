import 'dart:async';

import 'package:get/get.dart';

class CodeOtpController extends GetxController {
  var resendCountDown = 60.obs;
  var canResendEmail = true.obs;
  Timer? _resendTimer;

  @override
  void onClose() {
    _resendTimer?.cancel();
    super.onClose();
  }

  void startResendCountdown() {
    if (_resendTimer != null) {
      _resendTimer?.cancel();
    }

    resendCountDown.value = 59;
    canResendEmail.value = false;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountDown.value > 0) {
        resendCountDown.value--;
      } else {
        canResendEmail.value = true;
        _resendTimer?.cancel();
      }
    });
  }

  void resendEmail() {
    if (canResendEmail.value) {
      startResendCountdown();
    }
  }
}
