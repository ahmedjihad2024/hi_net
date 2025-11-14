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
import 'package:hi_net/presentation/views/esim_details/view/widgets/plan_item.dart';
import 'package:hi_net/presentation/views/home/view/widgets/country_item.dart';
import 'package:hi_net/presentation/views/home/view/widgets/select_duration_bottom_sheet.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ChooseAnotherPlanBottomSheet extends StatefulWidget {
  const ChooseAnotherPlanBottomSheet({super.key});

  @override
  State<ChooseAnotherPlanBottomSheet> createState() =>
      _ChooseAnotherPlanBottomSheetState();

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => ChooseAnotherPlanBottomSheet(),
    );
  }
}

class _ChooseAnotherPlanBottomSheetState
    extends State<ChooseAnotherPlanBottomSheet> {
  TextEditingController searchController = TextEditingController();
  ValueNotifier<int> selectedPlanIndex = ValueNotifier(-1);
  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisSize: MainAxisSize.min,
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
          Flexible(
            child: Container(
              width: double.infinity,
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
                color: context.isDark
                    ? ColorM.primaryDark
                    : context.colorScheme.surface.withValues(alpha: 0.05),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  title(),
                  13.verticalSpace,
                  planItems(),
                  13.verticalSpace,
                  nextButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget title() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Translation.choose_another_plan.tr, style: context.bodyLarge),
      ],
    );
  }

  Widget planItems() {
    return ValueListenableBuilder(
      valueListenable: selectedPlanIndex,
      builder: (context, value, child) {
        return Flexible(
          child: SingleChildScrollView(
            child: Column(
              spacing: 14.w,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < 4; i++)
                  PlanItem(
                    isRecommended: i == 0,
                    days: i + 3,
                    price: (i + 3) * 100,
                    isSelected: value == i,
                    gb: i == 2 ? null : (i + 3) * 10,
                    onChange: (value) {
                      selectedPlanIndex.value = i;
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget nextButton({required VoidCallback onTap}) {
    return CustomInkButton(
      onTap: onTap,
      gradient: LinearGradient(
        colors: [ColorM.primary, ColorM.secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: SizeM.commonBorderRadius.r,
      height: 48.h,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 7.w,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Translation.confirm.tr,
            style: context.labelLarge.copyWith(
              fontWeight: FontWeightM.semiBold,
              height: 1,
              color: Colors.white,
            ),
          ),
          RotatedBox(
            quarterTurns: Directionality.of(context) == TextDirection.rtl
                ? 2
                : 0,
            child: SvgPicture.asset(
              SvgM.doubleArrow2,
              width: 12.w,
              height: 12.w,
            ),
          ),
        ],
      ),
    );
  }
}
