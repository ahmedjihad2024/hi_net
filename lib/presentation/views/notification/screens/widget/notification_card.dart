import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/data/responses/responses.dart';
import 'package:hi_net/presentation/common/utils/fast_function.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/common/ui_components/platform_safe_area.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      decoration: BoxDecoration(
        color: isNew
            ? context.colorScheme.surface.withValues(alpha: .03)
            : context.colorScheme.surface.withValues(alpha: .03),
        borderRadius: BorderRadius.circular(SizeM.commonBorderRadius.r),
        border: isNew
            ? Border.all(color: context.colorScheme.primary, width: 1.w)
            : Border.all(
                color: context.colorScheme.surface.withValues(alpha: .03),
                width: 1.w,
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.w,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            alignment: Alignment.center,
            // padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              "Notification icon",
              width: 20.w,
              height: 20.w,
            ),
          ),
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
                      child: Text(
                        title,
                        softWrap: true,
                        style: context.bodyLarge.copyWith(
                          fontWeight: FontWeightM.bold,
                          color: context.colorScheme.primary,
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
                    fontWeight: FontWeightM.regular,
                    color: context.colorScheme.surface.withValues(alpha: 0.5),
                  ),
                ),

                4.verticalSpace,

                // time
                Row(
                  spacing: 5.w,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      timeAgo(createdAt.toLocal(), context.locale),
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
