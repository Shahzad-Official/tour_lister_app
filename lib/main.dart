import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/app_colors.dart';
import 'views/main_screens/main_page.dart';

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
