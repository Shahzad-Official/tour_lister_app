import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/views/splash_screen.dart';

import 'constants/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    Stripe.publishableKey =
        "pk_test_51MsLFECWo2neW10ROTMDnicXqvasdNysEVZlzYqF2BsEk5hEP0YvRJujWcv6iHPsho9tXtVeICnGrDzipPkwQAFF00HFUoGbHN";
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    debugPrint(e.toString());
  }
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
