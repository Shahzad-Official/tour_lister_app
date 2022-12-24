import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour_lister_app/constants/app_colors.dart';

class ToastMessage {
  showErrorMessage(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Color.fromARGB(255, 187, 0, 0),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  showMessage(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: AppColors.primarycolor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
