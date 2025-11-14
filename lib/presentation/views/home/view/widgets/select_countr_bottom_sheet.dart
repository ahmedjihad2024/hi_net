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

class SelectCountrBottomSheet extends StatefulWidget {
  const SelectCountrBottomSheet({super.key, this.isFromSearch = false});
  final bool isFromSearch;

  @override
  State<SelectCountrBottomSheet> createState() =>
      _SelectCountrBottomSheetState();

  static Future<void> show(
    BuildContext context, {
    bool isFromSearch = false,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => SelectCountrBottomSheet(isFromSearch: isFromSearch),
    );
  }
}

class _SelectCountrBottomSheetState extends State<SelectCountrBottomSheet> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: .75.sh,
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
                color: context.isDark
                    ? ColorM.primaryDark
                    : context.colorScheme.surface.withValues(alpha: 0.05),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translation.select_country.tr,
                    style: context.titleMedium,
                  ),
                  10.verticalSpace,
                  searchField(),
                  13.verticalSpace,
                  countriesList(),
                  13.verticalSpace,
                  nextButton(
                    onTap: () {
                      Navigator.of(context).pop();
                      SelectDurationBottomSheet.show(
                        context,
                        isFromSearch: widget.isFromSearch,
                        isFromSelectCountry: true,
                      );
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

  Widget searchField() {
    return NiceTextForm(
      hintText: Translation.search.tr,
      boxDecoration: ShapeDecoration(
        color: context.colorScheme.onSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99999),
        ),
        shadows: [
          BoxShadow(
            color: ColorM.primary.withValues(alpha: 0.02),
            blurRadius: 0,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      activeBoxDecoration: ShapeDecoration(
        color: context.colorScheme.onSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99999),
        ),
        shadows: [
          BoxShadow(
            color: ColorM.primary.withValues(alpha: 0.02),
            blurRadius: 0,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      textStyle: context.labelLarge.copyWith(
        fontSize: context.labelLarge.fontSize!,
        fontWeight: FontWeightM.light,
      ),
      hintStyle: context.labelLarge.copyWith(
        color: context.labelLarge.color!.withValues(alpha: .8),
        fontSize: context.labelLarge.fontSize!,
        fontWeight: FontWeightM.light,
      ),
      textEditingController: searchController,
      prefixWidget: SvgPicture.asset(
        SvgM.search,
        colorFilter: ColorFilter.mode(
          context.labelLarge.color!.withValues(alpha: .8),
          BlendMode.srcIn,
        ),
        width: 16.w,
        height: 16.w,
      ),
    );
  }

  Widget countriesList() {
    return Expanded(
      child: ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
              (context.isDark ? Colors.black : Colors.transparent),
            ],
            stops: [0, .75, 1],
            tileMode: TileMode.clamp,
          ).createShader(rect);
        },
        child: ListView.separated(
          itemCount: 10,
          padding: EdgeInsets.only(top: 13.h, bottom: 13.h),
          separatorBuilder: (context, index) {
            return 10.verticalSpace;
          },
          itemBuilder: (context, index) {
            return CountryItem(
              imageUrl: '',
              countryName: 'Egypt',
              isSelected: false,
              onChange: (value) {},
            );
          },
        ),
      ),
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
            Translation.next.tr,
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
