import 'package:easy_localization/easy_localization.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:flutter/material.dart';

import 'package:nice_text_form/nice_text_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';

import '../../res/color_manager.dart';
import '../../res/translations_manager.dart';

class FastCountryCodeButton extends StatefulWidget {
  final void Function(CountryCode) onSelectionChange;
  final double scale;
  final String initialSelection;

  const FastCountryCodeButton(
      {super.key,
      required this.onSelectionChange,
      this.scale = 1.0,
      required this.initialSelection});

  @override
  State<FastCountryCodeButton> createState() => _FastCountryCodeButtonState();
}

class _FastCountryCodeButtonState extends State<FastCountryCodeButton> {
  @override
  Widget build(BuildContext context) {
    return CountryCodeButton(
      key: widget.key,
      initialSelection: widget.initialSelection,
      localization: context.locale,
      padding: EdgeInsets.zero,
      width: 30.w * widget.scale,
      height: 25.w * widget.scale,
      dialogWidth: .9 * 1.sw,
      dialogHeight: .8 * 1.sh,
      borderRadius: BorderRadius.circular(666.r),
      onSelectionChange: (pp) {
        if (pp.countryCode != widget.initialSelection) {
          widget.onSelectionChange.call(pp);
        }
      },
      dialogBoxDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SizeM.commonBorderRadius.r),
      ),
      dialogSelectionBuilder: (callbackfunc, countryCode) {
        return MaterialButton(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 13.w,
          ),
          onPressed: () => callbackfunc(),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                countryCode.countryName,
                overflow: TextOverflow.visible,
                style: context.labelMedium.copyWith(letterSpacing: 0),
              )),
              Spacer(),
              Text(countryCode.dialCode,
                  style: context.labelSmall.copyWith(letterSpacing: 0)),
              SizedBox(
                width: 10.w,
              ),
              Image.asset(
                "packages/nice_text_form/${countryCode.image}",
                fit: BoxFit.contain,
                width: 20.w,
              ),
            ],
          ),
        );
      },
      dialogCloseIconBuilder: (_) {
        return IconButton(
            onPressed: () => Navigator.of(context).pop(),
            style: context.theme.iconButtonTheme.style!.copyWith(
                iconSize: WidgetStatePropertyAll(
                  15.sp,
                ),
                iconColor: WidgetStatePropertyAll(
                    Colors.black.withValues(alpha: .8)),
                backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
            icon: Icon(
              Icons.arrow_back_rounded,
            ));
      },
      searchFormBuilder: (textController) {
        return Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 10.w,
            ),
            child: TextFormField(
              controller: textController,
              style: context.bodySmall,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  hintText: Translation.search_country.tr,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withValues(alpha: .3),
                      width: 1.w,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withValues(alpha: .3),
                      width: 1.w,
                    ),
                  ),
                  hintStyle: context.bodySmall.copyWith(
                    color: Colors.black.withValues(alpha: .5),
                    fontSize: context.bodySmall.fontSize!,
                  )),
            ),
          ),
        );
      },
    );
  }
}
