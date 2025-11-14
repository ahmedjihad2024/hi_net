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
import 'package:smooth_corner/smooth_corner.dart';

class TapQrCodeView extends StatefulWidget {
  const TapQrCodeView({super.key});

  @override
  State<TapQrCodeView> createState() => _TapQrCodeViewState();
}

class _TapQrCodeViewState extends State<TapQrCodeView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          24.verticalSpace,
      
          // Warning Box
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
            child: Container(
              padding: EdgeInsets.all(14.w),
              decoration: ShapeDecoration(
                color: context.isDark ? Color(0xFF171717) : Color(0xFFFAFAFA),
                shape: SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 22.w,
                children: [
                  Text(
                    '⚠️',
                    style: TextStyle(
                      fontSize: 38.571.sp,
                      color: Color(0xFF646575),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      Translation.qr_warning_message.tr,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeightM.regular,
                        color: context.isDark
                            ? Colors.white.withValues(alpha: 0.9)
                            : Color(0xFF111113).withValues(alpha: 0.9),
                        
                        fontFamily: FontsM.Lexend.name,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      
          24.verticalSpace,
      
          // QR Code Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
            child: Column(
              children: [
                // QR Code Image
                CustomCachedImage(
                  imageUrl: '',
                  width: 193.w,
                  height: 183.w,
                  fit: BoxFit.contain,
                  borderRadius: BorderRadius.circular(14.r),
                ),
      
                16.verticalSpace,
      
                // Share QR Code Button
                CustomInkButton(
                  onTap: () {
                    // Handle share action
                  },
                  backgroundColor: context.isDark
                      ? Color(0xFF171717)
                      : Color(0xFFFAFAFA),
                  borderRadius: 8.r,
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10.w,
                    children: [
                      SvgPicture.asset(
                        SvgM.share,
                        width: 24.w,
                        height: 24.w,
                        colorFilter: ColorFilter.mode(
                          context.isDark
                              ? Color(0xFFB1B1BA)
                              : Color(0xFF9810FA),
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        Translation.share_qr_code.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeightM.regular,
                          color: context.isDark
                              ? Color(0xFFB1B1BA)
                              : Color(0xFF9810FA),
                          height: 1.43,
                          fontFamily: FontsM.Lexend.name,
                        ),
                      ),
                    ],
                  ),
                ),
      
                16.verticalSpace,
      
                // Description Text
                Text(
                  Translation.qr_scan_description.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeightM.light,
                    color: context.isDark
                        ? Color(0xFFB1B1BA)
                        : Color(0xFF646575),
                    
                    fontFamily: FontsM.Lexend.name,
                  ),
                ),
      
                16.verticalSpace,
      
                // Divider
                Container(
                  height: 1.w,
                  color: context.isDark
                      ? Color(0xFF171717)
                      : Color(0xFFE0E1E3),
                ),
      
                16.verticalSpace,
      
                // Instructions List
                _buildInstructionsList(context),
              ],
            ),
          ),

      
          SizedBox(height: 16.w + MediaQuery.of(context).padding.bottom),
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
        _buildInstructionItem(
          context,
          1,
          Translation.qr_step_1.tr,
          [Translation.connections.tr],
          Translation.comma_then_tap.tr,
          [Translation.sim_card_manager.tr],
          Translation.on_your_device.tr,
          textColor,
        ),
        16.verticalSpace,
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
        16.verticalSpace,
        _buildInstructionItem(
          context,
          3,
          Translation.qr_step_2.tr,
          [Translation.confirm_action.tr],
          '',
          [],
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
            fontSize: 14.sp,
            fontWeight: FontWeightM.regular,
            color: textColor,
            
            fontFamily: FontsM.Lexend.name,
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeightM.regular,
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
            fontSize: 14.sp,
            fontWeight: FontWeightM.medium,
            color: Colors.white,
            
            fontFamily: FontsM.Lexend.name,
          ),
        ),
      ),
    );
  }
}
