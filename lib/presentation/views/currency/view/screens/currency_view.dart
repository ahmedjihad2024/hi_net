import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/currency/view/widget/currency_item.dart';

class CurrencyView extends StatefulWidget {
  const CurrencyView({super.key});

  @override
  State<CurrencyView> createState() => _CurrencyViewState();
}

class _CurrencyViewState extends State<CurrencyView> {
  ValueNotifier<int> selectedCurrency = ValueNotifier<int>(-1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          49.verticalSpace,
          DefaultAppBar(
            actionButtons: [
              Expanded(
                child: Row(
                  spacing: 14.w,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Translation.currency.tr, style: context.bodyLarge),
                  ],
                ),
              ),
              SizedBox(width: 40.w),
            ],
          ).animatedOnAppear(0, SlideDirection.down),

          18.verticalSpace,

          currencyList(),
        ],
      ),
    );
  }

  Widget currencyList() {
    return Expanded(
      child: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg) +
            EdgeInsets.only(
              bottom: 10.h + MediaQuery.of(context).padding.bottom,
              top: 8.w,
            ),
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
              side: BorderSide(
                color: context.colorScheme.surface.withValues(alpha: .1),
                width: 1.w,
              ),
            ),
            color: context.colorScheme.secondary,
          ),
          child: ValueListenableBuilder(
            valueListenable: selectedCurrency,
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 16.w),
                    child: Text(
                      Translation.select_currency.tr,
                      style: context.labelMedium.copyWith(
                        color: context.colorScheme.surface.withValues(alpha: .5),
                        fontWeight: FontWeightM.light,
                      ),
                    ),
                  ),
                  5.verticalSpace,
                  Column(
                    children: [
                      for (var i = 0; i < 20; i++) ...[
                        CurrencyItem(
                          currency: "USD",
                          isSelected: value == i,
                          onChange: (value) {
                            selectedCurrency.value = i;
                          },
                        ),
                        if (i < 19)
                          Container(
                            height: 1.w,
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            color: context.colorScheme.surface.withValues(
                              alpha: .1,
                            ),
                          ),
                      ],
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ).animatedOnAppear(0, SlideDirection.up),
    );
  }
}
