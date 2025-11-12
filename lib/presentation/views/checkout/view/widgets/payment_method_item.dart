import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_check_box.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/res/color_manager.dart';

class PaymentMethodItem extends StatefulWidget {
  final String image;
  final String? label;
  final bool isSelected;
  final void Function(bool value) onChange;
  const PaymentMethodItem({
    super.key,
    required this.image,
    this.label,
    this.isSelected = false,
    required this.onChange,
  });

  @override
  State<PaymentMethodItem> createState() => _PaymentMethodItemState();
}

class _PaymentMethodItemState extends State<PaymentMethodItem> {
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
  void didUpdateWidget(PaymentMethodItem oldWidget) {
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
      borderRadius: 0,
      child: Row(
        spacing: 12.w,
        children: [
          CustomCheckBox(
            key: UniqueKey(),
            value: isSelected,
            onChange: (value) {
              var newValue = !isSelected;
              if (newValue != widget.isSelected && widget.isSelected == false) {
                _onChange(newValue);
                widget.onChange(newValue);
              }
            },
            width: 24.w,
            height: 24.w,
            borderRadius: 999999,
          ),

          Image.asset(widget.image, height: 18.w),

          if (widget.label != null)
            Text(
              widget.label!,
              style: context.bodySmall.copyWith(
                color: context.bodySmall.color?.withValues(alpha: 0.8),
              ),
            ),
        ],
      ),
    );
  }
}
