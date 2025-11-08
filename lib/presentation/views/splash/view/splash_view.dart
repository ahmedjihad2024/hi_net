import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/constants.dart';
import 'package:hi_net/app/dependency_injection.dart';
import 'package:hi_net/app/services/app_preferences.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animated_on_appear.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/utils/after_layout.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with AfterLayout {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedOnAppear(
                    delay: 700,
                    animationTypes: {AnimationType.shader},
                    shaderDirection: ShaderRevealDirection.startToEnd,
                    shaderRevealColor: Colors.white,
                    shaderSoftness: 0.2,
                    animationDuration: const Duration(seconds: 2),
                    shaderBlendMode: BlendMode.dstIn,
                    animationCurve: Curves.fastEaseInToSlowEaseOut,
                    child: Image.asset(
                      ImagesM.splashLogo,
                      width: 196.w,
                      height: 183.w,
                    ),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(SvgM.wifi, width: 264.w, height: 158.w),
            )
          ],
        ),
      ),
    );
  }

  @override
  Future<void> afterLayout(BuildContext context) async {
    // await instance<AppPreferences>().clearAllTokens();
    // await instance<AppPreferences>().deleteUserData();

    Timer(Duration(seconds: Constants.splashTimer), () async {
      if (instance<AppPreferences>().isSkippedOnBoarding) {
        if (instance<AppPreferences>().isUserRegistered) {
          // Navigator.of(
          //   context,
          // ).pushNamedAndRemoveUntil(RoutesManager.home.route, (_) => false);
        } else {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(RoutesManager.signUp.route, (_) => false);
        }
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RoutesManager.onBoarding.route,
          (_) => false,
        );
      }
    });
  }
}
