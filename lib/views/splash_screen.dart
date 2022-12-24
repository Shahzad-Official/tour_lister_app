import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';

import '../widgets/app_text.dart';
import 'register/get_started.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GetStarted(),
        ),
      ),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
            AppText(
              text: "LOGO HERE",
              fontSize: 22,
              textcolor: AppColors.primarycolor,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
