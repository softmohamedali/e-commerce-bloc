
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constant/strings.dart';
import '../utils/app_typography.dart';
import '../utils/space.dart';
import '../../core/constant/assets.dart';

import '../../market/presentation/screens/product_list/product_bloc.dart';
import '../../core/constant/colors.dart';
import '../../market/data/models/filter_params_model.dart';

class NoConnectionColumn extends StatefulWidget {
  const NoConnectionColumn({super.key, required this.isFromCategories});

  final bool isFromCategories;

  @override
  State<NoConnectionColumn> createState() => _NoConnectionColumnState();
}

class _NoConnectionColumnState extends State<NoConnectionColumn> {
  bool isLoading = false;

  void startLoading() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Space.yf(2),
            const Text(
                appTitle,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Space.yf(3),
            SvgPicture.asset(AppAssets.BadConnection),
            Space.yf(3),
            Text(
              "NO INTERNET CONECTION\nServer Error".toUpperCase(),
              style: AppText.h2b
                  ?.copyWith(color: AppColors.primary, height: 1.7,),
              textAlign: TextAlign.center,
            ),
            Space.yf(2),
            Text(
              "PLEASE CHECK YOUR ( WI-FI / DATA)\nINTERNET CONNECTION\nOR TRY AGAIN LATER.",
              style: AppText.h3?.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
            Space.yf(2),
            Padding(
              padding: Space.hf(),
              child: Material(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.isFromCategories
                          ? Phoenix.rebirth(context)
                          : context
                              .read<ProductBloc>()
                              .add(const GetProducts(FilterProductParams()));
                      setState(() {
                        startLoading();
                      });
                    },
                    child: Text(
                      isLoading ? "Wait..." : "Try Again",
                      style: AppText.b1b?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Space.yf(1.5),
          ],
        ),
      ),
    );
  }
}
