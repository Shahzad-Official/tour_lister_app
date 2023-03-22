import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/views/main_screens/main_page.dart';

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
          builder: (context) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MainPage();
                } else {
                  return const GetStarted();
                }
              },
            );
          },
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
            AppPadding.heightSpace20,
            const SpinKitCircle(
              color: AppColors.primarycolor,
            ),
          ],
        ),
      ),
    );
  }
}
