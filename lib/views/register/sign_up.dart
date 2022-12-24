import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_lister_app/controllers/register_section_controllers/signup_controller.dart';
import 'package:tour_lister_app/views/register/login.dart';

import '../../constants/app_paddings.dart';
import '../../constants/svg_icons.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/app_text.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignupController signupController = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color(0xff302A4E),
        ),
        centerTitle: true,
        title: AppText(
          text: "Create Account",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          textcolor: const Color(0xff302A4E),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.defaultPadding,
          child: Column(
            children: [
              AppPadding.heightSpace30,
              AppInputField(
                controller: signupController.name,
                hintText: "Username",
              ),
              AppPadding.heightSpace30,
              AppInputField(
                controller: signupController.email,
                hintText: "Email",
              ),
              AppPadding.heightSpace30,
              AppInputField(
                controller: signupController.phone,
                hintText: "Phone Number",
              ),
              AppPadding.heightSpace30,
              GetBuilder<SignupController>(
                init: SignupController(),
                initState: (_) {},
                builder: (_) {
                  return Column(
                    children: [
                      AppInputField(
                        controller: signupController.password,
                        obscureText: _.isObsecure,
                        hintText: "Password",
                        contentPadding: const EdgeInsets.only(
                          top: 20,
                          left: 15,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            _.hidePassword();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: _.isObsecure ? 20 : 15,
                            ),
                            child: SvgPicture.string(
                              _.isObsecure
                                  ? SvgIcons.closeEye
                                  : SvgIcons.openEye,
                              width: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      AppPadding.heightSpace30,
                      AppInputField(
                        controller: signupController.confirmPassword,
                        obscureText: _.isObsecure,
                        contentPadding: const EdgeInsets.only(
                          top: 20,
                          left: 15,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            _.hidePassword();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: _.isObsecure ? 20 : 15,
                            ),
                            child: SvgPicture.string(
                              _.isObsecure
                                  ? SvgIcons.closeEye
                                  : SvgIcons.openEye,
                              width: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        hintText: "Repeat Password",
                      ),
                    ],
                  );
                },
              ),
              AppPadding.heightSpace30,
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "By continuing, you agree to our ",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff918AB1),
                      ),
                    ),
                    TextSpan(
                      text: "Terms of Service ",
                      style: GoogleFonts.poppins(
                        color: Colors.blueAccent,
                      ),
                    ),
                    TextSpan(
                      text: "and ",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff918AB1),
                      ),
                    ),
                    TextSpan(
                      text: "Privacy policy ",
                      style: GoogleFonts.poppins(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              AppPadding.heightSpace30,
              AppButton(
                btnText: "SIGN UP",
                ontap: () {
                  signupController.isValidUser();
                },
              ),
              AppPadding.heightSpace30,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: "Already have account?",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    textcolor: const Color(0xff918AB1),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    child: AppText(
                      text: " Login",
                      textcolor: const Color(0xff4D94FF),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
