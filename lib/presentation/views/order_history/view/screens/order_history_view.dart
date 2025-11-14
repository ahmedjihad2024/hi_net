import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/order_history/view/widgets/order_history_item.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
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
                    Text(
                      Translation.order_history.tr,
                      style: context.bodyLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 40.w),
            ],
          ).animatedOnAppear(0, SlideDirection.down),

          18.verticalSpace,
          ordersList(),
        ],
      ),
    );
  }

  Widget ordersList() {
    return Expanded(
      child: ListView.separated(
        padding:
            EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg) +
            EdgeInsets.only(
              bottom: 10.h + MediaQuery.of(context).padding.bottom,
              top: 8.w,
            ),
        itemBuilder: (context, index) => OrderHistoryItem(),
        separatorBuilder: (context, index) => 18.verticalSpace,
        itemCount: 10,
      ).animatedOnAppear(1, SlideDirection.up),
    );
  }
}
