import 'package:ecommerce/core/widgets/transparent_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/configs.dart';

import '../../../../../core/constant/assets.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/app/app_router.dart';

Widget unloggedProfileContainer(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: AppDimensions.normalize(5)),
    padding: EdgeInsets.all(AppDimensions.normalize(8)),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome!",
          style: AppText.h2b?.copyWith(
            color: Colors.white,
          ),
        ),
        Space.yf(0.5),
        Text(
          "Sign in to access your account features",
          style: AppText.b2?.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        Space.yf(1),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.login);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.normalize(4),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Sign In",
                  style: AppText.b1b?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            Space.xf(1),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.signup);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.normalize(4),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                child: Text(
                  "Register",
                  style: AppText.b1b?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
