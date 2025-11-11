import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/enums.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_form_field/custom_form_field.dart';
import 'package:hi_net/presentation/common/ui_components/customized_smart_refresh.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/routes_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/search/view/widgets/search_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          49.verticalSpace,
          DefaultAppBar(
            actionButtons: [
              5.horizontalSpace,
              Expanded(child: searchField()),
            ],
          ),
          19.verticalSpace,
          Expanded(
            child: CustomizedSmartRefresh(
              controller: refreshController,
              scrollController: scrollController,
              enableLoading: true,
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
                refreshController.refreshCompleted(resetFooterState: true);
              },
              onLoading: () async {
                await Future.delayed(Duration(seconds: 2));
                refreshController.loadComplete();
              },
              child: ListView.separated(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg) +
                    EdgeInsets.only(top: 16.w) +
                    EdgeInsets.only(
                      bottom:
                          SizeM.pagePadding.dg +
                          MediaQuery.of(context).viewPadding.bottom,
                    ),
                itemBuilder: (context, index) => SearchItem(
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
                separatorBuilder: (context, index) => 13.verticalSpace,
                itemCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchField() {
    return NiceTextForm(
      height: 52.h,
      hintText: Translation.search.tr,
      boxDecoration: ShapeDecoration(
        color: context.colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      activeBoxDecoration: ShapeDecoration(
        color: context.colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      textStyle: context.labelLarge.copyWith(
        fontSize: context.labelLarge.fontSize!,
        fontWeight: FontWeightM.light,
      ),
      hintStyle: context.labelLarge.copyWith(
        color: context.labelLarge.color!.withValues(alpha: .8),
        fontSize: context.labelLarge.fontSize!,
        fontWeight: FontWeightM.light,
      ),
      textEditingController: searchController,
      prefixWidget: SvgPicture.asset(
        SvgM.search,
        colorFilter: ColorFilter.mode(
          context.labelLarge.color!.withValues(alpha: .8),
          BlendMode.srcIn,
        ),
        width: 16.w,
        height: 16.w,
      ),
      sufixWidget: (isSecure) => InkWell(
        onTap: () {},
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: SvgPicture.asset(
          SvgM.filterSearch,
          width: 20.w,
          height: 20.w,
        ),
      ),
    );
  }
}
