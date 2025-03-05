import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../root/bottom_navbar_cubit.dart';
import '../categories/category_bloc.dart';
import '../filter/filter_cubit.dart';
import '../product_list/product_bloc.dart';
import '../wishlist/wishlist_cubit.dart';
import '../../../../core/app/app.dart';
import '../../../../core/utils/app_dimensions.dart';
import '../../../../core/utils/app_typography.dart';
import '../../../../core/utils/space.dart';
import '../../../../core/constant/assets.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/enums/enums.dart';
import '../../widgets/dots_indicator.dart';
import 'widgets/error_container.dart';
import '../../widgets/loading_shimmer.dart';
import '../../widgets/square_category_item.dart';
import '../../widgets/square_product_item.dart';
import '../../../../core/widgets/top_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 1;
  PageController _pageController = PageController();

  @override
  void initState() {
    _pageController = PageController(initialPage: currentPage);
    context.read<FilterCubit>().reset();
    context.read<WishlistCubit>().loadWishlist();
    context
        .read<ProductBloc>()
        .add(GetProducts(context.read<FilterCubit>().state));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: AppDimensions.normalize(15)),
        child: Padding(
          padding: Space.h1!,
          child: Column(
            children: [
              TopRow(isFromHome: true, context: context),
              Space.yf(.2),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppDimensions.normalize(110),
                        child: Stack(
                          children: [
                            PageView.builder(
                                controller: _pageController,
                                onPageChanged: (pos) {
                                  setState(() {
                                    currentPage = pos;
                                  });
                                },
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Image.asset(
                                    AppAssets.Logo,
                                    fit: BoxFit.cover,
                                  );
                                }),
                            Positioned(
                              bottom: AppDimensions.normalize(2),
                              left: 0,
                              right: 0,
                              child: Dotsindicator(
                                dotsIndex: _pageController.hasClients
                                    ? _pageController.page?.round().toDouble()
                                    : 1,
                                dotsCount: 3,
                                activeColor: AppColors.coralPink,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: AppDimensions.normalize(15),
                            bottom: AppDimensions.normalize(7)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "CATEGORIES",
                              style: AppText.h3b
                                  ?.copyWith(color: AppColors.primary),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<NavigationCubit>()
                                    .updateTab(NavigationTab.categoriesTab);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "VIEW ALL",
                                    style: AppText.b2b
                                        ?.copyWith(color: AppColors.primary),
                                  ),
                                  const Icon(
                                    Icons.double_arrow,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: AppDimensions.normalize(50),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 8,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  (state is CategoryLoading)
                                      ? const SquareCategoryItem()
                                      : (state is CategoryError)
                                          ? Center(
                                              child: Padding(
                                                  padding: Space.hf(2),
                                                  child: errorContainer(
                                                      context,
                                                      false
                                                  )
                                              ),
                                            )
                                          : SquareCategoryItem(
                                              category: state.categories[index],
                                            ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: AppDimensions.normalize(3.5),
                            bottom: AppDimensions.normalize(7)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "BEST SELLER PRODUCTS",
                              style: AppText.h3b
                                  ?.copyWith(color: AppColors.primary),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<NavigationCubit>()
                                    .updateTab(NavigationTab.productsTap);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "VIEW ALL",
                                    style: AppText.b2b
                                        ?.copyWith(color: AppColors.primary),
                                  ),
                                  Icon(
                                    Icons.double_arrow,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: AppDimensions.normalize(100),
                            child: (state is ProductError)
                                ? Center(child: errorContainer(context, false))
                                : (state is ProductEmpty)
                                    ? Text(
                                        "No Featured Products Available",
                                        style: AppText.b1b,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 9,
                                        physics: const ClampingScrollPhysics(),
                                        itemBuilder: (context, index) => (state
                                                is ProductLoading)
                                            ? const SquareProductItem()
                                            : state.products.isNotEmpty
                                                ? SquareProductItem(
                                                    product:
                                                        state.products[index],
                                                  )
                                                : LoadingShimmer(
                                                    isSquare: true),
                                      ),
                          );
                        },
                      ),
                      Space.y1!,
                      Padding(
                        padding: EdgeInsets.only(
                            top: AppDimensions.normalize(3.5),
                            bottom: AppDimensions.normalize(7)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "FEATURED PRODUCTS",
                              style: AppText.h3b
                                  ?.copyWith(color: AppColors.primary),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<NavigationCubit>()
                                    .updateTab(NavigationTab.productsTap);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "VIEW ALL",
                                    style: AppText.b2b
                                        ?.copyWith(color: AppColors.primary),
                                  ),
                                  Icon(
                                    Icons.double_arrow,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: AppDimensions.normalize(100),
                            child: (state is ProductError)
                                ? Center(child: errorContainer(context, false))
                                : (state is ProductEmpty)
                                ? Text(
                              "No Featured Products Available",
                              style: AppText.b1b,
                              overflow: TextOverflow.ellipsis,
                            )
                                : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 9,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) => (state
                              is ProductLoading)
                                  ? const SquareProductItem()
                                  : state.productsTec.isNotEmpty
                                  ? SquareProductItem(
                                product:
                                state.productsTec[index],
                              )
                                  : LoadingShimmer(
                                  isSquare: true),
                            ),
                          );
                        },
                      ),
                      Space.y1!,

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
