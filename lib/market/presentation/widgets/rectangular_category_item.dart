import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entites/category.dart';
import '../../domain/utils.dart';
import '../screens/root/bottom_navbar_cubit.dart';
import '../../../core/app/app.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/utils/configs.dart';
import '../../../core/enums/enums.dart';
import 'package:shimmer/shimmer.dart';
import '../screens/filter/filter_cubit.dart';
import '../screens/product_list/product_bloc.dart';
import '../../../core/constant/colors.dart';
import 'loading_shimmer.dart';

class RectangularCategoryItem extends StatelessWidget {
  final Category? category;

  const RectangularCategoryItem({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return category != null
        ? _buildCategoryCard(context)
        : const SizedBox();
  }

  Widget _buildCategoryCard(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: AppDimensions.normalize(3)),
      color: AppColors.LightGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => _handleTap(context),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.normalize(4)),
          child: Row(
            children: [
              _buildIconContainer(),
              SizedBox(width: AppDimensions.normalize(5)),
              _buildCategoryName(),
              const Spacer(),
              _buildColorAccent(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    if (category == null) return;

    context.read<NavigationCubit>().updateTab(NavigationTab.productsTap);
    context.read<FilterCubit>().update(category: category);
    context.read<ProductBloc>().add(GetProducts(context.read<FilterCubit>().state));
  }

  Widget _buildIconContainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      child: Icon(
        categoryIcons.firstWhere((element) => element['name'] == category!.name)['icon'],
        size: 48,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildCategoryName() {
    return Expanded(
      child: Text(
        category!.name,
        style: AppText.h2b?.copyWith(
          color: AppColors.GreyText,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildColorAccent() {
    return Container(
      width: AppDimensions.normalize(6),
      height: AppDimensions.normalize(50),
      decoration: const BoxDecoration(
        color: AppColors.softGold,
        borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
      ),
    );
  }
}