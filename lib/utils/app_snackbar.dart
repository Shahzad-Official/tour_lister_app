import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_colors.dart';

class AppSnackbar {
  static snackBar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.primarycolor,
      colorText: Colors.white,
    );
  }
}
