import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/enums.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/routes_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/esim_details/view/widgets/plan_item.dart';
import 'package:smooth_corner/smooth_corner.dart';

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
                    switch (widget.type) {
                      EsimsType.countrie => CustomCachedImage(
                        imageUrl: '',
                        width: 24.w,
                        height: 24.w,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      EsimsType.regional => SvgPicture.asset(
                        SvgM.earth,
                        width: 24.w,
                        height: 24.w,
                      ),
                      EsimsType.global => SvgPicture.asset(
                        SvgM.earth2,
                        width: 24.w,
                        height: 24.w,
                      ),
                    },
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
          ).animatedOnAppear(0, SlideDirection.down),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  27.verticalSpace,
                  planItems().animatedOnAppear(1, SlideDirection.up),
                  24.verticalSpace,
                  plansInfo().animatedOnAppear(2, SlideDirection.up),
                ],
              ),
            ),
          ),

          14.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
            child: CustomInkButton(
              onTap: () {
                Navigator.pushNamed(context, RoutesManager.checkout.route);
              },
              gradient: LinearGradient(
                colors: [ColorM.primary, ColorM.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.dg),
              borderRadius: SizeM.commonBorderRadius.r,
              height: 54.h,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 7.w,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        SvgM.doubleArrow2,
                        width: 12.w,
                        height: 12.h,
                      ),
                      Text(
                        Translation.checkout.tr,
                        style: context.labelLarge.copyWith(
                          fontWeight: FontWeightM.semiBold,
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    spacing: 12.w,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 1.w,
                        height: 20.w,
                        color: Colors.white.withValues(alpha: .5),
                      ),
                      Text(
                        Translation.sar.trNamed({'sar': '100'}),
                        style: context.bodyLarge.copyWith(
                          height: 1.1,
                          fontWeight: FontWeightM.medium,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animatedOnAppear(0, SlideDirection.up),

          SizedBox(height: MediaQuery.of(context).padding.bottom + 10.h),
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
                  gb: i == 2 ? null : (i + 3) * 10,
                  onChange: (value) {
                    selectedPlanIndex.value = i;
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget plansInfo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaqExpansionTileCard(
            title: Translation.additional_info.tr,
            children: [
              SmoothContainer(
                borderRadius: BorderRadius.circular(12.r),
                padding: EdgeInsets.all(10.dg),
                color: context.isDark ? ColorM.primaryDark : Color(0xFFFAFAFA),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PlansInfoItem(
                          title: Translation.plan_type.tr,
                          value: 'Data Only',
                        ),

                        Container(
                          width: 1.w,
                          height: 25.w,
                          color: context.colorScheme.surface.withValues(
                            alpha: .5,
                          ),
                        ),

                        PlansInfoItem(
                          title: Translation.top_up_option.tr,
                          value: Translation.not_required.tr,
                        ),

                        Container(
                          width: 1.w,
                          height: 25.w,
                          color: context.colorScheme.surface.withValues(
                            alpha: .5,
                          ),
                        ),

                        PlansInfoItem(
                          title: Translation.network.tr,
                          value: "Zain",
                        ),
                      ],
                    ),

                    12.verticalSpace,

                    PlansInfoItem(
                      title: Translation.activation_policy.tr,
                      value:
                          "The Validity Period starts when esim Connects to any supported network",
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (widget.type.isGlobal || widget.type.isRegional)
            FaqExpansionTileCard(
              titleWidget: RichText(
                text: TextSpan(
                  style: context.bodyLarge.copyWith(height: 1.2),
                  children: [
                    TextSpan(
                      text: "(24)",
                      style: TextStyle(color: ColorM.primary),
                    ),
                    TextSpan(text: " "),
                    TextSpan(text: Translation.supported_countries.tr),
                  ],
                ),
              ),
              children: [
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.w,
                  children: [
                    for (var i = 0; i < 24; i++) ...[
                      Row(
                        spacing: 4.w,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomCachedImage(
                            imageUrl: '',
                            width: 14.w,
                            height: 14.w,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          Text(
                            'United States',
                            style: context.labelSmall.copyWith(height: 1.2),
                          ),

                          2.horizontalSpace,
                          if (i != 23)
                            Container(
                              width: 1.w,
                              height: 14.w,
                              color: context.colorScheme.surface.withValues(
                                alpha: .5,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class PlansInfoItem extends StatelessWidget {
  final String title;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;
  const PlansInfoItem({
    super.key,
    required this.title,
    required this.value,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      spacing: 5.w,
      children: [
        Text(
          title,
          style: context.labelMedium.copyWith(
            height: 1.2,
            fontWeight: FontWeightM.light,
            fontSize: 11.sp,
            color: context.labelMedium.color!.withValues(alpha: .5),
          ),
        ),
        Text(
          value,
          style: context.labelMedium.copyWith(height: 1.2, fontSize: 13.sp),
        ),
      ],
    );
  }
}

class FaqExpansionTileCard extends StatefulWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget> children;
  const FaqExpansionTileCard({
    super.key,
    this.title,
    this.titleWidget,
    required this.children,
  });

  @override
  State<FaqExpansionTileCard> createState() => _FaqExpansionTileCardState();
}

class _FaqExpansionTileCardState extends State<FaqExpansionTileCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedAlignment: Alignment.topLeft,
      iconColor: context.colorScheme.onSurface,
      onExpansionChanged: (value) {
        setState(() {
          isExpanded = value;
        });
      },
      trailing: Icon(
        isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        size: 18.w,
        color: context.colorScheme.surface.withValues(alpha: .5),
      ),
      collapsedIconColor: context.colorScheme.surface,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide.none,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide.none,
      ),
      collapsedBackgroundColor: null,
      backgroundColor: Colors.transparent,

      tilePadding: EdgeInsets.symmetric(horizontal: 16.dg),
      childrenPadding:
          EdgeInsets.symmetric(horizontal: 16.dg) +
          EdgeInsets.only(bottom: 16.dg),
      title: widget.title != null
          ? Text(widget.title!, style: context.bodyLarge.copyWith(height: 1.2))
          : widget.titleWidget ?? const SizedBox.shrink(),
      children: widget.children,
    );
  }
}
