import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_lister_app/constants/app_colors.dart';

import 'app_text.dart';

class AppInputField extends StatelessWidget {
  String hintText;
  bool obscureText;
  TextEditingController? controller;
  TextInputType? keyboardtype;
  Widget? suffixIcon;
  void Function()? onTap;
  EdgeInsetsGeometry contentPadding;
  bool? enabled;
  double? width;
  AppInputField({
    Key? key,
    required this.hintText,
    this.controller,
    this.keyboardtype,
    this.obscureText = false,
    this.suffixIcon,
    this.contentPadding = const EdgeInsets.only(top: 15, left: 15),
    this.onTap,
    this.enabled,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              color: Colors.grey.withOpacity(0.20),
              blurRadius: 8,
            ),
          ],
        ),
        child: TextFormField(
          textInputAction: TextInputAction.next,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardtype,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: suffixIcon,
            hintText: hintText,
            contentPadding: contentPadding,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.headTextColor,
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownContainer extends StatelessWidget {
  Object? currentValue;
  List<String> items;
  void Function(Object? value)? onValueChange;
  DropdownContainer({
    Key? key,
    required this.currentValue,
    required this.items,
    required this.onValueChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.20),
            blurRadius: 8,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: DropdownButton(
          value: currentValue,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Center(
                    child: AppText(
                      text: e,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      textcolor: AppColors.headTextColor,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onValueChange,
          alignment: Alignment.center,
          underline: const SizedBox(),
          icon: const SizedBox(),
        ),
      ),
    );
  }
}
