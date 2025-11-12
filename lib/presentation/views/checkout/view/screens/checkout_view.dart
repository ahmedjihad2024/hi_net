import 'package:animated_visibility/animated_visibility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/enums.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/common/ui_components/custom_check_box.dart';
import 'package:hi_net/presentation/common/ui_components/custom_form_field/simple_form.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/checkout/view/widgets/choose_another_plan_bottom_sheet.dart';
import 'package:hi_net/presentation/views/checkout/view/widgets/payment_method_item.dart';
import 'package:hi_net/presentation/views/checkout/view/widgets/place_order_bottom_sheet.dart';
import 'package:hi_net/presentation/views/esim_details/view/widgets/plan_item.dart';
import 'package:smooth_corner/smooth_corner.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  ValueNotifier<PaymentMethod> paymentMethod = ValueNotifier<PaymentMethod>(
    PaymentMethod.visa,
  );

  TextEditingController promoCodeController = TextEditingController();
  ValueNotifier<bool> checkTermsAndConditions = ValueNotifier<bool>(false);
  ValueNotifier<bool> devicesSupportEsim = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    Text(Translation.checkout.tr, style: context.bodyLarge),
                  ],
                ),
              ),
              SizedBox(width: 40.w),
            ],
          ).animatedOnAppear(4, SlideDirection.down),
          26.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  plan(
                    imageUrl: '',
                    days: '7',
                    gb: 10,
                    price: '100',
                    title: 'Egypt',
                    type: EsimsType.countrie,
                  ).animatedOnAppear(3, SlideDirection.down),
                  8.verticalSpace,
                  switchPlan().animatedOnAppear(2, SlideDirection.down),
                  18.verticalSpace,
                  Text(
                    Translation.payment_method.tr,
                    style: context.bodyMedium,
                  ).animatedOnAppear(1, SlideDirection.down),
                  18.verticalSpace,
                  paymentMethods().animatedOnAppear(0, SlideDirection.down),
                  18.verticalSpace,
                  promoCode().animatedOnAppear(0, SlideDirection.up),
                  18.verticalSpace,
                  paymentSummary().animatedOnAppear(1, SlideDirection.up),
                  12.verticalSpace,
                  checkBoxs().animatedOnAppear(2, SlideDirection.up),
                ],
              ),
            ),
          ),
          14.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
            child: CustomInkButton(
              onTap: () {
                PlaceOrderBottomSheet.show(context);
              },
              gradient: LinearGradient(
                colors: [ColorM.primary, ColorM.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.dg),
              borderRadius: SizeM.commonBorderRadius.r,
              height: 54.h,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 7.w,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Translation.pay_now.tr,
                        style: context.labelLarge.copyWith(
                          fontWeight: FontWeightM.semiBold,
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                      SvgPicture.asset(
                        SvgM.doubleArrow2,
                        width: 12.w,
                        height: 12.h,
                      ),
                    ],
                  ),

                  Row(
                    spacing: 12.w,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 1.w,
                        height: 20.w,
                        color: Colors.white.withValues(alpha: .5),
                      ),
                      Text(
                        Translation.sar.trNamed({'sar': '100'}),
                        style: context.bodyLarge.copyWith(
                          height: 1.1,
                          fontWeight: FontWeightM.medium,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animatedOnAppear(0, SlideDirection.up),

          SizedBox(height: MediaQuery.of(context).padding.bottom + 10.h),
        ],
      ),
    );
  }

  Widget plan({
    required String imageUrl,
    required String days,
    int? gb,
    required String price,
    required String title,
    EsimsType type = EsimsType.countrie,
  }) {
    return CustomInkButton(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      borderRadius: 14.r,
      side: BorderSide(
        color: context.colorScheme.surface.withValues(alpha: .1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 12.w,
            children: [
              switch (type) {
                EsimsType.countrie => CustomCachedImage(
                  imageUrl: imageUrl,
                  width: 28.w,
                  height: 28.w,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                EsimsType.regional => SvgPicture.asset(
                  SvgM.earth,
                  width: 28.w,
                  height: 28.w,
                ),
                EsimsType.global => SvgPicture.asset(
                  SvgM.earth2,
                  width: 28.w,
                  height: 28.w,
                ),
              },
              Text(title, style: context.bodyLarge.copyWith(height: 1.1)),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            spacing: 8.w,
            children: [
              Text(
                Translation.days.trNamed({'days': "7"}),
                style: context.bodyLarge.copyWith(
                  height: 1.1,
                  fontWeight: FontWeightM.medium,
                  color: context.colorScheme.surface,
                ),
              ),
              Row(
                children: [
                  Text(
                    gb == null
                        ? Translation.unlimited.tr
                        : Translation.gb.trNamed({'gb': "10"}),
                    style: context.labelMedium.copyWith(
                      height: 1.1,
                      color: context.colorScheme.surface.withValues(alpha: .7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget switchPlan() {
    return CustomInkButton(
      onTap: () {
        ChooseAnotherPlanBottomSheet.show(context);
      },
      padding: EdgeInsets.symmetric(vertical: 10.w),
      borderRadius: 8.r,
      backgroundColor: context.isDark
          ? ColorM.primaryDark
          : context.colorScheme.surface.withValues(alpha: .1),
      child: Row(
        spacing: 12.w,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Translation.choose_another_plan.tr, style: context.bodyMedium),
          SvgPicture.asset(
            SvgM.arrowSwapHorizontal,
            width: 16.w,
            height: 16.h,
            colorFilter: ColorFilter.mode(
              context.colorScheme.surface.withValues(alpha: .7),
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentMethods() {
    return ValueListenableBuilder(
      valueListenable: paymentMethod,
      builder: (context, value, child) {
        return Column(
          spacing: 13.w,
          children: [
            PaymentMethodItem(
              image: ImagesM.visa,
              isSelected: value.isVisa,
              onChange: (value) {
                paymentMethod.value = PaymentMethod.visa;
              },
            ),
            PaymentMethodItem(
              image: ImagesM.mastercard,
              isSelected: value.isMastercard,
              onChange: (value) {
                paymentMethod.value = PaymentMethod.mastercard;
              },
            ),
            PaymentMethodItem(
              image: ImagesM.wallet,
              isSelected: value.isWallet,
              label: Translation.use_your_wallet.tr,
              onChange: (value) {
                paymentMethod.value = PaymentMethod.wallet;
              },
            ),
          ],
        );
      },
    );
  }

  Widget promoCode() {
    return ValueListenableBuilder(
      valueListenable: paymentMethod,
      builder: (context, value, child) {
        return AnimatedVisibility(
          visible: !value.isWallet,
          enter:
              fadeIn(curve: Curves.fastEaseInToSlowEaseOut) +
              expandVertically(curve: Curves.fastEaseInToSlowEaseOut),
          exit:
              fadeOut(curve: Curves.fastEaseInToSlowEaseOut) +
              shrinkVertically(curve: Curves.fastEaseInToSlowEaseOut),
          enterDuration: Duration(milliseconds: 300),
          exitDuration: Duration(milliseconds: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Translation.promo_code.tr, style: context.bodySmall),
              10.verticalSpace,
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    child: SimpleForm(
                      height: 52.w,
                      hintText: Translation.enter_code.tr,
                      keyboardType: TextInputType.text,
                      controller: promoCodeController,
                    ),
                  ),
                  CustomInkButton(
                    onTap: () {},
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    gradient: LinearGradient(
                      colors: [ColorM.primary, ColorM.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: SizeM.commonBorderRadius.r,
                    height: 52.w,
                    alignment: Alignment.center,
                    child: Text(
                      Translation.apply.tr,
                      style: context.labelLarge.copyWith(
                        fontWeight: FontWeightM.semiBold,
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget paymentSummary() {
    return SmoothContainer(
      width: double.infinity,
      smoothness: 1,
      borderRadius: BorderRadius.circular(12.r),
      padding: EdgeInsets.all(10.w),
      color: context.isDark ? ColorM.primaryDark : Color(0xFFFAFAFA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 8.w,
        children: [
          Text(
            Translation.payment_summary.tr,
            style: context.bodySmall.copyWith(
              fontWeight: FontWeightM.light,
              color: context.colorScheme.surface.withValues(alpha: .7),
            ),
          ),
          PaymentSummaryItem(
            title: Translation.subtotal.tr,
            value: Translation.sar.trNamed({'sar': '80'}),
            gredientText: false,
          ),
          PaymentSummaryItem(
            title: Translation.taxs.tr,
            value: Translation.sar.trNamed({'sar': '10'}),
            gredientText: false,
          ),
          PaymentSummaryItem(
            title: Translation.total.tr,
            value: Translation.sar.trNamed({'sar': '90'}),
            gredientText: true,
          ),
        ],
      ),
    );
  }

  Widget checkBoxs() {
    return Column(
      spacing: 12.w,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckBoxItem(
          titlePartOne: Translation.by_completing_the_order_you_agree_to_our.tr,
          titlePartTwo: Translation.terms_and_conditions.tr,
          value: checkTermsAndConditions,
          onChange: (value) {
            checkTermsAndConditions.value = value;
          },
        ),
        CheckBoxItem(
          titlePartOne: Translation.my_device_supports_esim.tr,
          titlePartTwo: Translation.check_device_compatibility.tr,
          underlinePartTwo: true,
          value: devicesSupportEsim,
          onTapPartTwo: () {
            // todo: nav to page
          },
          onChange: (value) {
            devicesSupportEsim.value = value;
          },
        ),
      ],
    );
  }
}

class PaymentSummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final bool gredientText;
  const PaymentSummaryItem({
    super.key,
    required this.title,
    required this.value,
    this.gredientText = false,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.bodySmall.copyWith(
            color: context.colorScheme.surface.withValues(alpha: .7),
          ),
        ).mask(!gredientText),
        Text(
          value,
          style: context.bodySmall.copyWith(color: context.colorScheme.surface),
        ).mask(!gredientText),
      ],
    );
  }
}

class CheckBoxItem extends StatelessWidget {
  final String titlePartOne;
  final String titlePartTwo;
  final ValueNotifier<bool> value;
  final VoidCallback? onTapPartTwo;
  final bool underlinePartTwo;
  final void Function(bool value) onChange;
  const CheckBoxItem({
    super.key,
    required this.titlePartOne,
    required this.titlePartTwo,
    required this.value,
    required this.onChange,
    this.onTapPartTwo,
    this.underlinePartTwo = false,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: value,
      builder: (context, valueValue, child) {
        return Row(
          spacing: 8.w,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomCheckBox(
              value: valueValue,
              onChange: onChange,
              width: 17.w,
              height: 17.w,
              borderRadius: 4.r,
              checkSize: 11.w,
            ),
            Flexible(
              child: RichText(
                textScaler: MediaQuery.of(context).textScaler,
                text: TextSpan(
                  style: context.bodySmall.copyWith(
                    color: context.colorScheme.surface.withValues(alpha: .7),
                  ),
                  children: [
                    TextSpan(text: titlePartOne),
                    TextSpan(text: " "),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      baseline: TextBaseline.alphabetic,
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [Color(0xFF007AFF), ColorM.secondary],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: onTapPartTwo ?? () {},
                          child: Text(
                            titlePartTwo,
                            style: context.bodySmall.copyWith(
                              color: Colors.white,
                              decoration: underlinePartTwo
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
