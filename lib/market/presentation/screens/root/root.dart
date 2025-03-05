import 'package:ecommerce/profile/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cart/presntation/screens/cart/cart_screen.dart';
import '../../../../core/app/app.dart';
import '../../../../../../core/constant/colors.dart';

import 'bottom_navbar_cubit.dart';
import '../../../../../../core/enums/enums.dart';
import 'widgets/bottom_navbar.dart';
import '../categories/categories_screen.dart';
import '../home/home_screens.dart';
import '../product_list/products_list_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    Future<bool> _onWillPop() async {
      return (await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                "Exit Application",
                style: TextStyle(color: AppColors.primary),
              ),
              content: const Text(
                "Are You Sure?",
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    "Yes",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    "No",
                    style: TextStyle(color: AppColors.primary),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: const BottomNavigation(),
        body: Center(
          child: BlocBuilder<NavigationCubit, NavigationTab>(
            builder: (context, activeTab) {
              switch (activeTab) {
                case NavigationTab.homeTab:
                  return const HomeScreen();
                case NavigationTab.categoriesTab:
                  return const CategoriesScreen();
                case NavigationTab.productsTap:
                  return const ProductsListScreen();
                case NavigationTab.cartTab:
                  return const CartScreen();
                case NavigationTab.profileTab:
                  return const ProfileScreen();
                default:
                  return const HomeScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
