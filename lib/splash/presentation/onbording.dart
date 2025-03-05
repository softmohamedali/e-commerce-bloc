import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../core/app/app_router.dart';
import '../../core/constant/assets.dart';
import '../../core/constant/colors.dart';


class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  _OnBordingScreenState createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Welcome to Our App',
      'subtitle': 'Discover amazing features and enjoy the experience.',
      'image': AppAssets.LogoCR
    },
    {
      'title': 'Select what you love',
      'subtitle': 'Find the best deals on the items you love. At Metor, you may shop today based on styles, colors, and more.',
      'image': AppAssets.onbording1_png
    },
    {
      'title': 'Make smart payments',
      'subtitle': 'Make smart payments with Metor, the simplest, safest and most rewarding trading platform.',
      'image': AppAssets.onbording2_png
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // PageView for onboarding screens
          Expanded(
            flex: 3,
              child:PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    title: onboardingData[index]['title']!,
                    subtitle: onboardingData[index]['subtitle']!,
                    image: onboardingData[index]['image']!,
                  );
                },
              ),
          ),

          // Dots Indicator
          Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Image.asset(
                    fit:BoxFit.fill,
                    AppAssets.onbording_back_png,
                    width: double.infinity,
                  ),

                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        DotsIndicator(
                          dotsCount: onboardingData.length,
                          position: _currentPage.toDouble(),
                          decorator: DotsDecorator(
                            activeColor: AppColors.coralPink,
                            size: const Size.square(9.0),
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              if(_currentPage == onboardingData.length - 1){
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  AppRouter.root,
                                      (route) => false,
                                );
                              }else{
                                setState(() {
                                  _currentPage++;
                                  _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.coralPink,
                              ),
                              child: _currentPage == onboardingData.length - 1?
                              const Text(
                                  'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
                                  :
                              Icon(
                                  Icons.navigate_next,
                                color: Colors.white,
                              ),
                            ),
                          )

                      ],
                    ),
                  ),
                ],
              )
          ),

        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  width: 250,
                  height: 250,
                ),
                SizedBox(height: 30),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ),
              ],
            )
        ),
      ],
    );
  }
}
