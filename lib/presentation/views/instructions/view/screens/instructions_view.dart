import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animated_tap_bar.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/instructions/view/screens/taps/tap_direct_view.dart';
import 'package:hi_net/presentation/views/instructions/view/screens/taps/tap_manual_view.dart';
import 'package:hi_net/presentation/views/instructions/view/screens/taps/tap_qr_code_view.dart';

class InstructionsView extends StatefulWidget {
  const InstructionsView({super.key});

  @override
  State<InstructionsView> createState() => _InstructionsViewState();
}

class _InstructionsViewState extends State<InstructionsView> {
  final ValueNotifier<int> _selectedTap = ValueNotifier(0);
  final CarouselSliderController _carouselController =
      CarouselSliderController();
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
                    Text(Translation.instructions.tr, style: context.bodyLarge),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
            ],
          ).animatedOnAppear(1, SlideDirection.down),
          24.verticalSpace,
          tapNavigator().animatedOnAppear(0, SlideDirection.down),
          taps(),
        ],
      ),
    );
  }

  Widget taps() {
    return Expanded(
      child: CarouselSlider(
        items: [TapDirectView(), TapQrCodeView(), TapManualView()],
        options: CarouselOptions(
          viewportFraction: 1,
          aspectRatio: 1,
          height: double.infinity,
          enableInfiniteScroll: false,
          padEnds: false,
          animateToClosest: false,
          scrollPhysics: const NeverScrollableScrollPhysics(),
        ),
        carouselController: _carouselController,
      ).animatedOnAppear(0, SlideDirection.up),
    );
  }

  Widget tapNavigator() {
    return ValueListenableBuilder(
      valueListenable: _selectedTap,
      builder: (context, selectedTapValue, child) {
        return AnimatedTapsNavigator(
          tabs: [
            Translation.direct.tr,
            Translation.qr_code.tr,
            Translation.manual.tr,
          ],
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
          activeTextColor: context.colorScheme.surface, // Dark Teal
          inactiveTextColor: context.colorScheme.surface.withValues(
            alpha: 0.7,
          ), // gray-400
          fontSize: 15.sp,
          fontWeight: FontWeightM.light,
          stickGradient: LinearGradient(
            colors: [ColorM.secondary, ColorM.primary],
            begin: AlignmentDirectional.centerStart,
            end: AlignmentDirectional.centerEnd,
          ), // Dark Teal
          stickBorderRadius: 50.r,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
        );
      },
    );
  }
}
