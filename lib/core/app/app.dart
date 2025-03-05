import 'package:flutter/material.dart';

import '../utils/space.dart';
import '../utils/app_typography.dart';
import '../utils/app_dimensions.dart';
import '../utils/ui.dart';

class App {
  static bool? isLtr;

  static init(BuildContext context) {
    UI.init(context);
    AppDimensions.init();
    Space.init();
    AppText.init();
    isLtr = Directionality.of(context) == TextDirection.ltr;
  }
}
