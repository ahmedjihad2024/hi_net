import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/gradient_border_side.dart'
    as gradient_border;
import 'package:hi_net/presentation/common/utils/fast_function.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.isNew,
    required this.title,
    required this.message,
    required this.createdAt,
  });

  final bool isNew;
  final String title;
  final String message;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 14.w),
      decoration: ShapeDecoration(
        shape: gradient_border.SmoothRectangleBorder(
          borderRadius: BorderRadius.circular(SizeM.commonBorderRadius.r),
          smoothness: 1,
          side: gradient_border.BorderSide(
            gradient: LinearGradient(
              colors: [ColorM.primary, ColorM.secondary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            width: 1.w,
          ),
        ),
        color: isNew
            ? context.isDark
                  ? ColorM.primaryDark
                  : Color(0xFFFAFAFA)
            : Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6.w,
        children: [
          Image.asset(ImagesM.bell, width: 43.w, height: 43.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Row(
                  spacing: 5.w,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: context.isDark
                                ? [Colors.white, Colors.white]
                                : [ColorM.primary, ColorM.secondary],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          title,
                          softWrap: true,
                          style: context.bodyLarge.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    if (isNew)
                      Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                2.verticalSpace,
                // description
                Text(
                  message,
                  softWrap: true,
                  style: context.labelMedium.copyWith(
                    fontWeight: FontWeightM.light,
                    color: context.colorScheme.surface.withValues(alpha: 0.8),
                  ),
                ),

                4.verticalSpace,

                // time
                Row(
                  spacing: 5.w,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Today, 10:30 AM",
                      // timeAgo(createdAt.toLocal(), context.locale),
                      style: context.labelMedium.copyWith(
                        fontWeight: FontWeightM.regular,
                        color: context.colorScheme.surface.withValues(
                          alpha: 0.35,
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
    );
  }
}
