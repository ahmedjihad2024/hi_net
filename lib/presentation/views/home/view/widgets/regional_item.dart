
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';


class RegionalItem extends StatefulWidget {
  final String imageUrl;
  final String countryName;
  final void Function() onTap;
  const RegionalItem({
    super.key,
    required this.imageUrl,
    required this.countryName,
    required this.onTap,
  });

  @override
  State<RegionalItem> createState() => _RegionalItemState();
}

class _RegionalItemState extends State<RegionalItem> {
  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: widget.onTap,
      width: double.infinity,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg.w, vertical: 12.w),
      borderRadius: 0,
      child: Row(
        spacing: 14.w,
        children: [
          SvgPicture.asset(
            SvgM.earth,
            width: 32.w,
            height: 32.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.w,
            children: [
              Text('Egypt', style: context.labelLarge.copyWith(height: 1.1)),
              Text('27 Plans - from 14 SAR', style: context.labelSmall.copyWith(height: 1.1, color: context.colorScheme.surface.withValues(alpha: 0.5))),
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
