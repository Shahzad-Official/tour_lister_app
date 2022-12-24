import 'package:flutter/material.dart';
import 'package:tour_lister_app/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  String btnText;
  void Function() ontap;
  AppButton({
    Key? key,
    required this.btnText,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Color(0xff6CCAFF),
              Color(0xff39ACFF),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 3,
              color: Colors.grey,
            ),
          ],
        ),
        child: Center(
          child: AppText(
            text: btnText,
            textcolor: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
