// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simag_app/app/data/db_provider.dart';
import 'package:simag_app/app/modules/home/controllers/home_controller.dart';
import 'package:simag_app/app/modules/navigation_bar/controllers/navigation_bar_controller.dart';
import 'package:simag_app/app/modules/navigation_bar/views/navigation_bar_view.dart';
import 'package:simag_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:simag_app/app/provider/auth_provider.dart';
import 'package:simag_app/app/routes/app_pages.dart';
import 'package:simag_app/utils/app_theme.dart';

void main() {
  Get.put(NavigationBarController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child: GetMaterialApp(
        title: "SIMAG",
        defaultTransition: Transition.native,
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: Routes.SPLASH_SCREEN,
        getPages: AppPages.routes,
        home: NavigationBarView(),
      ),
    );
  }
}
