import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/views/splash_screen.dart';

import 'constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '321 Go Lister',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors().getMaterialColor(),
      ),
      home: const SplashScreen(),
    );
  }
}
