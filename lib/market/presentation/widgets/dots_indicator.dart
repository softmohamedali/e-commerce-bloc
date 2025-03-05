import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_dimensions.dart';

Widget Dotsindicator({double? dotsIndex, required int dotsCount,required Color activeColor}) {
  return DotsIndicator(
    dotsCount: dotsCount,
    position: dotsIndex??0.0,
    decorator: DotsDecorator(
        color: Colors.white,
        activeColor: activeColor,
        size: Size.fromRadius(
          AppDimensions.normalize(2.5),
        ),
        activeSize: Size.fromRadius(AppDimensions.normalize(2.5))),
  );
}
