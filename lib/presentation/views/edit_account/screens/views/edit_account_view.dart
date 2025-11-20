import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/app/phone_number_validator.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/country_code_button.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/common/ui_components/custom_form_field/simple_form.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/common/ui_components/platform_safe_area.dart';
import 'package:hi_net/presentation/common/utils/after_layout.dart';
import 'package:hi_net/presentation/common/utils/fast_function.dart';
import 'package:hi_net/presentation/common/utils/overlay_loading.dart';
import 'package:hi_net/presentation/common/utils/state_render.dart';
import 'package:hi_net/presentation/common/utils/toast.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/edit_account/bloc/edit_account_bloc.dart';
import 'package:hi_net/presentation/common/ui_components/gradient_border_side.dart'
    as gradient_border_side;
import 'package:nice_text_form/nice_text_form.dart';
import 'package:smooth_corner/smooth_corner.dart';

class EditAccountView extends StatefulWidget {
  const EditAccountView({super.key});

  @override
  State<EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> with AfterLayout {
  late OverlayLoading overlayLoading;
  final TextEditingController userNameController = TextEditingController();
  final FocusNode userNameFocus = FocusNode();
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();

  @override
  void dispose() {
    userNameController.dispose();
    userNameFocus.dispose();
    phoneController.dispose();
    phoneFocus.dispose();
    emailController.dispose();
    emailFocus.dispose();
    super.dispose();
  }

  void _editAccount() {
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
          context.read<EditAccountBloc>().state.dialCode,
        ) &&
        !CountryUtils.validatePhoneNumber(
          phoneController.text.onlyDoubles.substring(
            1,
            phoneController.text.onlyDoubles.length,
          ),
          context.read<EditAccountBloc>().state.dialCode,
        )) {
      showSnackBar(
        msg: Translation.error_invalid_number.tr,
        context: context,
        isError: true,
      );
    }
    // check if email is valid
    else if ((emailController.text.trim().isNotEmpty &&
        !isValidEmail(emailController.text))) {
      showSnackBar(
        msg: Translation.error_invalid_email.tr,
        context: context,
        isError: true,
      );
    }
    // if all is valid start sign up or update profile
    else {
      // update phone number to be in the format shape +20999999999
      if (CountryUtils.validatePhoneNumber(
        phoneController.text.onlyDoubles.substring(
          1,
          phoneController.text.onlyDoubles.length,
        ),
        context.read<EditAccountBloc>().state.dialCode,
      )) {
        phoneController.text = phoneController.text.onlyDoubles.substring(
          1,
          phoneController.text.onlyDoubles.length,
        );
      }

      String phone =
          context.read<EditAccountBloc>().state.dialCode + phoneController.text;

      // todo update profile
    }
  }

  var phoneKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EditAccountBloc, EditAccountState>(
        listener: (context, state) {
          phoneKey = UniqueKey();
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              height: 1.sh,
              child: Column(
                children: [
                  49.verticalSpace,
                  DefaultAppBar(
                    actionButtons: [
                      Expanded(
                        child: Row(
                          spacing: 14.w,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Translation.edit_profile.tr,
                              style: context.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 40.w),
                    ],
                  ).animatedOnAppear(2, SlideDirection.down),
                  38.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeM.pagePadding.dg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SelectImageProfile(
                          selectedImage: state.selectedImage,
                          profileImg: state.imageUrl,
                        ).animatedOnAppear(1, SlideDirection.down),

                        32.verticalSpace,
                        SimpleForm(
                          hintText: Translation.full_name.tr,
                          keyboardType: TextInputType.name,
                          controller: userNameController,
                          focusNode: userNameFocus,
                        ).animatedOnAppear(0, SlideDirection.down),
                        24.verticalSpace,

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
                              FastCountryCodeButton(
                                controller: CountryCodePickerController(initialSelection: state.countryCode, locale: context.locale),
                                onSelectionChange: (cCode) {
                                  context.read<EditAccountBloc>().add(
                                    EditAccountCountryCodeChanged(
                                      cCode.dialCode,
                                      cCode.countryCode,
                                    ),
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
                        ).animatedOnAppear(1, SlideDirection.up),

                        24.verticalSpace,
                        SimpleForm(
                          hintText: Translation.email_optional.tr,
                          keyboardType: TextInputType.name,
                          controller: emailController,
                          focusNode: emailFocus,
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
                      onTap: _editAccount,
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
                          Translation.update.tr,
                          style: context.bodyLarge.copyWith(
                            fontWeight: FontWeightM.medium,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ).animatedOnAppear(3, SlideDirection.up),
                  10.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeM.pagePadding.dg,
                    ),
                    child: CustomInkButton(
                      onTap: () {},
                      width: double.infinity,
                      height: 56.h,
                      borderRadius: SizeM.commonBorderRadius.r,
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          Translation.delete_account.tr,
                          style: context.bodyMedium.copyWith(
                            color: Color(0xFFE32915),
                          ),
                        ),
                      ),
                    ).animatedOnAppear(4, SlideDirection.up),
                  ),

                  SizedBox(
                    height: 10.h + MediaQuery.of(context).padding.bottom,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Future<void> afterLayout(BuildContext context) async {
    PhoneNumber? phoneNumber;

    // if (currentUserData.phone != null) {
    //   phoneNumber =
    //       CountryUtils.extractCountryCodeAndNumber('+${currentUserData.phone}');
    //   phoneController.text = phoneNumber?.localNumber ?? '';
    // }

    // context
    //     .read<EditAccountBloc>()
    //     .add(InitEditAccount(currentUserData, phoneNumber));

    // context.read<EditAccountBloc>().add(EditAccountCountryCodeChanged(
    //     phoneNumber!.country.dialCode, phoneNumber.country.isoCode));
  }
}

class _SelectImageProfile extends StatelessWidget {
  final File? selectedImage;
  final String? profileImg;
  const _SelectImageProfile({
    required this.selectedImage,
    required this.profileImg,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 14.w,
      children: [
        Stack(
          children: [
            SmoothClipRRect(
              smoothness: 1,
              borderRadius: BorderRadius.circular(14.r),
              child: selectedImage != null
                  ? Image.file(
                      selectedImage!,
                      width: 95.w,
                      height: 95.w,
                      fit: BoxFit.cover,
                    )
                  : profileImg != null
                  ? CustomCachedImage(
                      imageUrl: profileImg!,
                      width: 95.w,
                      height: 95.w,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(18.r),
                    )
                  : Container(
                      width: 95.w,
                      height: 95.w,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: context.isDark
                            ? ColorM.primaryDark
                            : Colors.black.withValues(alpha: .07),
                        shape: SmoothRectangleBorder(
                          smoothness: 1,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: SvgPicture.asset(
                        SvgM.upload,
                        width: 24.w,
                        height: 24.w,
                      ),
                    ),
            ),
            if (selectedImage != null || profileImg != null)
              Positioned(
                top: 5.w,
                right: 5.w,
                child: InkWell(
                  onTap: () {
                    context.read<EditAccountBloc>().add(
                      RemoveImageProfile(() {}),
                    );
                  },
                  child: Icon(Icons.close, color: Colors.red, size: 24.w),
                ),
              ),
          ],
        ),
        Expanded(
          child: CustomInkButton(
            onTap: () {
              context.read<EditAccountBloc>().add(SelectImageProfile());
            },
            height: 38.h,
            backgroundColor: Colors.transparent,
            side: gradient_border_side.BorderSide(
              gradient: LinearGradient(
                colors: [ColorM.primary, ColorM.secondary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              width: 1.w,
            ),
            padding: EdgeInsets.zero,
            borderRadius: 12.r,
            alignment: Alignment.center,
            child: Row(
              spacing: 10.w,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [ColorM.primary, ColorM.secondary],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds);
                  },
                  child: SvgPicture.asset(
                    SvgM.camera,
                    width: 18.w,
                    height: 18.w,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),

                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [ColorM.primary, ColorM.secondary],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    Translation.change_your_picture.tr,
                    style: context.labelMedium.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
