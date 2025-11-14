import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/instructions/view/widgets/installation_way_bottom_sheet.dart';
import 'package:smooth_corner/smooth_corner.dart';

class TapDirectView extends StatefulWidget {
  const TapDirectView({super.key});

  @override
  State<TapDirectView> createState() => _TapDirectViewState();
}

class _TapDirectViewState extends State<TapDirectView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        24.verticalSpace,
        Container(
          padding: EdgeInsets.all(14.w),
          margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0A0A67), Color(0xFF62629A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: SmoothRectangleBorder(
              smoothness: 1,
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          child: Row(
            spacing: 22.w,
            children: [
              Image.asset(ImagesM.checkGradiant, width: 50.w, height: 50.w),
              Flexible(
                child: Text(
                  Translation.your_esim_is_now_installed_and_ready_for_use.tr,
                  style: context.bodySmall.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        
        24.verticalSpace,
        
        // Step 01 Section
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step 01 Heading with Gradient
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [ColorM.primary, ColorM.secondary],
                  ).createShader(bounds);
                },
                child: Text(
                  Translation.step_01.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeightM.regular,
                    color: Colors.white,
                    height: 1.2,
                    fontFamily: FontsM.Lexend.name,
                  ),
                ),
              ),
              14.verticalSpace,
        
              // Note Box
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: ShapeDecoration(
                  color: context.isDark
                      ? Color(0xFF171717)
                      : Color(0xFFFAFAFA),
                  shape: SmoothRectangleBorder(
                    smoothness: 1,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.w,
                  children: [
                    SvgPicture.asset(
                      SvgM.danger,
                      width: 12.w,
                      height: 12.w,
                      colorFilter: ColorFilter.mode(
                        context.isDark ? Color(0xFFB1B1BA) : ColorM.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    Expanded(
                      child: context.isDark
                          ? Text(
                              Translation.note_esim_installation_warning.tr,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeightM.light,
                                color: Color(0xFFB1B1BA),
                                height: 1.2,
                                fontFamily: FontsM.Lexend.name,
                              ),
                            )
                          : ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [ColorM.primary, ColorM.secondary],
                                ).createShader(bounds);
                              },
                              child: Text(
                                Translation.note_esim_installation_warning.tr,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeightM.light,
                                  color: Colors.white,
                                  height: 1.2,
                                  fontFamily: FontsM.Lexend.name,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
        
              // Numbered Instructions List
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInstructionItem(
                    context,
                    1,
                    Translation.direct_step_1.tr,
                  ),
                  12.verticalSpace,
                  _buildInstructionItem(
                    context,
                    2,
                    Translation.direct_step_2.tr,
                  ),
                  12.verticalSpace,
                  _buildInstructionItem(
                    context,
                    3,
                    Translation.direct_step_3.tr,
                  ),
                  12.verticalSpace,
                  _buildInstructionItem(
                    context,
                    4,
                    Translation.direct_step_4.tr,
                  ),
                  12.verticalSpace,
                  _buildInstructionItem(
                    context,
                    5,
                    Translation.direct_step_5.tr,
                  ),
                ],
              ),
            ],
          ),
        ),
        
        24.verticalSpace,
        
        const Spacer(),
        
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg) +
              EdgeInsets.only(
                bottom: 16.w + MediaQuery.of(context).padding.bottom,
                top: 16.w,
              ),
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              smoothness: 1,
              borderRadius: BorderRadius.circular(14.r),
              side: BorderSide(
                color: context.isDark ? Color(0xFF171717) : Color(0xFFE0E1E3),
                width: 1.w,
              ),
            ),
          ),
          child: Row(
            spacing: 12.w,
            children: [
              Expanded(
                child: CustomInkButton(
                  onTap: () {},
                  gradient: LinearGradient(
                    colors: [ColorM.primary, ColorM.secondary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: SizeM.commonBorderRadius.r,
                  height: 54.h,
                  alignment: Alignment.center,
                  child: Row(
                    spacing: 7.w,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Translation.install_now.tr,
                        style: context.labelLarge.copyWith(
                          fontWeight: FontWeightM.medium,
                          height: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        
              Expanded(
                child: CustomInkButton(
                  onTap: () {
                    InstallationWayBottomSheet.show(context);
                  },
                  backgroundColor: context.isDark
                      ? ColorM.primaryDark
                      : ColorM.gray,
                  borderRadius: SizeM.commonBorderRadius.r,
                  height: 54.h,
                  alignment: Alignment.center,
                  child: Row(
                    spacing: 7.w,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Translation.installation_way.tr,
                        style: context.labelLarge.copyWith(
                          fontWeight: FontWeightM.medium,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionItem(BuildContext context, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number. ',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeightM.light,
            color: context.isDark
                ? Colors.white.withValues(alpha: 0.9)
                : Color(0xFF111113).withValues(alpha: 0.9),
            height: 1.2,
            fontFamily: FontsM.Lexend.name,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeightM.light,
              color: context.isDark
                  ? Colors.white.withValues(alpha: 0.9)
                  : Color(0xFF111113).withValues(alpha: 0.9),
              height: 1.2,
              fontFamily: FontsM.Lexend.name,
            ),
          ),
        ),
      ],
    );
  }
}
