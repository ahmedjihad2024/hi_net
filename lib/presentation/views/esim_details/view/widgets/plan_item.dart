import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';

class PlanItem extends StatefulWidget {
  final int days;
  final double price;
  final int? gb;
  final bool isSelected;
  final void Function(bool value) onChange;
  final bool isRecommended;
  const PlanItem({
    super.key,
    required this.days,
    required this.price,
    this.gb,
    this.isSelected = false,
    required this.onChange,
    this.isRecommended = false,
  });

  @override
  State<PlanItem> createState() => _PlanItemState();
}

class _PlanItemState extends State<PlanItem> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = isSelected;
  }

  void _onChange(bool value) {
    setState(() {
      isSelected = value;
    });
  }

  @override
  void didUpdateWidget(PlanItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (mounted) {
      _onChange(widget.isSelected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: () {
        var newValue = !isSelected;
        if (newValue != widget.isSelected && widget.isSelected == false) {
          _onChange(newValue);
          widget.onChange(newValue);
        }
      },
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      borderRadius: 14.r,
      side: isSelected
          ? BorderSide.none
          : BorderSide(
              color: context.colorScheme.surface.withValues(alpha: .1),
            ),
      gradient: LinearGradient(
        colors: isSelected
            ? [ColorM.primary, ColorM.secondary]
            : [
                context.theme.scaffoldBackgroundColor,
                context.theme.scaffoldBackgroundColor,
              ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 8.w,
            children: [
              Text(
                Translation.days.trNamed({'days': widget.days.toString()}),
                style: context.bodyLarge.copyWith(
                  height: 1.1,
                  fontWeight: FontWeightM.medium,
                  color: isSelected
                      ? Colors.white
                      : context.colorScheme.surface,
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.gb == null
                        ? Translation.unlimited.tr
                        : Translation.gb.trNamed({'gb': widget.gb.toString()}),
                    style: context.labelMedium.copyWith(
                      height: 1.1,
                      color: isSelected
                          ? Colors.white
                          : context.colorScheme.surface.withValues(alpha: .7),
                    ),
                  ),
                  if (widget.isRecommended) ...[
                    21.horizontalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 3.w,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [ColorM.primary, ColorM.secondary],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        spacing: 4.w,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            SvgM.like,
                            width: 10.w,
                            height: 10.w,
                          ),
                          Text(
                            Translation.recommended.tr,
                            style: context.labelSmall.copyWith(
                              height: 1.1,
                              color: Colors.white,
                              letterSpacing: 0,
                              fontWeight: FontWeightM.light,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),

          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 12.w,
              children: [
                Flexible(
                  child: FittedBox(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      Translation.sar.trNamed({'sar': widget.price.toString()}),
                      style: context.bodyLarge.copyWith(
                        height: 1.1,
                        fontWeight: FontWeightM.medium,
                        color: Colors.white,
                      ),
                    ),
                  ).mask(isSelected),
                ),
                isSelected
                    ? SvgPicture.asset(
                        SvgM.tickCircle,
                        width: 24.w,
                        height: 24.w,
                      )
                    : Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999),
                          border: Border.all(
                            color: context.colorScheme.surface.withValues(
                              alpha: .6,
                            ),
                            width: 1.5.w,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension maskOnText on Widget {
  Widget mask(bool doIt) {
    return doIt
        ? this
        : ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [ColorM.primary, ColorM.secondary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds);
            },
            child: this,
          );
  }
}
