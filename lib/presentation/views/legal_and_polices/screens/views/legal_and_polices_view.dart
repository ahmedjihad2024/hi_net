import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/circular_progress_indicator.dart';
import 'package:hi_net/presentation/common/ui_components/custom_scrollbar.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/common/ui_components/error_widget.dart';
import 'package:hi_net/presentation/common/utils/after_layout.dart';
import 'package:hi_net/presentation/common/utils/state_render.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';

class LegalAndPolicesView extends StatefulWidget {
  const LegalAndPolicesView({super.key});

  @override
  State<LegalAndPolicesView> createState() => _LegalAndPolicesViewState();
}

class _LegalAndPolicesViewState extends State<LegalAndPolicesView>
    with AfterLayout {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text(
                      Translation.legal_and_polices.tr,
                      style: context.bodyLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 40.w),
            ],
          ).animatedOnAppear(0, SlideDirection.down),
          18.verticalSpace,
          ScreenState.setState(
            reqState: ReqState.success,
            loading: () {
              return Expanded(
                child: const Center(
                  child: MyCircularProgressIndicator(),
                ).animatedOnAppear(1, SlideDirection.up),
              );
            },
            error: () {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeM.pagePadding.dg,
                  ),
                  child: MyErrorWidget(onRetry: () {}, errorMessage: 'Error'),
                ).animatedOnAppear(1, SlideDirection.up),
              );
            },
            online: () {
              return Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: SizeM.pagePadding.dg,
                    start: SizeM.pagePadding.dg,
                  ),
                  child: CustomScrollbar(
                    controller: _scrollController,
                    thumbColor: ColorM.primary,
                    trackColor: context.colorScheme.surface.withValues(
                      alpha: .05,
                    ),
                    alwaysVisible: false,
                    position: Directionality.of(context) == TextDirection.ltr
                        ? ScrollbarPosition.right
                        : ScrollbarPosition.left,
                    thumbRadius: 4,
                    trackWidth: 4.w,
                    showTrack: true,
                    padding: EdgeInsetsDirectional.only(
                      start: SizeM.pagePadding.dg / 2,
                      end: SizeM.pagePadding.dg,
                      bottom: SizeM.pagePadding.dg,
                    ),
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12.h,
                        children: [
                          for (var i = 0; i < 20; i++)
                            _Item(
                              title: 'Terms',
                              content:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.',
                            ),
                        ],
                      ),
                    ),
                  ),
                ).animatedOnAppear(1, SlideDirection.up),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Future<void> afterLayout(BuildContext context) async {}
}

class _Item extends StatelessWidget {
  final String title;
  final String content;
  const _Item({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.labelLarge.copyWith(fontWeight: FontWeightM.medium),
        ),
        14.verticalSpace,
        Text(
          content,
          textAlign: TextAlign.justify,
          style: context.labelMedium.copyWith(
            fontSize: 13.sp,
            color: context.colorScheme.surface.withValues(alpha: .7),
          ),
        ),
      ],
    );
  }
}
