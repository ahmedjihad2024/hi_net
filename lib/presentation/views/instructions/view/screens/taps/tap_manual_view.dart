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

class TapManualView extends StatefulWidget {
  const TapManualView({super.key});

  @override
  State<TapManualView> createState() => _TapManualViewState();
}

class _TapManualViewState extends State<TapManualView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          24.verticalSpace,
      
          // Step 01 Section
          Expanded(
            child: SingleChildScrollView(
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
                        
                        fontFamily: FontsM.Lexend.name,
                      ),
                    ),
                  ),
                  24.verticalSpace,
            
                  // Warning Box
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: ShapeDecoration(
                      color: context.isDark ? Color(0xFF171717) : Colors.white,
                      shape: SmoothRectangleBorder(
                        smoothness: 1,
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(
                          color: context.isDark
                              ? Color(0xFF000000)
                              : Color(0xFFE0E1E3),
                          width: 1.w,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Translation.manual_warning_message.tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeightM.light,
                            color: context.isDark
                                ? Color(0xFFB1B1BA)
                                : Color(0xFF646575),
                            
                            fontFamily: FontsM.Lexend.name,
                          ),
                        ),
                        10.verticalSpace,
            
                        // SM-DP+ Address & Activation Code Box
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: ShapeDecoration(
                            color: context.isDark
                                ? Color(0xFF000000)
                                : Color(0xFFFAFAFA),
                            shape: SmoothRectangleBorder(
                              smoothness: 1,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Translation.smdp_address_activation_code.tr,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeightM.light,
                                  color: context.isDark
                                      ? Color(0xFFB1B1BA).withValues(alpha: 0.9)
                                      : Color(0xFFA4A4A4).withValues(alpha: 0.9),
                                  fontFamily: FontsM.Lexend.name,
                                ),
                              ),
                              8.verticalSpace,
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'rpa01.stomconsumer.rsp.global:STN2030614121   L3942EE6066',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeightM.light,
                                        color: context.isDark
                                            ? Colors.white.withValues(alpha: 0.9)
                                            : Color(0xFF111113)
                                                .withValues(alpha: 0.9),
                                        fontFamily: FontsM.Lexend.name,
                                      ),
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  // Copy Button
                                  CustomInkButton(
                                    onTap: () {
                                      // Handle copy action
                                    },
                                    backgroundColor: context.isDark
                                        ? Color(0xFF171717)
                                        : Colors.white,
                                    borderRadius: 8.r,
                                    padding: EdgeInsets.all(10.w),
                                    child: SvgPicture.asset(
                                      SvgM.copy,
                                      width: 24.w,
                                      height: 24.w,
                                      colorFilter: ColorFilter.mode(
                                        context.isDark
                                            ? Colors.white
                                            : ColorM.primary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  24.verticalSpace,
            
                  // Instructions List
                  _buildInstructionsList(context),
                ],
              ),
            ),
          ),
      
      
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
          child: CustomInkButton(
            onTap: () {
              InstallationWayBottomSheet.show(context);
            },
            backgroundColor: context.isDark ? ColorM.primaryDark : ColorM.gray,
            borderRadius: SizeM.commonBorderRadius.r,
            height: 54.h,
            alignment: Alignment.center,
            width: double.infinity,
            child: Row(
              spacing: 7.w,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Translation.installation_way.tr,
                  style: context.labelLarge.copyWith(
                    fontWeight: FontWeightM.medium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildInstructionsList(BuildContext context) {
    final textColor = context.isDark
        ? Colors.white.withValues(alpha: 0.9)
        : Color(0xFF111113).withValues(alpha: 0.9);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInstructionItemWithThreeGradients(
          context,
          1,
          Translation.go_to.tr,
          [Translation.settings.tr],
          Translation.comma_tap.tr,
          [Translation.connections.tr],
          Translation.comma_then_tap.tr,
          [Translation.sim_card_manager.tr],
          Translation.on_your_device.tr,
          textColor,
        ),
        12.verticalSpace,
        _buildInstructionItem(
          context,
          2,
          Translation.tap.tr,
          [Translation.add_mobile_plan.tr],
          Translation.comma_then_tap.tr,
          [Translation.scan_carrier_qr_code.tr],
          Translation.period.tr,
          textColor,
        ),
        12.verticalSpace,
        _buildInstructionItem(
          context,
          3,
          Translation.tap.tr,
          [Translation.enter_activation_code.tr],
          '',
          [],
          Translation.period.tr,
          textColor,
        ),
        12.verticalSpace,
        _buildInstructionItem(
          context,
          4,
          Translation.manual_step_4_part1.tr,
          [Translation.connect.tr],
          Translation.comma_then_tap.tr,
          [Translation.confirm_action.tr],
          Translation.period.tr,
          textColor,
        ),
      ],
    );
  }

  Widget _buildInstructionItem(
    BuildContext context,
    int number,
    String textBefore1,
    List<String> gradientText1,
    String textBetween,
    List<String> gradientText2,
    String textAfter,
    Color textColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number. ',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeightM.light,
            color: textColor,
            
            fontFamily: FontsM.Lexend.name,
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeightM.light,
                color: textColor,
                
                fontFamily: FontsM.Lexend.name,
              ),
              children: [
                TextSpan(text: textBefore1),
                ...gradientText1.map((text) => _buildGradientTextSpan(text)),
                if (textBetween.isNotEmpty) TextSpan(text: textBetween),
                ...gradientText2.map((text) => _buildGradientTextSpan(text)),
                if (textAfter.isNotEmpty) TextSpan(text: textAfter),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionItemWithThreeGradients(
    BuildContext context,
    int number,
    String textBefore1,
    List<String> gradientText1,
    String textBetween1,
    List<String> gradientText2,
    String textBetween2,
    List<String> gradientText3,
    String textAfter,
    Color textColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number. ',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeightM.light,
            color: textColor,
            
            fontFamily: FontsM.Lexend.name,
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeightM.light,
                color: textColor,
                
                fontFamily: FontsM.Lexend.name,
              ),
              children: [
                TextSpan(text: textBefore1),
                ...gradientText1.map((text) => _buildGradientTextSpan(text)),
                if (textBetween1.isNotEmpty) TextSpan(text: textBetween1),
                ...gradientText2.map((text) => _buildGradientTextSpan(text)),
                if (textBetween2.isNotEmpty) TextSpan(text: textBetween2),
                ...gradientText3.map((text) => _buildGradientTextSpan(text)),
                if (textAfter.isNotEmpty) TextSpan(text: textAfter),
              ],
            ),
          ),
        ),
      ],
    );
  }

  InlineSpan _buildGradientTextSpan(String text) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [ColorM.primary, ColorM.secondary],
          ).createShader(bounds);
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeightM.medium,
            color: Colors.white,
            
            fontFamily: FontsM.Lexend.name,
          ),
        ),
      ),
    );
  }
}
