import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/routes_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/home/view/widgets/half_circle_progress.dart';
import 'package:hi_net/presentation/views/my_esim_details/view/widgets/plan_item.dart';
import 'package:smooth_corner/smooth_corner.dart';

class MyEsimDetailsView extends StatefulWidget {
  const MyEsimDetailsView({super.key});

  @override
  State<MyEsimDetailsView> createState() => _MyEsimDetailsViewState();
}

class _MyEsimDetailsViewState extends State<MyEsimDetailsView> {
  ValueNotifier<int> selectedPlanIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDark ? ColorM.primaryDark : Color(0xFFF8F8F8),
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
                    Text(Translation.esim_details.tr, style: context.bodyLarge),
                  ],
                ),
              ),
              Text("⚠️", style: context.bodyLarge.copyWith(fontSize: 20.sp)),
            ],
          ).animatedOnAppear(5, SlideDirection.down),
          24.verticalSpace,
          usage().animatedOnAppear(4, SlideDirection.down),
          24.verticalSpace,
          esimInfo(),
          24.verticalSpace,
          Expanded(
            child: Container(
              color: context.colorScheme.onSurface,
              child: Column(
                children: [
                  viewInstructionsButton(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(RoutesManager.instructions.route);
                    },
                  ).animatedOnAppear(1, SlideDirection.up),
                  Container(
                    height: 1.w,
                    color: context.colorScheme.surface.withValues(alpha: 0.1),
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeM.pagePadding.dg,
                    ),
                  ).animatedOnAppear(2, SlideDirection.up),
                  10.verticalSpace,
                  currentProvider().animatedOnAppear(3, SlideDirection.up),
                  Container(
                    height: 1.w,
                    color: context.colorScheme.surface.withValues(alpha: 0.1),
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeM.pagePadding.dg,
                    ),
                  ),
                  38.verticalSpace,
                  buyTopUp().animatedOnAppear(4, SlideDirection.up),
                  const Spacer(),
                  checkoutButton().animatedOnAppear(6, SlideDirection.up),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 16.w,
                  ),
                ],
              ),
            ).animatedOnAppear(0, SlideDirection.up),
          ),
        ],
      ),
    );
  }

  Widget usage() {
    return HalfCircleProgress(
      delay: Duration(milliseconds: 700),
      size: 210.w,
      progress: .7,
      strokeWidth: 18,
      progressGradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.2, .6],
        colors: [ColorM.primary, ColorM.secondary],
      ),
      backgroundColor: ColorM.primary.withValues(alpha: 0.17),
      animationDuration: Duration(milliseconds: 600),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.w,
        children: [
          SizedBox(
            width: 140.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [ColorM.primary, ColorM.secondary],
                  ).createShader(bounds);
                },
                child: Text(
                  Translation.gb.trNamed({'gb': '5.6'}),
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeightM.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 140.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                Translation.lefts_of.trNamed({'lefts': '12'}),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: context.colorScheme.surface,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget esimInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      alignment: Alignment.center,
      height: 85.h,
      decoration: ShapeDecoration(
        color: context.colorScheme.onSurface,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(18.r),
          side: BorderSide(
            color: context.isDark ? Color(0xFF171717) : Color(0xFFE0E1E3),
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        spacing: 10.w,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            spacing: 13.w,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // simcard and country name
              Row(
                spacing: 6.w,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [ColorM.primary, ColorM.secondary],
                        stops: [0.2, .6],
                      ).createShader(bounds);
                    },
                    child: SvgPicture.asset(
                      SvgM.simcard,
                      width: 22.w,
                      height: 22.w,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Text(
                    'France',
                    style: context.bodyLarge.copyWith(height: 1.2),
                  ),
                ],
              ).animatedOnAppear(2, SlideDirection.down),

              // day active usage
              Row(
                spacing: 4.w,
                children: [
                  SvgPicture.asset(
                    SvgM.activeCircle,
                    width: 12.w,
                    height: 12.w,
                  ),
                  Text(
                    Translation.active.tr,
                    style: context.bodySmall.copyWith(
                      height: 1.2,
                      color: context.bodySmall.color!.withValues(alpha: 0.5),
                      fontWeight: FontWeightM.light,
                    ),
                  ),
                  Container(
                    width: 15.w,
                    height: .7.w,
                    color: context.colorScheme.surface.withValues(alpha: 0.5),
                  ),
                  Text(
                    Translation.days_left.trNamed({'days': '5'}),
                    style: context.bodySmall.copyWith(
                      height: 1.2,
                      color: context.bodySmall.color!.withValues(alpha: 0.5),
                      fontWeight: FontWeightM.light,
                    ),
                  ),
                ],
              ).animatedOnAppear(1, SlideDirection.down),
            ],
          ),

          Container(
            width: 57.w,
            height: 57.w,
            padding: EdgeInsets.all(16.w),
            decoration: ShapeDecoration(
              color: context.isDark ? ColorM.primaryDark : ColorM.gray,
              shape: SmoothRectangleBorder(
                smoothness: 1,
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: CustomCachedImage(
              imageUrl: '',
              width: 24.w,
              height: 24.w,
              borderRadius: BorderRadius.circular(7.r),
            ),
          ).animatedOnAppear(3, SlideDirection.down),
        ],
      ),
    ).animatedOnAppear(0, SlideDirection.down);
  }

  Widget viewInstructionsButton({required VoidCallback onTap}) {
    return CustomInkButton(
      onTap: onTap,
      borderRadius: 0,
      padding: EdgeInsets.symmetric(
        horizontal: SizeM.pagePadding.dg,
        vertical: 16.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 12.w,
            children: [
              SvgPicture.asset(
                SvgM.import,
                width: 24.w,
                height: 24.w,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.surface,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                Translation.view_instructions.tr,
                style: context.bodyLarge.copyWith(height: 1.2),
              ),
            ],
          ),

          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16.w,
            color: context.colorScheme.surface,
          ),
        ],
      ),
    );
  }

  Widget currentProvider() {
    return CustomInkButton(
      borderRadius: 0,
      padding: EdgeInsets.symmetric(
        horizontal: SizeM.pagePadding.dg,
        vertical: 16.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 12.w,
            children: [
              SvgPicture.asset(
                SvgM.radar,
                width: 24.w,
                height: 24.w,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.surface,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                Translation.current_provider.tr,
                style: context.bodyLarge.copyWith(height: 1.2),
              ),
            ],
          ),

          Text(
            'Vodafone',
            style: context.bodySmall.copyWith(
              height: 1.2,
              color: context.isDark
                  ? Colors.white
                  : Colors.black.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget buyTopUp() {
    return Column(
      spacing: 18.w,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
          child: Row(
            spacing: 12.w,
            children: [
              Icon(Icons.add, size: 24.w, color: context.colorScheme.surface),
              Text(
                Translation.buy_top_up.tr,
                style: context.bodyLarge.copyWith(height: 1.2),
              ),
            ],
          ),
        ),

        // top up options
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
          child: ValueListenableBuilder(
            valueListenable: selectedPlanIndex,
            builder: (context, selectedValue, child) {
              return Row(
                spacing: 18.w,
                children: [
                  for (var i = 0; i < 4; i++)
                    PlanItem(
                      days: i + 1,
                      price: (i + 1) * 10,
                      gb: i == 0 ? null : (i + 1) * 20,
                      isSelected: selectedValue == i,
                      isRecommended: i == 0,
                      onChange: (value) {
                        selectedPlanIndex.value = i;
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget checkoutButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
      child: CustomInkButton(
        onTap: () {
          Navigator.pushNamed(context, RoutesManager.checkout.route);
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
                SvgPicture.asset(SvgM.doubleArrow2, width: 12.w, height: 12.h),
                Text(
                  Translation.checkout.tr,
                  style: context.labelLarge.copyWith(
                    fontWeight: FontWeightM.semiBold,
                    height: 1,
                    color: Colors.white,
                  ),
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
    );
  }
}
