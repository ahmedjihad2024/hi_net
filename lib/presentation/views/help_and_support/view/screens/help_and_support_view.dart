import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/app/phone_number_validator.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/country_code_button.dart';
import 'package:hi_net/presentation/common/ui_components/custom_form_field/simple_form.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/common/utils/fast_function.dart';
import 'package:hi_net/presentation/common/utils/snackbar_helper.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/home/view/screens/home_view.dart';
import 'package:nice_text_form/nice_text_form.dart';

class HelpAndSupportView extends StatefulWidget {
  const HelpAndSupportView({super.key});

  @override
  State<HelpAndSupportView> createState() => _HelpAndSupportViewState();
}

class _HelpAndSupportViewState extends State<HelpAndSupportView> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final FocusNode userNameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode messageFocus = FocusNode();
  String dialCode = "+966";
  ValueNotifier<String> countryCodeNotifier = ValueNotifier<String>("SA");

  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    userNameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
    messageFocus.dispose();
    super.dispose();
  }

  void _sendMessage() {
    print(phoneController.text);
    print(dialCode);
    phoneController.text = phoneController.text.onlyNumbers;
    // check if user name is empty
    if (userNameController.text.trim().isEmpty) {
      userNameFocus.requestFocus();
    } else if (phoneController.text.onlyDoubles.trim().isEmpty) {
      phoneFocus.requestFocus();
    }
    // check if phone number is valid
    else if (!CountryUtils.validatePhoneNumber(
          phoneController.text.onlyDoubles,
          dialCode,
        ) &&
        !CountryUtils.validatePhoneNumber(
          phoneController.text.onlyDoubles.substring(
            1,
            phoneController.text.onlyDoubles.length,
          ),
          dialCode,
        )) {
      SnackbarHelper.showMessage(
        Translation.error_invalid_number.tr,
        ErrorMessage.snackBar,
        isError: true,
      );
    }
    // check if email is valid
    else if ((emailController.text.trim().isNotEmpty &&
        !isValidEmail(emailController.text))) {
      SnackbarHelper.showMessage(
        Translation.error_invalid_email.tr,
        ErrorMessage.snackBar,
        isError: true,
      );
    } else if (messageController.text.trim().isEmpty) {
      messageFocus.requestFocus();
    }
    // if all is valid start sign up or update profile
    else {
      // update phone number to be in the format shape +20999999999
      if (CountryUtils.validatePhoneNumber(
        phoneController.text.onlyDoubles.substring(
          1,
          phoneController.text.onlyDoubles.length,
        ),
        dialCode,
      )) {
        phoneController.text = phoneController.text.onlyDoubles.substring(
          1,
          phoneController.text.onlyDoubles.length,
        );
      }

      String phone = dialCode + phoneController.text;

      // todo update profile
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: 1.sh,
              child: Column(
                children: [
                  49.verticalSpace,
                  DefaultAppBar(
                    actionButtons: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Translation.wallet.tr,
                              style: context.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 40.w),
                    ],
                  ).animatedOnAppear(4, SlideDirection.down),
                  24.verticalSpace,
                  Image.asset(
                    ImagesM.chat,
                    width: 106,
                    height: 106.w,
                  ).animatedOnAppear(3, SlideDirection.down),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeM.pagePadding.dg,
                    ),
                    child: Column(
                      children: [
                        14.verticalSpace,
                        Text(
                          Translation.tell_us_what_s_wrong.tr,
                          textAlign: TextAlign.center,
                          style: context.bodyMedium.copyWith(
                            fontWeight: FontWeightM.light,
                          ),
                        ).animatedOnAppear(2, SlideDirection.down),
                        24.verticalSpace,
                        SimpleForm(
                          hintText: Translation.full_name.tr,
                          keyboardType: TextInputType.name,
                          controller: userNameController,
                          focusNode: userNameFocus,
                        ).animatedOnAppear(1, SlideDirection.down),
                        16.verticalSpace,

                        SimpleForm(
                          hintText: Translation.suggested.tr,
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                          focusNode: phoneFocus,
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
                                valueListenable: countryCodeNotifier,
                                builder: (context, value, child) {
                                  return FastCountryCodeButton(
                                    controller: CountryCodePickerController(initialSelection: value, locale: context.locale),
                                    onSelectionChange: (cCode) {
                                      dialCode = cCode.dialCode;
                                      countryCodeNotifier.value =
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

                        16.verticalSpace,
                        SimpleForm(
                          hintText: Translation.email_optional.tr,
                          keyboardType: TextInputType.name,
                          controller: emailController,
                          focusNode: emailFocus,
                        ).animatedOnAppear(1, SlideDirection.up),
                        16.verticalSpace,
                        SimpleForm(
                          hintText: Translation.your_message.tr,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          controller: messageController,
                          focusNode: messageFocus,
                          alignment: AlignmentDirectional.topStart,
                          height: 120.w,
                          maxLines: 30,
                        ).animatedOnAppear(2, SlideDirection.up),
                      ],
                    ),
                  ),

                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeM.pagePadding.dg,
                    ),
                    child: CustomInkButton(
                      onTap: _sendMessage,
                      width: double.infinity,
                      height: 56.h,
                      borderRadius: SizeM.commonBorderRadius.r,
                      alignment: Alignment.center,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF005DFF),
                          Color(0xFF113593),
                          Color(0xFF8F1ABA),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          Translation.send.tr,
                          style: context.bodyMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ).animatedOnAppear(3, SlideDirection.up),
                  ),

                  SizedBox(
                    height: 15.w + MediaQuery.of(context).padding.bottom,
                  ),
                ],
              ),
            ),
          ),
        ),
        WhatsappButton(),
      ],
    );
  }
}
