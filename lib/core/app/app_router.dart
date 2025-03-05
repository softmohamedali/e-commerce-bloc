import 'package:flutter/material.dart';

import '../../auth/presentation/screens/login/login_screen.dart';
import '../../auth/presentation/screens/signup/signup_screen.dart';
import '../../cart/presntation/screens/cart/cart_screen.dart';
import '../../market/data/models/product_model.dart';
import '../../market/presentation/screens/filter/filter_screen.dart';
import '../../market/presentation/screens/product_details/product_details_screen.dart';
import '../../market/presentation/screens/root/root.dart';
import '../../market/presentation/screens/search/search_screen.dart';
import '../../market/presentation/screens/wishlist/wishlist_screen.dart';
import '../../profile/presentation/screens/app_info/app_info_screen.dart';
import '../../profile/presentation/screens/contact/contact_screen.dart';
import '../../profile/presentation/screens/notification/notifications_screen.dart';
import '../../splash/presentation/onbording.dart';
import '../../splash/presentation/splash_screen.dart';
import '../error/exceptions.dart';

sealed class AppRouter {
  static const String splash = '/';
  static const String ads = '/ads';
  static const String root = '/root';
  static const String productDetails = '/product-details';
  static const String search = '/search';
  static const String filter = '/filter';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String addresses = '/addresses';
  static const String addadress = '/addadress';
  static const String checkout = '/checkout';
  static const String contact = '/contact';
  static const String appinfo = '/appinfo';
  static const String cart = '/cart';
  static const String wishlist = '/wishlist';
  static const String ordersuccess = '/ordersuccess';
  static const String orderfailure = '/orderfailure';
  static const String orders = '/orders';
  static const String notifications = '/notifications';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case ads:
        return MaterialPageRoute(builder: (_) =>  OnBordingScreen());
      case root:
        return MaterialPageRoute(builder: (_) => const RootScreen());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case filter:
        return MaterialPageRoute(builder: (_) => const FilterScreen());
      case productDetails:
        ProductModel product = routeSettings.arguments as ProductModel;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product));
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case contact:
        return MaterialPageRoute(builder: (_) => ContactScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case appinfo:
        String screenTitle = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => AppInfoScreen(
                  screenTitle: screenTitle,
                ));
      case wishlist:
        return MaterialPageRoute(builder: (_) => const WishListScreen());
      case orders:
        return MaterialPageRoute(builder: (_) => const SizedBox());
        // return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      default:
        throw const RouteException('Route not found!');
    }
  }
}
