import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/presentation/screens/login/cubit/signin_bloc.dart';
import '../../auth/presentation/screens/signup/cubit/signup_bloc.dart';
import '../../di/di.dart' as di;
import '../../market/data/models/filter_params_model.dart';
import '../../market/presentation/screens/categories/category_bloc.dart';
import '../../market/presentation/screens/filter/filter_cubit.dart';
import '../../market/presentation/screens/product_details/share_cubit.dart';
import '../../market/presentation/screens/product_list/product_bloc.dart';
import '../../market/presentation/screens/root/bottom_navbar_cubit.dart';
import '../../market/presentation/screens/wishlist/wishlist_cubit.dart';
import '../../profile/presentation/screens/notification/notifications_cubit.dart';
import '../constant/colors.dart';
import '../constant/strings.dart';
import 'app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<NavigationCubit>()),
        BlocProvider(
          create: (context) => di.sl<WishlistCubit>()..loadWishlist(),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<CategoryBloc>()..add(const GetCategories()),
        ),
        BlocProvider(
          create: (context) => di.sl<ProductBloc>()
            ..add(const GetProducts(FilterProductParams())),
        ),
        BlocProvider(
          create: (context) => di.sl<FilterCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<SignInBloc>()..add(CheckUser()),
        ),
        BlocProvider(
          create: (context) => di.sl<SingUpBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ShareCubit>(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => di.sl<NotificationsCubit>()..init(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        onGenerateRoute: AppRouter.onGenerateRoute,
        theme: ThemeData.light().copyWith(
          canvasColor: AppColors.primary,
          appBarTheme: AppBarTheme(
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              toolbarHeight: 56,
              centerTitle: true,
              iconTheme:
                  const IconThemeData(color: AppColors.primary, size: 30)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(170, 50),
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          )),
          iconTheme: const IconThemeData(color: AppColors.primary, size: 30),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.primary,
          ),
        ),
        initialRoute: AppRouter.splash,
      ),
    );
  }
}
