import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/esim_details/view/screens/esim_details_view.dart';
import 'package:hi_net/presentation/views/home/view/widgets/half_circle_progress.dart';
import 'package:hi_net/presentation/common/ui_components/gradient_border_side.dart'
    as gradient_border_side;
import 'package:smooth_corner/smooth_corner.dart';

class EsimsItem extends StatelessWidget {
  final bool isActive;
  final Function() onSeeDetails;
  final Function() onRenew;
  final Function() onActivationWay;
  const EsimsItem({
    super.key,
    required this.isActive,
    required this.onSeeDetails,
    required this.onRenew,
    required this.onActivationWay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: ShapeDecoration(
        color: context.colorScheme.secondary,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(14.r),
          side: BorderSide(
            color: context.isDark ? Color(0xFF171717): Color(0xFFF0F0F0),
            width: 1.w,
          )
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 18.w,
        children: [
          // first row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  CustomCachedImage(
                    imageUrl: '',
                    width: 28.w,
                    height: 28.w,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  Text("Egypt", style: context.bodyLarge.copyWith()),
                ],
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.w),
                decoration: BoxDecoration(
                  color: context.isDark ? Colors.black : ColorM.gray,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4.w,
                  children: [
                    SvgPicture.asset(
                      isActive ? SvgM.activeCircle : SvgM.danger,
                      width: 12.w,
                      height: 12.w,
                    ),
                    Text(
                      isActive
                          ? Translation.active.tr
                          : Translation.un_active.tr,
                      style: context.labelMedium.copyWith(
                        fontWeight: FontWeightM.light,
                        color: isActive
                            ? const Color(0xFF4EBF0C)
                            : const Color(0xFFFB2727),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // second row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HalfCircleProgress(
                size: 164.w,
                progress: .7,
                strokeWidth: 15,
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
                      width: 110.w,
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
                              fontSize: 22.sp,
                              fontWeight: FontWeightM.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 110.w,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          Translation.lefts_of.trNamed({'lefts': '12'}),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // third row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlansInfoItem(
                title: Translation.price.tr,
                value: Translation.sar.trNamed({"sar": "100"}),
                crossAxisAlignment: CrossAxisAlignment.start,
              ),

              Container(
                width: 1.w,
                height: 25.w,
                color: context.colorScheme.surface.withValues(alpha: .5),
              ),

              PlansInfoItem(
                title: Translation.duration.tr,
                value: Translation.days.trNamed({"days": "30"}),
                crossAxisAlignment: CrossAxisAlignment.start,
              ),

              Container(
                width: 1.w,
                height: 25.w,
                color: context.colorScheme.surface.withValues(alpha: .5),
              ),

              PlansInfoItem(
                title: Translation.iccid.tr,
                value: "94499489494894efef",
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ],
          ),

          // fourth row
          Row(
            spacing: 12.w,
            children: [
              // see esim details button
              Expanded(
                child: CustomInkButton(
                  onTap: onSeeDetails,
                  borderRadius: SizeM.commonBorderRadius.r,
                  height: 42.h,
                  alignment: Alignment.center,
                  backgroundColor: context.isDark ? Colors.black : ColorM.gray,
                  child: Row(
                    spacing: 7.w,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [ColorM.primary, ColorM.secondary],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          Translation.see_details.tr,
                          style: context.labelLarge.copyWith(
                            fontWeight: FontWeightM.regular,
                            height: 1.2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SvgPicture.asset(SvgM.arrowUp, width: 16.w, height: 16.w),
                    ],
                  ),
                ),
              ),

              // review and activation way button
              Expanded(
                child: CustomInkButton(
                  onTap: () {
                    if(isActive) {
                      onRenew();
                    } else {
                      onActivationWay();
                    }
                  },
                  borderRadius: SizeM.commonBorderRadius.r,
                  height: 42.h,
                  alignment: Alignment.center,
                  side: gradient_border_side.BorderSide(
                    gradient: LinearGradient(
                      colors: [ColorM.primary, ColorM.secondary],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Row(
                    spacing: 7.w,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [ColorM.primary, ColorM.secondary],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          isActive ? Translation.renew.tr : Translation.activation_way.tr,
                          style: context.labelLarge.copyWith(
                            fontWeight: FontWeightM.regular,
                            height: 1.2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        SvgM.doubleArrow3,
                        width: 12.w,
                        height: 12.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
