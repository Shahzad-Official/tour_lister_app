import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  String btnText;
  bool isLoading;
  void Function() ontap;
  AppButton({
    Key? key,
    required this.btnText,
    required this.ontap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : ontap,
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
          child: isLoading
              ? const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 20,
                )
              : AppText(
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

class RoundButton extends StatelessWidget {
  final double? width, height;
  final String text;
  final double fontSize;
  final Color? textColor, buttonColor;
  final void Function()? onTap;
  final bool isLoading;
  final BoxShape shape;
  const RoundButton({
    Key? key,
    this.width,
    this.shape = BoxShape.rectangle,
    required this.text,
    this.onTap,
    this.fontSize = 12,
    this.textColor,
    this.buttonColor,
    this.isLoading = false,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius:
              shape == BoxShape.circle ? null : BorderRadius.circular(5),
          border: Border.all(
            color: AppColors.primarycolor,
          ),
          color: buttonColor ?? AppColors.primarycolor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 3,
            bottom: 5,
          ),
          child: Center(
            child: isLoading
                ? SpinKitThreeBounce(
                    color: textColor ?? Colors.white,
                    size: fontSize - 2,
                  )
                : AppText(
                    text: text,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                    textcolor: textColor ?? Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
