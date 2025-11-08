import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';

import '../../../res/color_manager.dart';
import '../../utils/clip_shadow_path.dart';
import '../custom_circular_notched_rectangle.dart';

class CustomBottomNavBar extends StatelessWidget {
  final double bottomBarHeight;
  final double floatingButtonSize;
  final List<Widget> buttons;
  final Widget floatingButton;
  final void Function() onFloatingButtonTapped;
  const CustomBottomNavBar(
      {super.key,
      required this.bottomBarHeight,
      required this.floatingButtonSize,
      required this.buttons,
      required this.floatingButton,
      required this.onFloatingButtonTapped});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: bottomBarHeight + (floatingButtonSize / 2),
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            // buttons
            ClipShadowPath(
              clipper: NotchedClipper(
                notchTopRadius: 8.w,
                notchMargin: 6,
                circleRadius: floatingButtonSize / 2,
              ),
              shadow: BoxShadow(
                color: Colors.black.withValues(alpha: .13),
                blurRadius: 16,
              ),
              child: Container(
                width: double.infinity,
                height: bottomBarHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(18.r),
                  ),
                ),
                child: Row(
                  children: buttons,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: .5.sw - (floatingButtonSize / 2),
              child: TextButton(
                  onPressed: onFloatingButtonTapped,
                  style: context.theme.textButtonTheme.style!.copyWith(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(4.w)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999))),
                    visualDensity: VisualDensity.standard,
                    fixedSize: WidgetStatePropertyAll(
                        Size(floatingButtonSize, floatingButtonSize)),
                  ),
                  child: floatingButton),
            ),
          ],
        ),
      ),
    );
  }
}
