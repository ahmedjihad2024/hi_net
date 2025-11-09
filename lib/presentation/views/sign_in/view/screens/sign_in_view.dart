import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/app/phone_number_validator.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/country_code_button.dart';
import 'package:hi_net/presentation/common/ui_components/custom_form_field/simple_form.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/common/utils/snackbar_helper.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final ValueNotifier<String> initialCountryCodeName = ValueNotifier<String>(
    "EG",
  );
  final ValueNotifier<String> countryCode = ValueNotifier<String>("+20");

  @override
  void dispose() {
    phoneNumberController.dispose();
    phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void onSignInButtonPressed() {
    phoneNumberController.text = phoneNumberController.text.onlyNumbers;
    if (phoneNumberController.text.onlyDoubles.trim().isEmpty) {
      phoneNumberFocusNode.requestFocus();
    }
    // check if phone number is valid
    else if (!CountryUtils.validatePhoneNumber(
          phoneNumberController.text.onlyDoubles,
          countryCode.value,
        ) &&
        !CountryUtils.validatePhoneNumber(
          phoneNumberController.text.onlyDoubles.substring(
            1,
            phoneNumberController.text.onlyDoubles.length,
          ),
          countryCode.value,
        )) {
      SnackbarHelper.showMessage(
        Translation.error_invalid_number.tr,
        ErrorMessage.snackBar,
      );
    }
    // if all is valid start sign up or update profile
    else {
      // update phone number to be in the format shape +20999999999
      if (CountryUtils.validatePhoneNumber(
        phoneNumberController.text.onlyDoubles.substring(
          1,
          phoneNumberController.text.onlyDoubles.length,
        ),
        countryCode.value,
      )) {
        phoneNumberController.text = phoneNumberController.text.onlyDoubles
            .substring(1, phoneNumberController.text.onlyDoubles.length);
      }

      // TODO: start sign in
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and "Sign In" title
            DefaultAppBar(
              titleTextAlign: TextAlign.right,
              titleAlignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
              actionButtons: [
                CustomInkButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  child: Text(Translation.sign_up.tr, style: context.bodyLarge),
                ),
              ],                    
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
                      Translation.welcome_back.tr,
                      style: context.titleLarge.copyWith(
                        fontWeight: FontWeightM.bold,
                        fontSize: 28.sp,
                      ),
                    ).animatedOnAppear(2, SlideDirection.down),
                    SizedBox(height: 12.h),
                    // Subtitle
                    Text(
                      Translation.sign_in_message.tr,
                      style: context.bodyMedium.copyWith(
                        color: context.bodyMedium.color!.withValues(alpha: .5),
                      ),
                    ).animatedOnAppear(1, SlideDirection.down),
                    SizedBox(height: 32.h),
                    // Phone Number Input Container with Flag
                    SimpleForm(
                      hintText: Translation.suggested.tr,
                      keyboardType: TextInputType.number,
                      controller: phoneNumberController,
                      focusNode: phoneNumberFocusNode,
                      label2: Text(
                        Translation.phone_number.tr,
                        style: context.labelLarge.copyWith(
                          color: context.colorScheme.surface.withValues(
                            alpha: .5,
                          ),
                        ),
                      ),
                      prefixWidget: Row(
                        spacing: 10.w,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: initialCountryCodeName,
                            builder: (_, val, __) {
                              return FastCountryCodeButton(
                                initialSelection: val,
                                scale: .8,
                                onSelectionChange: (cCode) {
                                  countryCode.value = cCode.dialCode;
                                  initialCountryCodeName.value =
                                      cCode.countryCode;
                                },
                              );
                            },
                          ),

                          RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.arrow_back_ios,
                              textDirection: TextDirection.rtl,
                              size: 11.w,
                              color: context.colorScheme.surface.withValues(
                                alpha: .5,
                              ),
                            ),
                          ),

                          Container(
                            width: 1.5,
                            height: 30.w,
                            color: context.colorScheme.surface.withValues(
                              alpha: .2,
                            ),
                          ),
                        ],
                      ),
                    ).animatedOnAppear(0, SlideDirection.down),

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
                          Translation.sign_in.tr,
                          style: context.bodyLarge.copyWith(
                            fontWeight: FontWeightM.semiBold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ).animatedOnAppear(0, SlideDirection.up),
                    SizedBox(height: 16.h),
                    // Terms and Privacy Policy
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.colorScheme.surface.withValues(
                              alpha: .5,
                            ),
                          ),
                          children: [
                            TextSpan(
                              text: Translation.no_account_sign_up.tr,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pop();
                                },
                            ),
                          ],
                        ),
                      ),
                    ).animatedOnAppear(2, SlideDirection.up),
                    SizedBox(height: 48.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


