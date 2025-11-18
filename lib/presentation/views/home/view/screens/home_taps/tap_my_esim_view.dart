import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/common/ui_components/customized_smart_refresh.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/routes_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/home/view/widgets/customized_button.dart';
import 'package:hi_net/presentation/views/home/view/widgets/esims_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TapMyEsimView extends StatefulWidget {
  const TapMyEsimView({super.key});

  @override
  State<TapMyEsimView> createState() => _TapMyEsimViewState();
}

class _TapMyEsimViewState extends State<TapMyEsimView> {
  final RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        45.verticalSpace,
        topAppBar().animatedOnAppear(0, SlideDirection.down),
        30.verticalSpace,
        eSimsList(),
      ],
    );
  }

  Widget topAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Translation.my_esims.tr,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeightM.semiBold,
            ),
          ),
          // notification button
          CustomizedButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed(RoutesManager.notifications.route);
            },
            svgImage: SvgM.notification,
            count: 3,
          ),
        ],
      ),
    );
  }

  Widget eSimsList() {
    return Expanded(
      child: Container(
        color: context.colorScheme.onSurface,
        child: CustomizedSmartRefresh(
          controller: refreshController,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            refreshController.refreshCompleted();
          },
          enableLoading: true,
          onLoading: () async {
            await Future.delayed(const Duration(seconds: 2));
            refreshController.loadComplete();
          },
          child: ListView.separated(
            itemCount: 5,
            padding:
                EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg) +
                EdgeInsets.only(top: 16.w, bottom: SizeM.pagePadding.dg),
            separatorBuilder: (context, index) {
              return 18.verticalSpace;
            },
            itemBuilder: (context, index) {
              return EsimsItem(
                isActive: index % 2 == 0,
                onSeeDetails: () {
                  Navigator.of(
                    context,
                  ).pushNamed(RoutesManager.myEsimDetails.route);
                },
                onRenew: () {
                  Navigator.of(
                    context,
                  ).pushNamed(RoutesManager.myEsimDetails.route);
                },
                onActivationWay: () {
                  Navigator.of(
                    context,
                  ).pushNamed(RoutesManager.instructions.route);
                },
              );
            },
          ),
        ),
      ).animatedOnAppear(0, SlideDirection.up),
    );
  }
}
