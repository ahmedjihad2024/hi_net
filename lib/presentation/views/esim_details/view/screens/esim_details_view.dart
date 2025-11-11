import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/enums.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/esim_details/view/widgets/plan_item.dart';

class EsimDetailsView extends StatefulWidget {
  final EsimsType type;
  const EsimDetailsView({super.key, required this.type});

  @override
  State<EsimDetailsView> createState() => _EsimDetailsViewState();
}

class _EsimDetailsViewState extends State<EsimDetailsView> {
  ValueNotifier<int> selectedPlanIndex = ValueNotifier(0);
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
                    CustomCachedImage(
                      imageUrl: '',
                      width: 24.w,
                      height: 24.w,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    Text(
                      'Egypt',
                      style: context.labelLarge.copyWith(height: 1.1),
                    ),
                  ],
                ),
              ),
              Text(
                '${Translation.plans.trNamed({'plans': '3'})}',
                style: context.labelLarge.copyWith(
                  height: 1.1,
                  color: ColorM.primary,
                ),
              ),
            ],
          ),
          27.verticalSpace,
          planItems(),
        ],
      ),
    );
  }

  Widget planItems() {
    return ValueListenableBuilder(
      valueListenable: selectedPlanIndex,
      builder: (context, value, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
          child: Column(
            spacing: 14.w,
            children: [
              for (var i = 0; i < 3; i++)
                PlanItem(
                  isRecommended: i == 0,
                  days: i + 3,
                  price: (i + 3) * 100,
                  isSelected: value == i,
                  gb: (i + 3) * 10,
                  onChange: (value) {
                    selectedPlanIndex.value = i;
                  },
                ),
            ],
          ),
        );
      }
    );
  }
}
