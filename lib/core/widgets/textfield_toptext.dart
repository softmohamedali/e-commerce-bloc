import 'package:flutter/material.dart';
import '../utils/app_typography.dart';
import '../utils/configs.dart';

Widget TextFieldTopText(text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Space.yf(1.2),
      Text(
        text,
        style: AppText.b1b,
      ),
      Space.yf(.7),
    ],
  );
}
