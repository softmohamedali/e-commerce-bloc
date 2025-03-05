import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'wishlist_cubit.dart';
import '../../../../core/utils/app_dimensions.dart';
import '../../../../core/utils/app_typography.dart';
import '../../../../core/utils/space.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../widgets/rectangular_product_item.dart';
import '../../../data/models/product_model.dart';
import '../product_details/product_details_screen.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    context.read<WishlistCubit>().loadWishlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar('WISHLIST', context,automaticallyImplyLeading: true),
        floatingActionButton: FloatingActionButton(onPressed: (){
          setState(() {
            context.read<WishlistCubit>().clearWishlist();
          });

        },child: Icon(Icons.delete_forever_outlined)),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoadedState) {
              if (state.wishlist.isEmpty) {
                return Container(
                  margin: EdgeInsets.only(
                      top: AppDimensions.normalize(90),
                      bottom: AppDimensions.normalize(120),
                      left: AppDimensions.normalize(10),
                      right: AppDimensions.normalize(10)),
                  padding: Space.all(1, 1.5),
                  color: AppColors.LightGrey,
                  // height: AppDimensions.normalize(70),
                  child: Center(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "NO FAVORITES",
                          style: AppText.h3b
                              ?.copyWith(color: AppColors.primary),
                        ),
                        const Text(
                          "There Is No Saved Products.\n Please Add New Products!",
                          style: TextStyle(height: 2),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  child: GridView.builder(
                    padding: Space.all(1),
                    itemCount: state.wishlist.length ,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.55,
                      crossAxisSpacing: 6,
                    ),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {

                      return  RectangularProductItem(product: state.wishlist[index],isFromWishlist: true,);
                    },
                  ),
                );
              }
            } else {
              return const Center(child:  CircularProgressIndicator(color: AppColors.primary,));
            }
          },
        ));
  }
}

class YourWishlistWidget extends StatelessWidget {
  final List<ProductModel> wishlist;

  YourWishlistWidget({required this.wishlist});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wishlist.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(wishlist[index].title),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsScreen(product: wishlist[index]),
              ),
            );
          },
          // Add more UI components as needed
        );
      },
    );
  }
}
