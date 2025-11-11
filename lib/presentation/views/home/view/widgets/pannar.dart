import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/common/ui_components/notch_container.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

class Pannar extends StatefulWidget {
  const Pannar({super.key});

  @override
  State<Pannar> createState() => _PannarState();
}

class _PannarState extends State<Pannar> {
  final ValueNotifier<int> currentIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ValueListenableBuilder(
          valueListenable: currentIndex,
          builder: (context, value, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4.w,
              children: [
                for (int i = 0; i < 3; i++)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    padding: EdgeInsets.all(i == value ? 1.w : 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: i == value
                          ? Border.all(color: ColorM.primary, width: 1.w)
                          : null,
                    ),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: 5.w,
                      height: 5.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == value
                            ? ColorM.primary
                            : ColorM.primary.withValues(alpha: .5),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        NotchContainer(
          notchPosition: NotchPosition.bottom,
          notchShape: NotchShape.roundedRectangle,
          margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
          notchSize: 61.w,
          notchDepth: 27.h,
          notchOffset: 0.5, // Centered
          borderRadius: 0,
          smoothness: 0,
          notchCornerRadius: 6.r,
          child: SmoothClipRRect(
            smoothness: 1,
            borderRadius: BorderRadius.circular(14.r),
            child: CarouselSlider(
              items: [
                CustomCachedImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1446776653964-20c1d3a81b06?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=2071',
                  width: double.infinity,
                ),
                CustomCachedImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1446776653964-20c1d3a81b06?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=2071',
                  width: double.infinity,
                ),
                CustomCachedImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1446776653964-20c1d3a81b06?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=2071',
                  width: double.infinity,
                ),
              ],
              options: CarouselOptions(
                viewportFraction: 1,
                aspectRatio: 1,
                height: 100.h,
                enableInfiniteScroll: true,
                padEnds: false,
                animateToClosest: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                scrollPhysics: const BouncingScrollPhysics(),
                onPageChanged: (index, reason) {
                  currentIndex.value = index;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
