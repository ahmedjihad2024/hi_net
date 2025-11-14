import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/esim_details/view/widgets/plan_item.dart';
import 'package:smooth_corner/smooth_corner.dart';

class OrderHistoryItem extends StatelessWidget {
  const OrderHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(14.r),
          side: BorderSide(
            color: context.colorScheme.surface.withValues(alpha: .1),
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 14.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCachedImage(
                imageUrl: '',
                width: 50.w,
                height: 50.w,
                isCircle: true,
              ),
              Column(
                spacing: 4.w,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 2.w,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        SvgM.simcard,
                        width: 18.w,
                        height: 18.w,
                      ).mask(false),
                      Text(
                        'France',
                        style: context.bodyLarge.copyWith(height: 1.2),
                      ),
                    ],
                  ),
                  2.verticalSpace,
                  Row(
                    spacing: 2.w,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        SvgM.calendar,
                        width: 14.w,
                        height: 14.w,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.surface.withValues(alpha: .5),
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        DateFormat(
                          'MMM d, yyyy',
                          context.locale.languageCode,
                        ).format(DateTime.now()),
                        style: context.labelSmall.copyWith(
                          height: 1.2,
                          fontWeight: FontWeightM.light,
                          color: context.colorScheme.surface.withValues(
                            alpha: .5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 2.w,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        ImagesM.mastercard,
                        width: 14.w,
                        height: 14.w,
                      ),
                      Text(
                        "Credit Card",
                        style: context.labelSmall.copyWith(
                          height: 1.2,
                          fontWeight: FontWeightM.light,
                          color: context.colorScheme.surface.withValues(
                            alpha: .5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            spacing: 8.w,
            children: [
              Text(
                Translation.days.trNamed({'days': '100'}),
                style: context.bodyLarge.copyWith(
                  height: 1.1,
                  fontSize: 16.sp,
                  fontWeight: FontWeightM.medium,
                  color: context.colorScheme.surface,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Translation.gb.trNamed({'gb': '100'}),
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
}
