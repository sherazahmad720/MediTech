import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:medi_tech/src/controllers/color_controller.dart';
import 'package:medi_tech/src/pages/splash_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Get.put(ColorController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: colors.bg),
      home: SplashScreen(),
    );
  }
}
