import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AppText extends StatelessWidget {
  String text;
  Color? textcolor;
  double? fontSize;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  TextOverflow? overflow;
  TextDecoration? decoration;
  AppText({
    Key? key,
    required this.text,
    this.textcolor,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.textAlign,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: GoogleFonts.didactGothic(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textcolor,
        decoration: decoration,
      ),
    );
  }
}
