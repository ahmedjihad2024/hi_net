import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../res/color_manager.dart';

class AnimatedTapsNavigator extends StatefulWidget {
  final List<String> tabs;
  final int selectedTap;
  final double? margin;
  final double? padding;
  final Function(int) onTap;

  const AnimatedTapsNavigator({
    required this.tabs,
    required this.selectedTap,
    required this.onTap,
    this.margin,
    this.padding,
    super.key,
  });

  @override
  _AnimatedTapsNavigatorState createState() => _AnimatedTapsNavigatorState();
}

class _AnimatedTapsNavigatorState extends State<AnimatedTapsNavigator> {
  late double margin;
  late double padding;

  double borderWidth = 1;

  late double width;

  @override
  void initState() {
    margin = widget.margin ?? SizeM.pagePadding.dg;
    padding = widget.padding ?? 6.w;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = (constraints.maxWidth - (margin * 2) - (padding * 2)) /
          widget.tabs.length;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: margin),
        padding: EdgeInsets.all(padding),
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(
              color: Color(0xFFEEF0EE),
              width: borderWidth,
            ),
          ),
        ),
        height: 50.h,
        child: Stack(
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsetsDirectional.only(
                    start: (widget.selectedTap * width),
                  ),
                  width: width,
                  height: double.infinity,
                  decoration: ShapeDecoration(
                    color: ColorM.primary,
                    shape: SmoothRectangleBorder(
                      smoothness: 1,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: List.generate(widget.tabs.length, (index) {
                return Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => widget.onTap(index),
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(padding),
                        width: width,
                        child: FittedBox(
                          child: Text(
                            widget.tabs[index],
                            textAlign: TextAlign.center,
                            softWrap: true,
                            maxLines: 2,
                            style: context.labelMedium.copyWith(
                              fontWeight: FontWeightM.medium,
                              height: 1,
                              color: index == widget.selectedTap
                                  ? Colors.white
                                  : Color(0xFF6A6A6A),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
