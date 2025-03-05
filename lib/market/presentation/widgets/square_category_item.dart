import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/utils.dart';
import '../../../core/app/app.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/utils/configs.dart';

import '../screens/root/bottom_navbar_cubit.dart';
import '../screens/filter/filter_cubit.dart';
import '../screens/product_list/product_bloc.dart';
import '../../../core/constant/colors.dart';
import '../../../core/enums/enums.dart';
import '../../domain/entites/category.dart';
import 'loading_shimmer.dart';

class SquareCategoryItem extends StatelessWidget {
  const SquareCategoryItem({super.key, this.category});

  final Category? category;

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return category != null
        ? GestureDetector(
            onTap: () {
              context
                  .read<NavigationCubit>()
                  .updateTab(NavigationTab.productsTap);
              context.read<FilterCubit>().update(category: category);
              context
                  .read<ProductBloc>()
                  .add(GetProducts(context.read<FilterCubit>().state));
            },
            child: Container(
              width: AppDimensions.normalize(40),
              child: Padding(
                padding: EdgeInsets.only(right: AppDimensions.normalize(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius:BorderRadius.circular(500)
                      ),
                      child: Icon(
                          categoryIcons
                              .firstWhere((element) => element["name"]==category!.name)["icon"],
                        size: 50,
                      ),
                    ),
                    Space.y1!,
                    Text(
                      category!.name.toUpperCase(),
                      style: AppText.b2b?.copyWith(color: AppColors.GreyText),
                        maxLines:2,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          )
        : LoadingShimmer(isSquare: true);
  }
}
