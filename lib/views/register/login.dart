import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/register_section_controllers/login_controller.dart';
import 'package:tour_lister_app/services/registration/login_service.dart';
import 'package:tour_lister_app/views/register/sign_up.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/app_text.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      body: Center(
        child: Padding(
          padding: AppPadding.defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
                child: Image.asset("assets/logo.png"),
              ),
              AppText(
                text: "LOGO HERE",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 40,
              ),
              AppInputField(
                controller: loginController.email,
                hintText: "Enter Email",
              ),
              const SizedBox(
                height: 15,
              ),
              GetBuilder<LoginController>(
                init: LoginController(),
                initState: (_) {},
                builder: (_) {
                  return AppInputField(
                    controller: loginController.password,
                    obscureText: _.isObsecure,
                    hintText: "Password",
                    contentPadding: const EdgeInsets.only(
                      top: 20,
                      left: 15,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        _.passwordHide();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: _.isObsecure ? 20 : 15,
                        ),
                        child: SvgPicture.string(
                          _.isObsecure ? SvgIcons.closeEye : SvgIcons.openEye,
                          width: 30,
                          // ignore: deprecated_member_use
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppText(text: "Forget Password"),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              AppButton(
                isLoading: isLoading,
                btnText: "LOGIN",
                ontap: () async {
                  isLoading = true;
                  setState(() {});
                  await loginController.isValidUser();
                  isLoading = false;
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.15,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  AppText(
                    text: "Or continue with",
                    textcolor: Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.15,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: isLoading
                        ? () {}
                        : () async {
                            isLoading = true;
                            setState(() {});
                            await LoginService().googleSignInService();
                            isLoading = false;
                            setState(() {});
                          },
                    child: SizedBox(
                      height: 80,
                      child: Image.asset("assets/googleLogo.png"),
                    ),
                  ),
                  InkWell(
                    onTap: isLoading
                        ? () {}
                        : () async {
                            isLoading = true;
                            setState(() {});
                            await LoginService().faceBookLoginService();
                            isLoading = false;
                            setState(() {});
                          },
                    child: SizedBox(
                      height: 80,
                      child: Image.asset("assets/fLogo.png"),
                    ),
                  ),
                ],
              ),
              AppPadding.heightSpace20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: "Not a member?",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    textcolor: const Color(0xff918AB1),
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
                    child: AppText(
                      text: " SignUp",
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
