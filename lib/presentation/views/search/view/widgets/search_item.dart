import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/common/ui_components/gradient_border_side.dart' as gradient_border_side;

class SearchItem extends StatefulWidget {
  final String imageUrl;
  final String countryName;
  final void Function() onTap;
  const SearchItem({
    super.key,
    required this.imageUrl,
    required this.countryName,
    required this.onTap,
  });

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: widget.onTap,
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      borderRadius: 14.r,
      side: gradient_border_side.BorderSide(
        color: context.colorScheme.surface.withValues(alpha: 0.2),
        width: 1.w,
      ),
      child: Row(
        spacing: 14.w,
        children: [
          CustomCachedImage(
            imageUrl: '',
            width: 32.w,
            height: 32.w,
            borderRadius: BorderRadius.circular(6.r),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.w,
            children: [
              Text('Egypt', style: context.labelLarge.copyWith(height: 1.1)),
              Text(
                '27 Plans - from 14 SAR',
                style: context.labelSmall.copyWith(
                  height: 1.1,
                  color: context.colorScheme.surface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 16.w,
            color: context.colorScheme.surface.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}
