import 'package:flutter/material.dart';
import 'package:vzadi/core/utils/size_utils.dart';
import 'app_colors.dart';


extension StringExtension on String {
  String get removeSpaces => replaceAll(' ', '');
  int get codeFromString {
    String formattedStringColor = removeSpaces;
    if (formattedStringColor.startsWith('#')) {
      formattedStringColor = formattedStringColor.replaceAll('#', '');
    } else if (formattedStringColor.startsWith('0x')) {
      formattedStringColor = formattedStringColor.replaceAll('0x', '');
    } else if (formattedStringColor.startsWith('0X')) {
      formattedStringColor = formattedStringColor.replaceAll('0X', '');
    }
    formattedStringColor = formattedStringColor.isLengthEqual(6) ? formattedStringColor.addAtStart('FF') : formattedStringColor;
    return int.parse(formattedStringColor, radix: 16);
  }

  Color get colorFromString {
    String formattedStringColor = removeSpaces.toUpperCase();
    if (formattedStringColor.startsWith('#')) {
      formattedStringColor = formattedStringColor.replaceAll('#', '');
    } else if (formattedStringColor.startsWith('0x')) {
      formattedStringColor = formattedStringColor.replaceAll('0x', '');
    } else if (formattedStringColor.startsWith('0X')) {
      formattedStringColor = formattedStringColor.replaceAll('0X', '');
    }
    formattedStringColor = formattedStringColor.isLengthEqual(6) ? formattedStringColor.addAtStart('FF') : formattedStringColor;
    return Color(int.parse(formattedStringColor, radix: 16));
  }

  String get capitalize => toUpperCase();
  String addAtStart(String start) => "$start$this";
  bool isLengthEqual(int length) => this.length == length;
  int get toInt => int.parse(this);
}

extension StringNullExtension on String? {
  String get validate => this == null ? '' : this!;
  int get toInt => validate.isEmpty ? 0 : int.parse(this!);
  bool get isNotNull => this!=null;
  bool get isNull => this==null;

}

extension BoolExtension on bool? {
  /* null false , false false */
  bool get validate => this == null ? false : this!;
}

extension ListExtension on List<dynamic>? {
  List<dynamic> get validate => this == null ? [] : this!;
}

/* json decode and encode*/
extension MapExtension on Map<String, dynamic> {}

extension DateTimeExtension on DateTime? {
}

ButtonStyle get outlinePrimary => OutlinedButton.styleFrom(
      backgroundColor: Colors.transparent,
      side:  BorderSide(
        color: AppColors.primaryColor,
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          6,
        ),
      ),
    );

ButtonStyle get defaultElevatedButtonStyle => ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
    );

extension DoubleToSizeBox on int {
  SizedBox get height => SizedBox(height: getVerticalSize(this.toDouble()),);
  SizedBox get width =>SizedBox(width: getHorizontalSize(this.toDouble()),);
}

extension RoutingHelper on BuildContext{
///push
  void push(Widget widget) =>Navigator.push(this, MaterialPageRoute(builder: (context)=>widget));
  void  pushReplacement(Widget widget)  =>Navigator.pushReplacement(this, MaterialPageRoute(builder: (context)=>widget));
  void pushAndRemoveUntill(Widget widget)  =>Navigator.pushAndRemoveUntil(this, MaterialPageRoute(builder: (context)=>widget),(route) => false,);
///pop
  void pop()  =>Navigator.pop(this);
}


