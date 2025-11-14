import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hi_net/app/constants.dart';
import 'package:hi_net/app/enums.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animated_tap_bar.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animated_on_appear.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/common/ui_components/customized_smart_refresh.dart';
import 'package:hi_net/presentation/common/utils/after_layout.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/routes_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/home/view/widgets/country_item.dart';
import 'package:hi_net/presentation/views/home/view/widgets/customized_button.dart';
import 'package:hi_net/presentation/views/home/view/widgets/esim_card.dart';
import 'package:hi_net/presentation/views/home/view/widgets/global_item.dart';
import 'package:hi_net/presentation/views/home/view/widgets/half_circle_progress.dart';
import 'package:hi_net/presentation/views/home/view/widgets/pannar.dart';
import 'package:hi_net/presentation/views/home/view/widgets/regional_item.dart';
import 'package:hi_net/presentation/views/home/view/widgets/select_countr_bottom_sheet.dart';
import 'package:hi_net/presentation/views/home/view/widgets/select_duration_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smooth_corner/smooth_corner.dart';

enum TapHomeViewType { countries, regional, global }

class TapHomeView extends StatefulWidget {
  const TapHomeView({super.key});

  @override
  State<TapHomeView> createState() => _TapHomeViewState();
}

class _TapHomeViewState extends State<TapHomeView>
    with AutomaticKeepAliveClientMixin, AfterLayout {
  final RefreshController _refreshController = RefreshController();
  final ValueNotifier<int> _selectedTap = ValueNotifier(0);
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomizedSmartRefresh(
      controller: _refreshController,
      physics: const BouncingScrollPhysics(),
      onRefresh: () async {},
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.verticalSpace,
            topAppBar().animatedOnAppear(3),
            16.verticalSpace,
            Pannar().animatedOnAppear(2),
            16.verticalSpace,
            internetUsage().animatedOnAppear(1),
            16.verticalSpace,
            searchAndFilter().animatedOnAppear(0),
            16.verticalSpace,
            mostRequested().animatedOnAppear(0, SlideDirection.up),
            32.verticalSpace,
            Container(
              color: context.colorScheme.onSurface,
              child: Column(
                children: [
                  tapNavigator().animatedOnAppear(1, SlideDirection.up),
                  taps().animatedOnAppear(2, SlideDirection.up),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // name and subtitle
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 7.h,
            children: [
              AnimatedOnAppear(
                delay: Constants.animationDelay + (30 * 4),
                animationDuration: Constants.animationDuration,
                animationCurve: Constants.animationCurve,
                animationTypes: {AnimationType.pulse},
                slideDirection: SlideDirection.up,
                slideDistance: Constants.animationSlideDistance,
                child: Text(
                  Translation.hi_name.trNamed({'name': 'Ahmed'}),
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeightM.medium,
                    fontSize: 24.sp,
                    height: 1.2,
                  ),
                ),
              ),
              Text(
                Translation.lets_get_your_esim.tr,
                style: context.labelMedium.copyWith(
                  fontWeight: FontWeightM.light,
                  height: 1.2,
                  color: context.labelMedium.color!.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),

          // actions
          Row(
            spacing: 8.w,
            children: [
              CustomizedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RoutesManager.notifications.route);
                },
                svgImage: SvgM.notification,
                count: 3,
              ),
              CustomCachedImage(
                imageUrl: '',
                width: 50.w,
                height: 50.w,
                isCircle: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget internetUsage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      alignment: Alignment.center,
      height: 85.h,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          stops: [0.0, 1.0],
          colors: [ColorM.primary, ColorM.secondary],
          begin: AlignmentDirectional.centerStart,
          end: AlignmentDirectional.centerEnd,
        ),
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(18.r),
        ),
      ),
      child: Row(
        spacing: 10.w,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            spacing: 13.w,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // simcard and country name
              Row(
                spacing: 6.w,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    SvgM.simcard,
                    width: 22.w,
                    height: 22.w,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    'France',
                    style: context.bodyLarge.copyWith(
                      height: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              // day active usage
              Row(
                spacing: 4.w,
                children: [
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF3F85FF), width: 3.w),
                    ),
                  ),
                  Text(
                    Translation.active.tr,
                    style: context.bodyLarge.copyWith(
                      height: 1.2,
                      color: Colors.white,
                      fontWeight: FontWeightM.light,
                    ),
                  ),
                  Container(width: 15.w, height: .7.w, color: Colors.white),
                  Text(
                    Translation.days_left.trNamed({'days': '5'}),
                    style: context.bodyLarge.copyWith(
                      height: 1.2,
                      color: Colors.white,
                      fontWeight: FontWeightM.light,
                    ),
                  ),
                ],
              ),
            ],
          ),
          false
              ? Text(
                  Translation.unlimited.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeightM.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                )
              : HalfCircleProgress(
                 delay: Duration(milliseconds: 500),
                  size: 110.w,
                  progress: .7,
                  strokeWidth: 11,
                  progressColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  animationDuration: Duration(milliseconds: 600),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 65.w,
                        child: FittedBox(
                          child: Text(
                            Translation.gb.trNamed({'gb': '5.6'}),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeightM.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 65.w,
                        child: FittedBox(
                          child: Text(
                            Translation.lefts_of.trNamed({'lefts': '12'}),
                            style: TextStyle(
                              fontSize: 6.sp,
                              color: Colors.white,
                              height: 1.2,
                            ),
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

  Widget searchAndFilter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
      decoration: ShapeDecoration(
        color: context.colorScheme.onSurface,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(14.r),
        ),
        shadows: [
          BoxShadow(
            color: ColorM.primary.withValues(alpha: 0.02),
            blurRadius: 0,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Filter(
                selectedFilter: Translation.all_countries.tr,
                label: Translation.country.tr,
                onTap: () {
                  SelectCountrBottomSheet.show(context);
                },
              ),
              13.horizontalSpace,
              Container(
                width: 1.w,
                height: 28.h,
                color: context.colorScheme.surface.withValues(alpha: 0.2),
              ),
              13.horizontalSpace,
              Filter(
                selectedFilter: Translation.all_duration.tr,
                label: Translation.duration.tr,
                onTap: () {
                  SelectDurationBottomSheet.show(context);
                },
              ),
            ],
          ),
          SizedBox.shrink(),
          CustomInkButton(
            onTap: () {
              Navigator.of(context).pushNamed(
                RoutesManager.search.route,
                arguments: {'show-history': true},
              );
            },
            width: 34.w,
            height: 34.w,
            alignment: Alignment.center,
            gradient: LinearGradient(
              colors: [ColorM.primary, ColorM.secondary],
              begin: AlignmentDirectional.centerStart,
              end: AlignmentDirectional.centerEnd,
            ),
            borderRadius: 100000,
            child: SvgPicture.asset(
              SvgM.search,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              width: 16.w,
              height: 16.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget mostRequested() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
          child: Text(
            Translation.most_requested.tr,
            style: context.titleMedium,
          ),
        ),
        12.verticalSpace,
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 12.w,
                  children: [
                    for (var i = 0; i < 5; i++)
                      EsimCard(
                        imageUrl:
                            'https://media.istockphoto.com/id/2177438870/photo/historic-watchtower-overlooking-the-coastline-of-sur-oman-on-a-clear-sunny-day-showcasing.jpg?s=2048x2048&w=is&k=20&c=OZL8khaxGSVYv2tjyUwO2L0spOuXxSzKMCvV66JVkh8=',
                        countryName: 'UAE',
                        label: 'From 16 SAR',
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget tapNavigator() {
    return ValueListenableBuilder(
      valueListenable: _selectedTap,
      builder: (context, selectedTapValue, child) {
        return AnimatedTapsNavigator(
          tabs: [Translation.countries.tr, Translation.regional.tr, Translation.global.tr],
          selectedTap: selectedTapValue,
          onTap: (index) {
            _selectedTap.value = index;
            _carouselController.animateToPage(index);
          },
          margin: 0,
          padding: 0,
          isStickStyle: true,
          stickHeight: 1.5.w,
          stickWidth: 83.w,
          borderRadius: 0,
          stickTopMargin: 45.h - 1.5.w, // Position stick at bottom of container
          isStickAtTop: false,
          containerHeight: 45.h,
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0,
          activeTextColor: ColorM.primary, // Dark Teal
          inactiveTextColor: context.colorScheme.surface.withValues(
            alpha: 0.7,
          ), // gray-400
          fontSize: 15.sp,
          fontWeight: FontWeightM.light,
          stickColor: ColorM.primary, // Dark Teal
          stickBorderRadius: 50.r,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
        );
      },
    );
  }

  Widget taps() {
    return CarouselSlider(
      items: [
        CountriesTap(type: TapHomeViewType.countries),
        CountriesTap(type: TapHomeViewType.regional),
        CountriesTap(type: TapHomeViewType.global),
      ],
      options: CarouselOptions(
        viewportFraction: 1,
        aspectRatio: 1,
        height: 0.5.sh,
        enableInfiniteScroll: false,
        padEnds: false,
        animateToClosest: false,
        scrollPhysics: const NeverScrollableScrollPhysics(),
      ),
      carouselController: _carouselController,
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> afterLayout(BuildContext context) async {}
}

class Filter extends StatefulWidget {
  final String selectedFilter;
  final Function() onTap;
  final String label;
  const Filter({
    super.key,
    required this.selectedFilter,
    required this.onTap,
    required this.label,
  });

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6.w,
        children: [
          Text(
            widget.label,
            style: context.labelSmall.copyWith(
              fontWeight: FontWeightM.light,
              height: 1.2,
              color: context.labelMedium.color!.withValues(alpha: 0.9),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.selectedFilter,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                  letterSpacing: -0.24,
                ),
              ),
              10.horizontalSpace,
              Transform.rotate(
                angle: 90 * 3.14159 / 180, // 90 degrees in radians
                child: Icon(
                  textDirection: TextDirection.ltr,
                  Icons.arrow_forward_ios,
                  size: 12.w,
                  color: context.labelMedium.color!.withValues(alpha: .8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CountriesTap extends StatefulWidget {
  final TapHomeViewType type;
  const CountriesTap({super.key, required this.type});

  @override
  State<CountriesTap> createState() => _CountriesTapState();
}

class _CountriesTapState extends State<CountriesTap>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => switch (widget.type) {
        TapHomeViewType.countries => CountryItem2(
          imageUrl: '',
          countryName: 'UAE',
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutesManager.esimDetails.route,
              arguments: {'type': EsimsType.countrie},
            );
          },
        ),
        TapHomeViewType.regional => RegionalItem(
          imageUrl: '',
          countryName: 'UAE',
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutesManager.esimDetails.route,
              arguments: {'type': EsimsType.regional},
            );
          },
        ),
        TapHomeViewType.global => GlobalItem(
          imageUrl: '',
          countryName: 'UAE',
          onTap: () {
            Navigator.pushNamed(
              context, 
              RoutesManager.esimDetails.route,
              arguments: {'type': EsimsType.global},
            );
          },
          isRecommended: (index % 2) == 0,
        ),
      },
      separatorBuilder: (context, index) => Container(
        height: 1.w,
        margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
        color: context.colorScheme.surface.withValues(alpha: 0.2),
      ),
      itemCount: 5,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
