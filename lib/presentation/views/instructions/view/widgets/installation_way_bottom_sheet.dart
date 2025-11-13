import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_form_field/custom_form_field.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/home/view/widgets/country_item.dart';
import 'package:hi_net/presentation/views/home/view/widgets/select_duration_bottom_sheet.dart';
import 'package:smooth_corner/smooth_corner.dart';

class InstallationWayBottomSheet extends StatefulWidget {
  const InstallationWayBottomSheet({super.key});

  @override
  State<InstallationWayBottomSheet> createState() =>
      _InstallationWayBottomSheetState();

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => InstallationWayBottomSheet(),
    );
  }
}

class _InstallationWayBottomSheetState extends State<InstallationWayBottomSheet> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: .5.sh,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 20.w,
        left: 16.w,
        right: 16.w,
        bottom: 27.w,
      ),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        ),
        color: context.colorScheme.onSurface,
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 5.w,
            decoration: BoxDecoration(
              color: context.colorScheme.surface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(100000),
            ),
          ),
          16.verticalSpace,
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.only(
                top: 12.w,
                bottom: 8.w,
                left: 12.w,
                right: 12.w,
              ),
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                color: context.isDark ? ColorM.primaryDark : context.colorScheme.surface.withValues(alpha: 0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
