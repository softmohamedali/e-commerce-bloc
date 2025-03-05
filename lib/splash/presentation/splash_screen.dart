import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constant/colors.dart';
import '../../core/utils/configs.dart';
import '../../core/constant/assets.dart';
import '../../core/app/app_router.dart';
import '../../core/app/app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _nextScreen() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouter.ads,
        (route) => false,
      );
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nextScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Image.asset(AppAssets.Logo,),
          ),
          Positioned(
            bottom: AppDimensions.normalize(10),
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
