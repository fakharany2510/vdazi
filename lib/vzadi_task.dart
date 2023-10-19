import 'package:flutter/material.dart';
import 'package:vzadi/config/routes/app_routes.dart';

import 'core/utils/app_strings.dart';

class VzadiTask extends StatelessWidget {
  const VzadiTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
