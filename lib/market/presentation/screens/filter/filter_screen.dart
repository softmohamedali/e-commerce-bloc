import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_dimensions.dart';
import '../../../../core/utils/configs.dart';
import '../../../../core/constant/assets.dart';
import '../../../../core/constant/colors.dart';

import '../categories/category_bloc.dart';
import 'filter_cubit.dart';
import '../product_list/product_bloc.dart';
import '../price_range_slider.dart';
import '../../../data/models/filter_params_model.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool isCategorieslistVisible = false;
  bool isPricerangeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppDimensions.normalize(22)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(children: [
            Space.xf(.8),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
            Space.xf(7),
            Text(
              "FILTER",
              style: AppText.b2b?.copyWith(color: AppColors.GreyText),
            ),
          ]),
        ),
      ),
      body: Padding(
        padding: Space.all(1, 1.2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isCategorieslistVisible = !isCategorieslistVisible;
                  });
                },
                child: Container(
                  padding: Space.all(1.1, 1.2),
                  color: AppColors.LightGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: AppText.h3b,
                      ),
                      isCategorieslistVisible
                          ? SvgPicture.asset(AppAssets.Minus)
                          : SvgPicture.asset(AppAssets.Plus)
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isCategorieslistVisible,
                child: Container(
                  color: AppColors.LightGrey,
                  padding: Space.hf(1.2),
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, categoryState) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categoryState.categories.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              bottom: AppDimensions.normalize(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  categoryState.categories[index].name
                                      .toUpperCase(),
                                  style: AppText.h3?.copyWith(
                                    color: context
                                            .read<FilterCubit>()
                                            .isSelectedCategory(
                                                categoryState.categories[index])
                                        ? AppColors
                                            .primary // Change color when checkbox is checked
                                        : Colors.black,
                                  )),
                              BlocBuilder<FilterCubit, FilterProductParams>(
                                builder: (context, filterState) {
                                  return SizedBox(
                                    height: AppDimensions.normalize(10),
                                    width: AppDimensions.normalize(5),
                                    child: Checkbox(
                                      activeColor: AppColors.primary,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      value: filterState.categories.contains(
                                              categoryState
                                                  .categories[index]) ||
                                          filterState.categories.isEmpty,
                                      onChanged: (bool? value) {
                                        setState(() {});
                                        context
                                            .read<FilterCubit>()
                                            .updateCategory(
                                                category: categoryState
                                                    .categories[index]);
                                      },
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Space.yf(1.5),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isPricerangeVisible = !isPricerangeVisible;
                  });
                },
                child: Container(
                  padding: Space.all(1.1, 1.2),
                  color: AppColors.LightGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: AppText.h3b,
                      ),
                      isPricerangeVisible
                          ? SvgPicture.asset(AppAssets.Minus)
                          : SvgPicture.asset(AppAssets.Plus)
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isPricerangeVisible,
                child: Container(
                  color: AppColors.LightGrey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: AppDimensions.normalize(9),
                            bottom: AppDimensions.normalize(5)),
                        child: Text(
                          "Dollar".toUpperCase(),
                          style: AppText.h3b
                              ?.copyWith(color: AppColors.primary),
                        ),
                      ),
                      BlocBuilder<FilterCubit, FilterProductParams>(
                        builder: (context, state) {
                          return PriceRangeSlider(
                            initMin: state.minPrice,
                            initMax: state.maxPrice,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.LightGrey,
        padding: Space.v1!,
        margin: Space.v2!,
        child: Row(
          children: [
            Space.xf(1.2),
            Expanded(
                child: GestureDetector(
                  onTap: (){
                    context.read<FilterCubit>().reset();
                  },
                 child: Container(
                  height: AppDimensions.normalize(24),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: Space.all(2, 1.1),
                    child: Center(
                        child: Text(
                      "Reset",
                      style: AppText.h3b?.copyWith(color: AppColors.primary),
                    )),
                  )),
            )),
            Space.x!,
            Expanded(
                child: ElevatedButton(
                    onPressed: (){
                      context
                          .read<ProductBloc>()
                          .add(GetProducts(context
                          .read<FilterCubit>()
                          .state));
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: Space.all(2, 1.1),
                      child: Text(
                        "Apply",
                        style: AppText.h3b?.copyWith(color: Colors.white),
                      ),
                    ))),
            Space.xf(1.2),
          ],
        ),
      ),
    );
  }
}
