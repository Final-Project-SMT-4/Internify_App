// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simag_app/app/controllers/introduction_controller.dart';
import 'package:simag_app/app/routes/app_pages.dart';
import 'package:simag_app/utils/app_theme.dart';
import 'package:simag_app/utils/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<void> _delayedFuture() async {
    await Future.delayed(const Duration(milliseconds: 1700));
  }

  final introC = Get.put(IntroductionController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _delayedFuture(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(
            () => GetMaterialApp(
              title: "SIMAG",
              defaultTransition: Transition.native,
              theme: appTheme,
              initialRoute: introC.isSkipIntro.isTrue
                  ? introC.isAuth.isTrue
                      ? Routes.NAVIGATION_BAR
                      : Routes.LOGIN
                  : Routes.FIRST_STEP,
              getPages: AppPages.routes,
            ),
          );
        }

        return SplashScreen();
      },
    );
  }
}
