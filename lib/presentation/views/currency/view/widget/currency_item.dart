import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_check_box.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';

class CurrencyItem extends StatefulWidget {
  final String currency;
  final bool isSelected;
  final void Function(bool value) onChange;
  const CurrencyItem({
    super.key,
    required this.currency,
    this.isSelected = false,
    required this.onChange,
  });

  @override
  State<CurrencyItem> createState() => _CurrencyItemState();
}

class _CurrencyItemState extends State<CurrencyItem> {
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
  void didUpdateWidget(CurrencyItem oldWidget) {
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.w),
      borderRadius: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            widget.currency,
            style: context.bodyLarge,
          ),

          CustomCheckBox(
            value: isSelected,
            borderRadius: 99999,
            onChange: (value) {
              var newValue = !isSelected;
              if (newValue != widget.isSelected && widget.isSelected == false) {
                _onChange(newValue);
                widget.onChange(newValue);
              }
            },
          ),
        ],
      ),
    );
  }
}
