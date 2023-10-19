import 'package:flutter/material.dart';
import 'package:vzadi/core/utils/extensions.dart';
import 'package:vzadi/core/utils/size_utils.dart';
import 'package:vzadi/features/map/data/models/get_direction_model.dart';

import '../../../../core/utils/app_colors.dart';
class DistanceAndTine extends StatelessWidget {
  final GetDirectionsModel? getDirectionsModel;
  final bool isTimeAndDistanceVisible;
  const DistanceAndTine({Key? key,required this.isTimeAndDistanceVisible,this.getDirectionsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isTimeAndDistanceVisible,
      child: Positioned(
        top: 0,
        bottom: 400,
        left: 0,
        right: 0,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Card(
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                color: AppColors.white,
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: Icon(Icons.access_time_filled,color: AppColors.primaryColor,size: getSize(30)),
                  title: Text(getDirectionsModel!.totalDuration,
                  maxLines: 1,
                  style:TextStyle(
                    color: AppColors.primaryColor,fontSize: 16,overflow: TextOverflow.ellipsis,
                  )
                ),
              ),
              )),
            30.width,
            Flexible(
                flex: 1,
                child: Card(
                  margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                  color: AppColors.white,
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    leading: Icon(Icons.directions_car_filled,color: AppColors.primaryColor,size: getSize(30)),
                    title: Text(getDirectionsModel!.totalDistance,
                        maxLines: 1,
                        style:TextStyle(
                          color: AppColors.primaryColor,fontSize: 16,overflow: TextOverflow.ellipsis,
                        )
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
