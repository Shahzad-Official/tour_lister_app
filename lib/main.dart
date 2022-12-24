import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/views/main_screens/main_page.dart';
import 'package:tour_lister_app/views/splash_screen.dart';
import 'package:tour_lister_app/views/lister_profile/edit_profile.dart';
import 'package:tour_lister_app/views/register/login.dart';
import 'package:tour_lister_app/views/lister_profile/profile.dart';
import 'package:tour_lister_app/views/register/sign_up.dart';

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
      home: MainPage(),
    );
  }
}
