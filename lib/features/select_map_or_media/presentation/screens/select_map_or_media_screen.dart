import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class SelectMapOrMediaScreen extends StatelessWidget {
  const SelectMapOrMediaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomElevatedButton(
        width: getVerticalSize(300),
      text: AppStrings.goToMap,
        alignment: Alignment.bottomCenter,
        buttonStyle: defaultElevatedButtonStyle.copyWith(
            fixedSize: MaterialStateProperty.all<Size>(
                Size(double.maxFinite, getVerticalSize(48)))),
        buttonTextStyle: boldTextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: AppColors.white),
        onTap:(){
          Navigator.pushNamed(context, Routes.mapScreen);
        }
    ),
          20.height,
          CustomElevatedButton(
              width: getVerticalSize(300),
              text: AppStrings.goToMedia,
              alignment: Alignment.bottomCenter,
              buttonStyle: defaultElevatedButtonStyle.copyWith(
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(double.maxFinite, getVerticalSize(48)))),
              buttonTextStyle: boldTextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: AppColors.white),
              onTap:(){
                Navigator.pushNamed(context, Routes.mediaScreen);
              }
          ),

        ],
      ),
    );
  }
}
