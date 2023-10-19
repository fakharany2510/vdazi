import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_style.dart';
import '../utils/size_utils.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.enable = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.onChanged,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.fillColor,
    this.filled = false,
    this.contentPadding,
    this.defaultBorderDecoration,
    this.enabledBorderDecoration,
    this.focusedBorderDecoration,
    this.disabledBorderDecoration,
    this.validator,
  }) : super(
    key: key,
  );

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final bool? enable;

  final TextStyle? textStyle;

  final bool? obscureText;

  final void Function(String)? onChanged;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final Color? fillColor;

  final bool? filled;

  final EdgeInsetsGeometry? contentPadding;

  final InputBorder? defaultBorderDecoration;

  final InputBorder? enabledBorderDecoration;

  final InputBorder? focusedBorderDecoration;

  final InputBorder? disabledBorderDecoration;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: textFormFieldWidget,
    )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
    width: width ?? double.maxFinite,
    margin: margin,
    child: TextFormField(
      controller: controller,
      style: textStyle ?? secondaryTextStyle(),
      obscureText: obscureText!,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      maxLines: maxLines ?? 1,
      decoration: decoration,
      validator: validator,
      enabled: enable ?? true,
      onChanged:onChanged,
    ),
  );
  InputDecoration get decoration => InputDecoration(

    hintText: hintText ?? "",
    hintStyle: hintStyle ??
        primaryTextStyle(fontSize: 15, color: AppColors.grey),
    prefixIcon: prefix,
    prefixIconConstraints: prefixConstraints,
    suffixIcon: suffix,
    suffixIconConstraints: suffixConstraints,
    fillColor: fillColor,
    filled: filled,
    isDense: true,
    contentPadding: contentPadding,
    border: defaultBorderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getHorizontalSize(
              4.00,
            ),
          ),
          borderSide: BorderSide(
            color: AppColors.grey,
            width: .5,
          ),
        ),
    enabledBorder: enabledBorderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getHorizontalSize(
              4.00,
            ),
          ),
          borderSide: BorderSide(
            color: AppColors.grey,
            width: .5,
          ),
        ),
    focusedBorder: focusedBorderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getHorizontalSize(
              4.00,
            ),
          ),
          borderSide: BorderSide(
            color: AppColors.grey,
            width: .5,
          ),
        ),
    disabledBorder: disabledBorderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getHorizontalSize(
              4.00,
            ),
          ),
          borderSide: BorderSide(
            color: AppColors.grey,
            width: .5,
          ),
        ),
  );
}

extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlineBluegray10001 => OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      getHorizontalSize(
        29.00,
      ),
    ),
    borderSide: BorderSide(
      color: AppColors.grey,
      width: .5,
    ),
  );
}