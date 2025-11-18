import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/common/utils/toast.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ShareAndWinView extends StatefulWidget {
  const ShareAndWinView({super.key});

  @override
  State<ShareAndWinView> createState() => _ShareAndWinViewState();
}

class _ShareAndWinViewState extends State<ShareAndWinView> {
  final String discountCode = 'HINET123';
  final String cashbackBalance = '14';
  final String totalEarned = '150';

  // Mock referral history data
  final List<Map<String, dynamic>> referralHistory = [
    {
      'name': 'Sarah Chen',
      'date': DateTime(2025, 11, 8),
      'amount': '14',
      'avatar': null,
    },
    {
      'name': 'Sarah Chen',
      'date': DateTime(2025, 11, 8),
      'amount': '14',
      'avatar': null,
    },
  ];

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: discountCode));
    showSnackBar(
      context: context,
      msg: 'Code copied to clipboard',
      isError: false,
    );
  }

  void _shareCode() {
    Share.share('Use my discount code: $discountCode');
  }

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
                      Translation.share_and_win.tr,
                      style: context.bodyLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 40.w),
            ],
          ).animatedOnAppear(4, SlideDirection.down),
          16.verticalSpace,
          // Discount Code Section
          _buildDiscountCodeSection().animatedOnAppear(
            3,
            SlideDirection.down,
          ),
          16.verticalSpace,
          // Stats Cards
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
            child: Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: SvgM.wallet3,
                    label: Translation.cashback_balance.tr,
                    value: Translation.sar.trNamed({'sar': cashbackBalance}),
                  ).animatedOnAppear(2, SlideDirection.down),
                ),
                Expanded(
                  child: _buildStatCard(
                    icon: SvgM.walletMoney,
                    label: Translation.total_earned.tr,
                    value: Translation.sar.trNamed({'sar': totalEarned}),
                  ).animatedOnAppear(1, SlideDirection.down),
                ),
              ],
            ),
          ).animatedOnAppear(0, SlideDirection.down),
          16.verticalSpace,
          // How It Works Section
          _buildHowItWorksSection(),
          16.verticalSpace,
          // Referral History
          _buildReferralHistorySection(),
          45.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildDiscountCodeSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
      padding: EdgeInsets.all(14.w),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFAD46FF), Color(0xFF9810FA), Color(0xFFF6339A)],
        ),
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative circles
          // Positioned.fill(
          //   child: Transform.translate(
          //     offset: Offset(-100.54.w, 0),
          //     child: SizedBox(
          //       width: 544.071.w,
          //       height: 438.233.h,
          //       child: Stack(
          //         children: [
          //           Positioned(
          //             left: 288.08.w,
          //             top: 0,
          //             child: Container(
          //               width: 255.996.w,
          //               height: 255.996.w,
          //               decoration: BoxDecoration(
          //                 color: Colors.white.withValues(alpha: 0.1),
          //                 shape: BoxShape.circle,
          //               ),
          //             ),
          //           ),
          //           Positioned(
          //             left: 0,
          //             top: 246.25.h,
          //             child: Container(
          //               width: 191.983.w,
          //               height: 191.983.w,
          //               decoration: BoxDecoration(
          //                 color: Colors.white.withValues(alpha: 0.1),
          //                 shape: BoxShape.circle,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Content
          Column(
            children: [
              Text(
                Translation.your_discount_code.tr,
                style: context.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeightM.medium,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 14.w),
              Container(
                width: 227.w,
                height: 42.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1.166.w,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  discountCode,
                  style: context.labelLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeightM.medium,
                    letterSpacing: 1.6,
                  ),
                ),
              ),
              SizedBox(height: 14.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(
                    icon: SvgM.copy,
                    label: Translation.copy_code.tr,
                    onTap: _copyCode,
                  ),
                  SizedBox(width: 16.w),
                  _buildActionButton(
                    icon: SvgM.share,
                    label: Translation.share_code.tr,
                    onTap: _shareCode,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return CustomInkButton(
      onTap: onTap,
      backgroundColor: Colors.white,
      borderRadius: 8.r,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            width: 24.w,
            height: 24.w,
            colorFilter: ColorFilter.mode(ColorM.primary, BlendMode.srcIn),
          ),
          SizedBox(width: 10.w),
          Text(
            label,
            style: context.labelLarge.copyWith(color: ColorM.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(14.r),
          side: BorderSide(
            color: context.colorScheme.surface.withValues(alpha: 0.1),
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: context.isDark ? ColorM.primaryDark : ColorM.gray,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(icon, width: 20.w, height: 20.w),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: context.labelSmall.copyWith(height: 1.2)),
                SizedBox(height: 8.w),
                Text(
                  value,
                  style: context.labelMedium.copyWith(
                    color: context.colorScheme.surface,
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

  Widget _buildHowItWorksSection() {
    final steps = [
      {'icon': ImagesM.chain, 'text': Translation.send_your_unique.tr},
      {'icon': ImagesM.chat, 'text': Translation.they_get_a_discount.tr},
      {'icon': ImagesM.mony, 'text': Translation.get_up_to_3_50_added.tr},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
      padding: EdgeInsets.all(12.w),
      decoration: ShapeDecoration(
        color: context.colorScheme.secondary,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(
            color: context.isDark
                ? const Color(0xFF111113)
                : Colors.black.withValues(alpha: 0.1),
            width: 1.w,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            Translation.how_it_works.tr,
            style: context.bodyMedium.copyWith(
              color: context.colorScheme.surface,
            ),
          ).animatedOnAppear(2, SlideDirection.up),
          SizedBox(height: 10.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: steps.map((step) {
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.792.w),
                      decoration: BoxDecoration(
                        color: context.isDark ? Colors.black : ColorM.gray,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        step['icon'] as String,
                        width: 22.415.w,
                        height: 22.415.w,
                      ),
                    ),
                    SizedBox(height: 6.w),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        step['text'] as String,
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
                        textAlign: TextAlign.center,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ).animatedOnAppear(3, SlideDirection.up),
        ],
      ),
    ).animatedOnAppear(1, SlideDirection.up);
  }

  Widget _buildReferralHistorySection() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Translation.referral_history.tr,
              style: context.bodyLarge.copyWith(
                color: context.colorScheme.surface,
              ),
            ).animatedOnAppear(4, SlideDirection.up),
            SizedBox(height: 16.w),
      
            Expanded(
              child: ListView.separated(
                itemCount: referralHistory.length,
                separatorBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 12.w),
                    height: 1.h,
                    color: context.colorScheme.surface.withValues(alpha: 0.1),
                  );
                },
                itemBuilder: (context, index) {
                  return referralHistoryItem(
                    name: "Ahmed",
                    date: DateTime(2025, 11, 8),
                    amount: "14",
                    avatar: "",
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

class referralHistoryItem extends StatelessWidget {
  const referralHistoryItem({
    super.key,
    required this.name,
    required this.date,
    required this.amount,
    required this.avatar,
  });
  final String name;
  final DateTime date;
  final String amount;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomCachedImage(
              imageUrl: avatar,
              width: 36.w,
              height: 36.w,
              isCircle: true,
            ),
            SizedBox(width: 9.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.labelMedium.copyWith(
                    color: context.colorScheme.surface,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 7.w),
                Text(
                  DateFormat(
                    'MMM d, yyyy',
                    context.locale.languageCode,
                  ).format(date),
                  style: context.labelSmall.copyWith(
                    fontWeight: FontWeightM.light,
                    height: 1.2,
                    color: context.colorScheme.surface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
        ShaderMask(
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
