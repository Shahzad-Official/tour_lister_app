import 'package:flutter/material.dart';

class Navigate {
  static to(BuildContext context, Widget nextScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
    );
  }

  static replace(BuildContext context, Widget nextScreen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
    );
  }

  static back(BuildContext context) {
    Navigator.pop(context);
  }
}
