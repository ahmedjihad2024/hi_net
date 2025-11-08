import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';

import '../../res/color_manager.dart';
import '../../res/fonts_manager.dart';
import '../../res/translations_manager.dart';

class MyErrorWidget extends StatelessWidget {
  final void Function() onRetry;
  final String errorMessage;
  const MyErrorWidget(
      {super.key, required this.onRetry, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 10.w,
        children: [
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: context.labelMedium.copyWith(
              fontWeight: FontWeightM.medium,
              color: ColorM.primary.withValues(alpha: .7),
            ),
          ),
          CustomInkButton(
              onTap: onRetry,
              backgroundColor: ColorM.primary.withValues(alpha: .05),
              borderRadius: 10.r,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
              child: Text(
                Translation.retry_button.tr,
                style: context.labelMedium.copyWith(fontWeight: FontWeightM.medium, color: ColorM.primary),
              ),
            ),
        ],
      ),
    );
  }
}
