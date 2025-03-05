import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_dimensions.dart';
import '../../../../core/utils/app_typography.dart';
import '../../../../core/utils/space.dart';
import '../../../../core/constant/assets.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/app/app_router.dart';
import '../../../../core/widgets/top_row.dart';
import 'cart_bloc.dart';
import 'cart_events.dart';
import 'cart_state.dart';

// cart_screen.dart
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..add(LoadCart()),
      child: Scaffold(
        body: Padding(
          padding: Space.hf(1.1),
          child: SafeArea(
            minimum: EdgeInsets.only(top: AppDimensions.normalize(20)),
            child: Column(
              children: [
                TopRow(isFromHome: false, context: context,),
                Expanded(
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.items.isEmpty) {
                        return _buildEmptyCart();
                      }
                      return _buildCartContent(context, state);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.Cart,
            height: AppDimensions.normalize(40),
            colorFilter: const ColorFilter.mode(
              AppColors.GreyText,
              BlendMode.srcIn,
            ),
          ),
          Space.yf(),
          Text(
            "Your cart is empty",
            style: AppText.h3b?.copyWith(color: AppColors.GreyText),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, CartState state) {
    final bloc = context.read<CartBloc>();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return Padding(
                padding: Space.vf(0.5),
                child: Row(
                  children: [
                    // Item Image
                    Container(
                      width: AppDimensions.normalize(30),
                      height: AppDimensions.normalize(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Space.xf(),
                    // Item Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name, style: AppText.b1b),
                          Text(
                            "\$${item.price.toStringAsFixed(2)}",
                            style: AppText.b2?.copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                    // Quantity Controls
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (item.quantity > 1) {
                              bloc.add(UpdateQuantity(index, item.quantity - 1));
                            }
                          },
                          icon: SvgPicture.asset(AppAssets.Minus),
                        ),
                        Text("${item.quantity}", style: AppText.b1b),
                        IconButton(
                          onPressed: () {
                            bloc.add(UpdateQuantity(index, item.quantity + 1));
                          },
                          icon: SvgPicture.asset(AppAssets.Plus),
                        ),
                        IconButton(
                          onPressed: () => bloc.add(RemoveFromCart(index)),
                          icon: SvgPicture.asset(AppAssets.Trash),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Total and Checkout
        Container(
          padding: Space.vf(),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.GreyText.withOpacity(0.2))),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: AppText.h3b),
                  Text(
                    "\$${bloc.totalPrice.toStringAsFixed(2)}",
                    style: AppText.h3b?.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
              Space.yf(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.checkout);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: Size(double.infinity, AppDimensions.normalize(20)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Proceed to Checkout",
                  style: AppText.b1b?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}