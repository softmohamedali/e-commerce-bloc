import 'package:flutter/material.dart';

import '../../../../core/utils/space.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/widgets/custom_appbar.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key, required this.screenTitle});

  final String screenTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(screenTitle, context,automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: Space.all(1, .1),
          child: Column(
            children: [
              const Text(
                infoText,
                style: TextStyle(height: 2),
              ),
              Space.yf(1.5),
              const Text(
                infoText,
                style: TextStyle(height: 2),
              ),
              Space.yf(1.5),
              const Text(
                infoText,
                style: TextStyle(height: 2),
              ),
              Space.yf(1.5),
              const Text(
                infoText,
                style: TextStyle(height: 2),
              ),
              Space.yf(2.5),
            ],
          ),
        ),
      ),
    );
  }
}
