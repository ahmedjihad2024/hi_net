import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/constants.dart';
import 'package:hi_net/app/dependency_injection.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/app/services/app_preferences.dart';
import 'package:hi_net/app/supported_locales.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animated_on_appear.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/routes_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  ValueNotifier<int> currentPage = ValueNotifier(0);
  final CarouselSliderController carouselController =
      CarouselSliderController();

  Future<void> goToLogin() async {
    instance<AppPreferences>().setSkippedOnBoarding();
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(RoutesManager.signUp.route, (_) => false);
  }

  Future<void> toggleLanguage(BuildContext con) async {
    if (con.locale == SupportedLocales.EN.locale) {
      await context.setLocale(SupportedLocales.AR.locale);
      Phoenix.rebirth(con);
    } else {
      await context.setLocale(SupportedLocales.EN.locale);
      Phoenix.rebirth(con);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: context.isDark
              ? ColorM.primaryDark
              : Color(0xFFF8F8F8),
          body: SafeArea(
            bottom: true,
            top: false,
            child: Stack(
              children: [
                AnimatedOnAppear(
                  delay: Constants.animationDelay,
                  animationTypes: {AnimationType.shader},
                  shaderDirection: ShaderRevealDirection.topToBottom,
                  shaderRevealColor: Colors.white,
                  shaderSoftness: 0.1,
                  animationDuration: Constants.animationDuration,
                  shaderBlendMode: BlendMode.dstIn,
                  animationCurve: Constants.animationCurve,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.white,
                          Colors.transparent,
                        ],
                        stops: [0, .50, .90],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Container(
                      height: 375.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImagesM.onBoardingImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                // forground text
                Padding(
                  padding: EdgeInsets.only(
                    top: 14.dg,
                    left: SizeM.pagePadding.dg,
                    right: SizeM.pagePadding.dg,
                    bottom: 8.w,
                  ),
                  child: Column(
                    children: [
                      25.verticalSpace,

                      // language selector
                      AnimatedOnAppear(
                        delay: Constants.animationDelay,
                        animationTypes: {
                          AnimationType.fade,
                          AnimationType.slide,
                        },
                        slideDirection: SlideDirection.up,
                        slideDistance: Constants.animationSlideDistance,
                        animationDuration: Constants.animationDuration,
                        animationCurve: Constants.animationCurve,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black.withValues(alpha: .04),
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(9999),
                                color: context.colorScheme.onSurface,
                              ),
                              child: Row(
                                spacing: 4.w,
                                children: [
                                  LanguageButton(
                                    title: "En",
                                    onTap: () async {
                                      if (context.locale !=
                                          SupportedLocales.EN.locale) {
                                        await toggleLanguage(context);
                                      }
                                    },
                                    isSelected:
                                        context.locale ==
                                        SupportedLocales.EN.locale,
                                  ),
                                  LanguageButton(
                                    title: "عربي",
                                    onTap: () async {
                                      if (context.locale !=
                                          SupportedLocales.AR.locale) {
                                        await toggleLanguage(context);
                                      }
                                    },
                                    isSelected:
                                        context.locale ==
                                        SupportedLocales.AR.locale,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // description
                      ValueListenableBuilder(
                        valueListenable: currentPage,
                        builder: (context, value, child) {
                          String description = '';
                          String title = '';
                          switch (value) {
                            case 0:
                              title = Translation.stay_connected_anywhere.tr;
                              description = Translation.buy_activate_esim.tr;
                              break;
                            case 1:
                              title =
                                  Translation.global_coverage_local_rates.tr;
                              description =
                                  Translation.access_data_worldwide.tr;
                              break;
                            case 2:
                              title = Translation.activate_in_seconds.tr;
                              description =
                                  Translation.instant_setup_secure_payment.tr;
                              break;
                          }

                          return AnimatedOnAppear(
                            key: Key(
                              value.toString(),
                            ), // Important for animation triggering
                            slideDirection:
                                Directionality.of(context) == TextDirection.ltr
                                ? SlideDirection
                                      .left // Slide from right to left
                                : SlideDirection
                                      .right, // Slide from left to right in RTL
                            slideDistance: 110.0,
                            animationDuration: Duration(milliseconds: 600),
                            animationCurve: Curves.easeInOutCubicEmphasized,
                            animationTypes: {
                              AnimationType.slide,
                              AnimationType.fade,
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 14.w,
                              children: [
                                // title
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        title,
                                        textAlign: TextAlign.center,
                                        style: context.headlineMedium.copyWith(
                                          height: 1,
                                          fontWeight: FontWeightM.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                       // description
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        description,
                                        textAlign: TextAlign.center,
                                        style: context.labelLarge.copyWith(
                                          height: 1.15,
                                          fontWeight: FontWeightM.light,
                                          color: context.labelLarge.color!
                                              .withValues(alpha: .6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 14.w),

                      AnimatedOnAppear(
                        delay: Constants.animationDelay,
                        animationTypes: {
                          AnimationType.fade,
                          AnimationType.slide,
                        },
                        slideDirection: SlideDirection.up,
                        slideDistance: 60.0,
                        animationDuration: Constants.animationDuration,
                        animationCurve: Constants.animationCurve,
                        child: ValueListenableBuilder(
                          valueListenable: currentPage,
                          builder: (_, value, __) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 9.w,
                              children: [
                                for (int i = 0; i < 3; i++)
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    padding: EdgeInsets.all(
                                      i == value ? 3.w : 0,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: i == value
                                          ? Border.all(
                                              color: ColorM.primary,
                                              width: 1.5.w,
                                            )
                                          : null,
                                    ),
                                    child: AnimatedContainer(  
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      width: 11.w,
                                      height: 11.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: i == value
                                            ? ColorM.primary
                                            : ColorM.primary.withValues(
                                                alpha: .3,
                                              ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      53.verticalSpace,

                      // continue button
                      AnimatedOnAppear(
                        delay: Constants.animationDelay,
                        animationTypes: {
                          AnimationType.fade,
                          AnimationType.slide,
                        },
                        slideDirection: SlideDirection.up,
                        slideDistance: Constants.animationSlideDistance,
                        animationDuration: Constants.animationDuration,
                        animationCurve: Constants.animationCurve,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // next button
                            Expanded(
                              child: NextButton(
                                currentPage: currentPage,
                                goToLogin: goToLogin,
                              ),
                            ),
                          ],
                        ),
                      ),

                      24.verticalSpace,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NextButton extends StatelessWidget {
  final ValueNotifier<int> currentPage;
  final void Function() goToLogin;
  const NextButton({
    super.key,
    required this.currentPage,
    required this.goToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (_, value, __) {
        bool isLastPage = value == 2;
        return CustomInkButton(
          onTap: () {
            if (!isLastPage) {
              currentPage.value++;
            } else {
              goToLogin();
            }
          },
          gradient: LinearGradient(
            colors: [ColorM.primary, ColorM.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: SizeM.commonBorderRadius.r,
          height: 54.h,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 7.w,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isLastPage)
                SvgPicture.asset(SvgM.doubleArrow, width: 12.w, height: 12.h),
              Text(
                isLastPage ? Translation.join_now.tr : Translation.next.tr,
                style: context.labelLarge.copyWith(
                  fontWeight: FontWeightM.semiBold,
                  height: 1,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: Size(50.w, 30.w),
        backgroundColor: isSelected
            ? context.isDark
                  ? ColorM.primaryDark
                  : Color(0xFFF7E9EF)
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
      child: Text(
        title,
        style: context.labelSmall.copyWith(
          fontSize: 8.sp,
          height: 0.01,
          color: isSelected
              ? context.isDark
                    ? Colors.white
                    : Color(0xFF9B3864)
              : context.labelSmall.color!.withValues(alpha: .5),
        ),
      ),
    );
  }
}
