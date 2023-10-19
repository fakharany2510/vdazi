
import 'package:flutter/material.dart';
import 'package:vzadi/core/utils/app_fonts.dart';
import 'package:vzadi/core/utils/size_utils.dart';

import 'app_colors.dart';


TextStyle boldTextStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  String? fontFamily,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize: getFontSize(fontSize ?? 15)  ,
    color: color ?? AppColors.primaryColor ,
    fontWeight: fontWeight ?? FontWeight.bold,
    fontFamily: AppFonts.appFontFamily,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}

class AppFontFamiles {
}

// Primary Text Style
TextStyle primaryTextStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  String? fontFamily,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize: getFontSize(fontSize ?? 14, ) , 
    color: color ,
    fontWeight: fontWeight ?? FontWeight.w400,
    fontFamily: AppFonts.appFontFamily,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}

// Secondary Text Style
TextStyle secondaryTextStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  String? fontFamily,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize : getFontSize(fontSize ?? 15) ,
    color: color??AppColors.primaryColor ,
    fontWeight: fontWeight ?? FontWeight.w600,
    fontFamily: AppFonts.appFontFamily,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}