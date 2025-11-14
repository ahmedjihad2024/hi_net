import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final String currentBalance = '150';

  // Mock transaction history data
  final List<Map<String, dynamic>> transactions = [
    {
      'type': 'deduction',
      'title': 'Deduction for France eSIM',
      'orderId': '656262',
      'date': DateTime(2025, 11, 8),
      'amount': '14',
      'icon': ImagesM.prize,
    },
    {
      'type': 'credit',
      'title': 'Gold level upgrade reward',
      'orderId': null,
      'date': DateTime(2025, 11, 8),
      'amount': '14',
      'icon': ImagesM.gold,
    },
  ];

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Translation.wallet.tr, style: context.bodyLarge),
                  ],
                ),
              ),
              SizedBox(width: 40.w),
            ],
          ).animatedOnAppear(4, SlideDirection.down),
          16.verticalSpace,
          // Current Balance Card
          _buildBalanceCard().animatedOnAppear(3, SlideDirection.down),
          16.verticalSpace,
          // // Transactions History
          _buildTransactionsHistory(),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      width: double.infinity,
      height: 82.w,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF005DFF), Color(0xFF113593), Color(0xFF8F1ABA)],
          stops: const [0.0, 0.5, 1.0],
        ),
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Decorative image on the right
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Transform.translate(
              offset: Offset(0, -20.w),
              child: Image.asset(ImagesM.wallet, fit: BoxFit.contain),
            ),
          ),
          // Content
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Translation.current_balance.tr,
                  style: context.labelMedium.copyWith(
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 14.w),
                Text(
                  Translation.sar.trNamed({'sar': currentBalance}),
                  style: context.bodyLarge.copyWith(
                    color: Colors.white,
                    fontSize: 18.sp,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsHistory() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Translation.transactions_history.tr,
              style: context.bodyLarge.copyWith(
                color: context.colorScheme.surface,
              ),
            ).animatedOnAppear(4, SlideDirection.up),
            SizedBox(height: 16.w),
            Expanded(
              child: ListView.separated(
                itemCount: 6,
                padding: EdgeInsets.only(
                  bottom: 20.w + MediaQuery.of(context).padding.bottom,
                ),
                separatorBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 12.w),
                    height: 1.h,
                    color: context.colorScheme.surface.withValues(alpha: 0.1),
                  );
                },
                itemBuilder: (context, index) {
                  final transaction = transactions[index % 2];
                  return TransactionHistoryItem(
                    type: transaction['type'] as String,
                    title: transaction['title'] as String,
                    orderId: transaction['orderId'] as String?,
                    date: transaction['date'] as DateTime,
                    amount: transaction['amount'] as String,
                    icon: transaction['icon'] as String,
                  );
                },
              ).animatedOnAppear(5, SlideDirection.up),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionHistoryItem extends StatelessWidget {
  const TransactionHistoryItem({
    super.key,
    required this.type,
    required this.title,
    this.orderId,
    required this.date,
    required this.amount,
    required this.icon,
  });

  final String type; // 'deduction' or 'credit'
  final String title;
  final String? orderId;
  final DateTime date;
  final String amount;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final isDeduction = type == 'deduction';
    final amountColor = isDeduction
        ? const Color(0xFFEC221F)
        : null; // null means gradient for credit

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                padding: EdgeInsets.all(6.792.w),
                decoration: BoxDecoration(
                  color: context.isDark ? ColorM.primaryDark : ColorM.gray,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                        icon,
                        width: 22.415.w,
                        height: 22.415.w,
                        fit: BoxFit.contain,
                      ),
              ),
              SizedBox(width: 9.w),
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title ,
                            softWrap: true,
                            style: context.labelMedium.copyWith(
                              color: context.colorScheme.surface,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 7.w),
                          Row(
                            children: [
                              if (orderId != null) ...[
                                ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: [ColorM.primary, ColorM.secondary],
                                  ).createShader(bounds),
                                  child: Text(
                                    Translation.order_id.trNamed({
                                      'order_id': orderId!,
                                    }),
                                    style: context.labelSmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeightM.light,
                                      decoration: TextDecoration.underline,
                                      decorationColor: ColorM.primary,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 7.w),
                                Container(
                                  width: 1.w,
                                  height: 11.w,
                                  color: context.isDark
                                      ? context.colorScheme.surface.withValues(
                                          alpha: 0.7,
                                        )
                                      : context.colorScheme.surface.withValues(
                                          alpha: 0.3,
                                        ),
                                ),
                                SizedBox(width: 7.w),
                              ],
                              Text(
                                DateFormat(
                                  'MMM d, yyyy',
                                  context.locale.languageCode,
                                ).format(date),
                                style: context.labelSmall.copyWith(
                                  fontWeight: FontWeightM.light,
                                  color: context.isDark
                                      ? context.colorScheme.surface.withValues(
                                          alpha: 0.7,
                                        )
                                      : context.colorScheme.surface.withValues(
                                          alpha: 0.6,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        amountColor != null
            ? Text(
                '${isDeduction ? '-' : '+ '} ${Translation.sar.trNamed({'sar': amount})}',
                style: context.labelMedium.copyWith(
                  color: amountColor,
                  height: 1.2,
                ),
              )
            : ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [ColorM.primary, ColorM.secondary],
                ).createShader(bounds),
                child: Text(
                  '+ ${Translation.sar.trNamed({'sar': amount})}',
                  style: context.labelMedium.copyWith(
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
      ],
    );
  }
}

extension WidgetExtension on Widget {
  Widget applyIf(bool condition, Widget Function(Widget) transform) {
    return condition ? transform(this) : this;
  }
}
