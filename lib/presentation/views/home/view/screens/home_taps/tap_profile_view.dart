import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/app/supported_locales.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/custom_cached_image.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/routes_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/home/view/widgets/settings_group_items.dart';
import 'package:smooth_corner/smooth_corner.dart';

class TapProfileView extends StatefulWidget {
  const TapProfileView({super.key});

  @override
  State<TapProfileView> createState() => _TapProfileViewState();
}

class _TapProfileViewState extends State<TapProfileView> {
  Future<void> toggleLanguage(BuildContext con) async {
    if (con.locale == SupportedLocales.EN.locale) {
      await context.setLocale(SupportedLocales.AR.locale);
      // Phoenix.rebirth(con);
    } else {
      await context.setLocale(SupportedLocales.EN.locale);
      // Phoenix.rebirth(con);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        45.verticalSpace,
        topAppBar().animatedOnAppear(1, SlideDirection.down),
        18.verticalSpace,
        userInformation().animatedOnAppear(0, SlideDirection.down),
        14.verticalSpace,
        settingsSection(),
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
            Translation.my_profile.tr,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeightM.semiBold,
            ),
          ),

          CustomInkButton(
            onTap: () {},
            width: 50.w,
            height: 50.w,
            borderRadius: 10000,
            backgroundColor: context.colorScheme.onSurface,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              SvgM.turnOffScreen,
              width: 20.w,
              height: 20.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget userInformation() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              spacing: 14.w,
              children: [
                // user image
                CustomCachedImage(
                  imageUrl: '',
                  width: 50.w,
                  height: 50.w,
                  isCircle: true,
                ),

                // user name
                Flexible(
                  child: Column(
                    spacing: 4.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ahmed Jihad",
                        softWrap: true,
                        style: context.titleLarge.copyWith(
                          fontWeight: FontWeightM.medium,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesManager.editAccount.route,
                          );
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [ColorM.primary, ColorM.secondary],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Row(
                            spacing: 1.w,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                SvgM.edit,
                                width: 16.w,
                                height: 16.w,
                                colorFilter: ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Text(
                                Translation.edit_profile.tr,
                                style: context.labelMedium.copyWith(
                                  fontWeight: FontWeightM.regular,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // user level
          Container(
            width: 57.w,
            height: 46.w,
            decoration: ShapeDecoration(
              shape: SmoothRectangleBorder(
                smoothness: 1,
                borderRadius: BorderRadius.circular(14.r),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFAD46FF),
                  Color(0xFF9810FA),
                  Color(0xFFF6339A),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(ImagesM.bronze, width: 24.w, height: 24.w),
                Text(
                  Translation.bronze.tr,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeightM.regular,
                    fontSize: 8.sp,
                    height: 1,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsSection() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: context.colorScheme.onSurface,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeM.pagePadding.dg,
            vertical: 18.w,
          ),
          child: Column(
            children: [
              SettingsGroupItems(
                title: Translation.general.tr,
                items: [
                  SettingItem(
                    title: Translation.order_history.tr,
                    svg: SvgM.bagTick,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.orderHistory.route,
                      );
                    },
                  ),
                  SettingItem(
                    title: Translation.languages.tr,
                    svg: SvgM.languageCircle,
                    suffix: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.colorScheme.surface.withValues(
                            alpha: .1,
                          ),
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        spacing: 3.w,
                        children: [
                          LanguageButton(
                            title: Translation.ar.tr,
                            onTap: () async {
                              if (context.locale !=
                                  SupportedLocales.AR.locale) {
                                await toggleLanguage(context);
                              }
                            },
                            isSelected:
                                context.locale == SupportedLocales.AR.locale,
                          ),
                          LanguageButton(
                            title: Translation.en.tr,
                            onTap: () async {
                              if (context.locale !=
                                  SupportedLocales.EN.locale) {
                                await toggleLanguage(context);
                              }
                            },
                            isSelected:
                                context.locale == SupportedLocales.EN.locale,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SettingItem(
                    title: Translation.currency.tr,
                    svg: SvgM.coin,
                    lable: Translation.sar.trNamed({'sar': ''}),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.currency.route,
                      );
                    },
                  ),
                  SettingItem(
                    title: Translation.my_wallet.tr,
                    svg: SvgM.emptyWallet,
                    lable: Translation.sar.trNamed({'sar': '14'}),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.wallet.route,
                      );
                    },
                  ),
                   SettingItem(
                    title: Translation.share_and_win.tr,
                    svg: SvgM.programmingArrows,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.shareAndWin.route,
                      );
                    },
                  ),
                  SettingItem(
                    title: Translation.dark_theme.tr,
                    svg: SvgM.moon,
                    suffix: Switch.adaptive(
                      value: context.isDark,
                      activeTrackColor: ColorM.primary,
                      inactiveTrackColor: context.colorScheme.surface
                          .withValues(alpha: .15),
                      thumbColor: WidgetStatePropertyAll(Colors.white),
                      padding: EdgeInsets.zero,
                      trackColor: WidgetStatePropertyAll(
                        context.colorScheme.surface.withValues(alpha: .15),
                      ),
                      trackOutlineColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      trackOutlineWidth: WidgetStatePropertyAll(0),
                      activeThumbColor: Colors.white,
                      inactiveThumbColor: Colors.white,
                      onChanged: (value) {
                        context.setTheme = value
                            ? ThemeMode.dark
                            : ThemeMode.light;
                      },
                    ),
                  ),
                ],
              ),
              14.verticalSpace,

              SettingsGroupItems(
                title: Translation.support.tr,
                items: [
                  SettingItem(
                    title: Translation.legal_and_polices.tr,
                    svg: SvgM.shieldTick,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.legalAndPolices.route,
                      );
                    },
                  ),
                  SettingItem(
                    title: Translation.rate_hi_net.tr,
                    svg: SvgM.stars,
                    gradientTitleAndSvg: true,
                    onTap: () {},
                  ),
                  SettingItem(
                    title: Translation.help_and_support.tr,
                    svg: SvgM.messageQuestion,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.helpAndSupport.route,
                      );
                    },
                  ),
                  SettingItem(
                    title: Translation.esim_supported_devices.tr,
                    svg: SvgM.mobile,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animatedOnAppear(1, SlideDirection.up),
    );
  }

  bool isDark = false;
}

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      backgroundColor: isSelected
          ? context.isDark
                ? Colors.white
                : Colors.white.withValues(alpha: .05)
          : Colors.transparent,
      borderRadius: 9999,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
      child: Text(
        title,
        style: context.labelSmall.copyWith(
          fontSize: 10.sp,
          height: 1,
          color: isSelected
              ? ColorM.primary
              : context.colorScheme.surface.withValues(alpha: .5),
        ),
      ),
    );
  }
}
