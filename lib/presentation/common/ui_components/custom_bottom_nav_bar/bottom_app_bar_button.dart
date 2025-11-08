import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/flex_text.dart';

import '../../../res/fonts_manager.dart';

class CustomBottomAppBarButton extends StatelessWidget {
  final String selectedSvg;
  final String unselectedSvg;
  final String label;
  final Color selectedColor;
  final Color unselectedColor;
  final bool isSelected;

  // check if this button if in left or right
  // to handle the alignment
  final bool? isLeftButton;
  final Function() onTap;

  const CustomBottomAppBarButton(
      {super.key,
      required this.selectedSvg,
      required this.unselectedSvg,
      required this.label,
      required this.selectedColor,
      required this.unselectedColor,
      required this.onTap,
      required this.isSelected,
      this.isLeftButton});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
          onPressed: onTap,
          style: context.theme.textButtonTheme.style!.copyWith(
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            minimumSize:
                WidgetStatePropertyAll(Size(double.infinity, double.infinity)),
          ),
          child: Align(
            alignment: isLeftButton == null
                ? Alignment.center
                : AlignmentDirectional(isLeftButton! ? -.30 : .30, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 5.w,
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: SvgPicture.asset(
                    isSelected ? selectedSvg : unselectedSvg,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                        isSelected ? selectedColor : unselectedColor,
                        BlendMode.srcIn),
                  ),
                ),
                FlexText(
                  child: Text(
                    label,
                    style: context.labelSmall.copyWith(
                        fontWeight: FontWeightM.medium,
                        height: 1,
                        color: isSelected ? selectedColor : unselectedColor),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
