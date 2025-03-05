import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../auth/presentation/screens/login/cubit/signin_bloc.dart';
import '../../../../core/utils/app_dimensions.dart';
import '../../../../core/utils/app_typography.dart';
import '../../../../core/utils/space.dart';
import '../../../../core/constant/assets.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/app/app_router.dart';
import '../../../../core/widgets/top_row.dart';
import 'widgets/unlogged_profile_container.dart';
import 'widgets/user_logged_profile_container.dart';

//TODO refactor and minimize code of this screen

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Icon _arrowforward = Icon(
      Icons.navigate_next,
      size: AppDimensions.normalize(6),
    );
    return Scaffold(
      body: Padding(
        padding: Space.hf(1.1),
        child: SafeArea(
          minimum: EdgeInsets.only(top: AppDimensions.normalize(20)),
          child: Column(
            children: [
              TopRow(isFromHome: false, context: context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Space.y!,
                      BlocBuilder<SignInBloc, SignInState>(
                        builder: (context, state) {
                          if (state is UserLogged) {
                            return userLoggedProfileContainer(context,
                                "${state.user.firstName}!", state.user.email);
                          } else {
                            return unloggedProfileContainer(context);
                          }
                        },
                      ),
                      BlocBuilder<SignInBloc, SignInState>(
                          builder: (context, state) {
                        if (state is UserLogged) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Space.yf(1.9),
                              Text(
                                "MY ACCOUNT",
                                style: AppText.h3b
                                    ?.copyWith(color: AppColors.primary),
                              ),
                              Space.yf(.9),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRouter.orders);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.Archive),
                                        Space.xf(),
                                        Text(
                                          "My Orders",
                                          style: AppText.b1b,
                                        )
                                      ],
                                    ),
                                    _arrowforward
                                  ],
                                ),
                              ),
                              Space.yf(1.1),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRouter.addresses);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.Marker),
                                        Space.xf(),
                                        Text(
                                          "Address Book",
                                          style: AppText.b1b,
                                        )
                                      ],
                                    ),
                                    _arrowforward
                                  ],
                                ),
                              ),
                              Space.yf(1.1),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.Profile,
                                        // color: AppColors.CommonCyan,
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.primary,
                                            BlendMode.srcIn),
                                      ),
                                      Space.xf(),
                                      Text(
                                        "Edit Account",
                                        style: AppText.b1b,
                                      )
                                    ],
                                  ),
                                  _arrowforward
                                ],
                              ),
                              Space.yf(1.1),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.Lock),
                                      Space.xf(),
                                      Text(
                                        "Change Password",
                                        style: AppText.b1b,
                                      )
                                    ],
                                  ),
                                  _arrowforward
                                ],
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                      Space.yf(1.9),
                      Text(
                        "SETTINGS",
                        style:
                            AppText.h3b?.copyWith(color: AppColors.primary),
                      ),
                      Space.yf(.9),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRouter.notifications);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    AppAssets.Bell,
                                  color: AppColors.icon,
                                ),
                                Space.xf(),
                                Text(
                                  "Notifications",
                                  style: AppText.b1b,
                                )
                              ],
                            ),
                            SizedBox(
                              height: AppDimensions.normalize(10),
                              child: Switch(
                                value: true,
                                onChanged: null,
                                activeTrackColor: AppColors.primary,
                                thumbColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Space.yf(1.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                  AppAssets.Globe,
                                  color: AppColors.icon,
                              ),
                              Space.xf(),
                              Text(
                                "Preferred Language",
                                style: AppText.b1b,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "English",
                                style: AppText.b2b
                                    ?.copyWith(color: AppColors.primary),
                              ),
                              Space.xf(.2),
                              _arrowforward
                            ],
                          ),
                        ],
                      ),
                      Space.yf(1.2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                  AppAssets.Money,
                                color: AppColors.icon,
                              ),
                              Space.xf(),
                              Text(
                                "Currency",
                                style: AppText.b1b,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Dollars",
                                style: AppText.b2b
                                    ?.copyWith(color: AppColors.primary),
                              ),
                              Space.xf(.2),
                              _arrowforward
                            ],
                          ),
                        ],
                      ),
                      Space.yf(2),
                      Text(
                        "SUPPORT",
                        style:
                            AppText.h3b?.copyWith(color: AppColors.primary),
                      ),
                      Space.yf(1.2),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRouter.appinfo,
                              arguments: "TERMS & CONDITIONS");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    AppAssets.Document,
                                  color: AppColors.icon,
                                ),
                                Space.xf(),
                                Text(
                                  "Terms & Conditions",
                                  style: AppText.b1b,
                                )
                              ],
                            ),
                            _arrowforward
                          ],
                        ),
                      ),
                      Space.yf(1.1),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRouter.appinfo,
                              arguments: "PRIVACY POLICY");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    AppAssets.Document,
                                  color: AppColors.icon,
                                ),
                                Space.xf(),
                                Text(
                                  "Privacy Policy",
                                  style: AppText.b1b,
                                )
                              ],
                            ),
                            _arrowforward
                          ],
                        ),
                      ),
                      Space.yf(1.1),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRouter.contact);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    AppAssets.Comments,
                                  color: AppColors.icon,
                                ),
                                Space.xf(),
                                Text(
                                  "Contact",
                                  style: AppText.b1b,
                                )
                              ],
                            ),
                            _arrowforward
                          ],
                        ),
                      ),
                      Space.yf(2.9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "V.1.0",
                            style: AppText.b1b,
                          )
                        ],
                      ),
                      Space.yf(.3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.Whats,
                            height: AppDimensions.normalize(15),
                          ),
                          SvgPicture.asset(
                            AppAssets.Noti,
                            height: AppDimensions.normalize(15),
                          ),
                          SvgPicture.asset(
                            AppAssets.Music,
                            height: AppDimensions.normalize(15),
                          ),
                        ],
                      ),
                      Space.yf(1.3),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
