import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/configs.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/constant/colors.dart';

Widget QuantityRow(double width,double padding){
  return Row(
    children: [
      GestureDetector(
        child: Container(
          width: AppDimensions.normalize(width),
          color: AppColors.primary,
          child: Center(
            child: SvgPicture.asset(AppAssets.Minus,
                color: Colors.white, height: 3),
          ),
        ),
      ),
      Container(
        padding: Space.hf(padding),
        color: Colors.white,
        child: Center(
          child: Text(
            "1",
            style: AppText.h3b,
          ),
        ),
      ),
      GestureDetector(
        child: Container(
          width: AppDimensions.normalize(width),
          color: AppColors.primary,
          child: Center(
            child: SvgPicture.asset(AppAssets.Plus,
                color: Colors.white, height: 13),
          ),
        ),
      )
    ],
  );
}