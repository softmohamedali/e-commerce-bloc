import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../constant/strings.dart';
import '../utils/app_dimensions.dart';
import '../utils/space.dart';
import '../app/app_router.dart';

Widget TopRow({required bool isFromHome, required BuildContext context}) {
  return SizedBox(
    height: AppDimensions.normalize(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          appTitle,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        isFromHome
            ? Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouter.wishlist);
                      },
                      child: const Icon(Icons.favorite_border)),
                  Space.xf(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouter.search);
                    },
                    child: const Icon(Icons.search),
                  ),
                ],
              )
            : const SizedBox.shrink()
      ],
    ),
  );
}
