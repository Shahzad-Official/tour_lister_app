import 'package:flutter/material.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/views/register/sign_up.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import 'login.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.defaultPadding,
        child: Center(
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
                fontWeight: FontWeight.w600,
                textcolor: AppColors.primarycolor,
              ),
              const SizedBox(
                height: 20,
              ),
              AppText(
                text: "Sign In to the application\nto enjoy!",
                textAlign: TextAlign.center,
                fontSize: 14,
              ),
              const SizedBox(
                height: 40,
              ),
              AppButton(
                btnText: "LOGIN",
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
                child: Container(
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blueAccent),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        color: Colors.white24,
                      ),
                    ],
                  ),
                  child: Center(
                    child: AppText(
                      text: "SIGN UP",
                      textcolor: Colors.blueAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
