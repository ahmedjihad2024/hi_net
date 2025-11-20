
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/enums.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/common/ui_components/otp_field.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/routes_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/common/ui_components/gradient_border_side.dart'
    as gradient_border;

class VerifyNumberView extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  final VerifyType verifyType;
  const VerifyNumberView({
    Key? key,
    required this.phoneNumber,
    required this.countryCode,
    required this.verifyType,
  }) : super(key: key);

  @override
  State<VerifyNumberView> createState() => _VerifyNumberViewState();
}

class _VerifyNumberViewState extends State<VerifyNumberView> {
  String otp = "";
  final ValueNotifier<String> initialCountryCodeName = ValueNotifier<String>(
    "EG",
  );
  final ValueNotifier<String> countryCode = ValueNotifier<String>("+20");

  void onSignInButtonPressed() {
    String code = otp.trim();
    if (code.trim().length == 5) {
      Navigator.of(context).pushNamed(RoutesManager.home.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1.sh,
          child: SafeArea(
            child: Column(
              children: [
                // Header with back button and "Sign In" title
                DefaultAppBar(
                  titleTextAlign: TextAlign.right,
                  titleAlignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.w,
                  ),
                ).animatedOnAppear(3, SlideDirection.down),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        // Welcome Aboard Title
                        Text(
                          Translation.verify_your_number.tr,
                          style: context.titleLarge.copyWith(
                            fontWeight: FontWeightM.bold,
                            fontSize: 28.sp,
                          ),
                        ).animatedOnAppear(2, SlideDirection.down),
                        SizedBox(height: 12.h),
                        // Subtitle
                        Text(
                          Translation.verify_your_number_message.tr,
                          style: context.bodyMedium.copyWith(
                            fontWeight: FontWeightM.light,
                            color: context.bodyMedium.color!.withValues(
                              alpha: context.isDark ? .9 : .5,
                            ),
                          ),
                        ).animatedOnAppear(1, SlideDirection.down),
                        SizedBox(height: 32.h),
                        // Phone Number Input Container with Flag
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OtpField(
                              length: 5,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 10.w,
                              mainAxisSize: MainAxisSize.min,
                              fieldWidth: 54.w,
                              fieldHeight: 54.w,
                              unselectedFieldDecoration: ShapeDecoration(
                                shape: gradient_border.SmoothRectangleBorder(
                                  smoothness: 1,
                                  borderRadius: BorderRadius.circular(12.r),
                                  side: gradient_border.BorderSide(
                                    color: context.colorScheme.surface
                                        .withValues(alpha: .1),
                                    width: 1.w,
                                  ),
                                ),
                                color: context.colorScheme.onSurface,
                              ),
                              selectedFieldDecoration: ShapeDecoration(
                                shape: gradient_border.SmoothRectangleBorder(
                                  smoothness: 1,
                                  borderRadius: BorderRadius.circular(12.r),
                                  side: gradient_border.BorderSide(
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorM.primary,
                                        ColorM.secondary,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    width: 1.w,
                                  ),
                                ),
                                color: context.colorScheme.onSurface,
                              ),
                              textStyle: context.bodyLarge.copyWith(
                                fontWeight: FontWeightM.semiBold,
                                color: context.colorScheme.surface,
                              ),
                              hintStyle: context.bodyLarge.copyWith(
                                fontWeight: FontWeightM.semiBold,
                                color: context.colorScheme.surface.withValues(
                                  alpha: .3,
                                ),
                              ),
                              hintText: '_',
                              onCancelled: (otp) {
                                this.otp = otp;
                              },
                            ).animatedOnAppear(0, SlideDirection.down),
                          ],
                        ),

                        const Spacer(),

                        CustomInkButton(
                          onTap: onSignInButtonPressed,
                          width: double.infinity,
                          height: 56.h,
                          gradient: LinearGradient(
                            colors: [ColorM.primary, ColorM.secondary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: SizeM.commonBorderRadius.r,
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              Translation.verify.tr,
                              style: context.bodyLarge.copyWith(
                                fontWeight: FontWeightM.semiBold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ).animatedOnAppear(1, SlideDirection.up),

                        SizedBox(height: 48.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

