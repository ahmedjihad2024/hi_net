import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';

class SearchHistoryItem extends StatelessWidget {
  final String searchQuery;
  final VoidCallback onSelect;
  final VoidCallback onDelete;
  const SearchHistoryItem({
    super.key,
    required this.searchQuery,
    required this.onSelect,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3.w),
      onTap: onSelect,
      backgroundColor: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 16.w,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                SvgM.clock,
                width: 16.w,
                height: 16.w,
                colorFilter: ColorFilter.mode(
                  context.isDark
                      ? Color(0xFFFAFAFA)
                      : context.labelLarge.color!.withValues(alpha: .8),
                  BlendMode.srcIn,
                ),
              ),

              Text(
                searchQuery,
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeightM.light,
                  color: context.isDark
                      ? Color(0xFFFAFAFA)
                      : context.bodyMedium.color!.withValues(alpha: .8),
                ),
              ),
            ],
          ),

          CustomInkButton(
            padding: EdgeInsets.all(3.w),
            onTap: onDelete,
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              SvgM.closeSquare,
              width: 16.w,
              height: 16.w,
              colorFilter: ColorFilter.mode(
                context.isDark
                    ? Color(0xFFF17D7D)
                    : context.bodyMedium.color!.withValues(alpha: .8),
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
