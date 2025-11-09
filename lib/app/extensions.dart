import 'package:hi_net/app/constants.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animated_on_appear.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/res/color_manager.dart';
import 'package:flutter/material.dart';

import 'app.dart';

extension NonNullString on String? {
  String get orEmpty => this ?? "";
}

extension NonNullInt on int? {
  int get orEmpty => this ?? 0;
}

extension ThemeSettings on BuildContext {
  set setTheme(ThemeMode theme) =>
      findAncestorStateOfType<MyAppState>()?.setTheme = theme;

  ThemeData get theme => Theme.of(this);

  /// 10.sp
  TextStyle get labelSmall => theme.textTheme.labelSmall!;

  /// 12.sp
  TextStyle get labelMedium => theme.textTheme.labelMedium!;

  /// 14.sp
  TextStyle get labelLarge => theme.textTheme.labelLarge!;

  /// 12.sp
  TextStyle get bodySmall => theme.textTheme.bodySmall!;

  /// 14.sp
  TextStyle get bodyMedium => theme.textTheme.bodyMedium!;

  /// 16.sp
  TextStyle get bodyLarge => theme.textTheme.bodyLarge!;

  /// 14.sp
  TextStyle get titleSmall => theme.textTheme.titleSmall!;

  /// 16.sp
  TextStyle get titleMedium => theme.textTheme.titleMedium!;

  /// 20.sp
  TextStyle get titleLarge => theme.textTheme.titleLarge!;

  /// 18.sp
  TextStyle get headlineSmall => theme.textTheme.headlineSmall!;

  /// 22.sp
  TextStyle get headlineMedium => theme.textTheme.headlineMedium!;

  /// 26.sp
  TextStyle get headlineLarge => theme.textTheme.headlineLarge!;

  /// 30.sp
  TextStyle get displaySmall => theme.textTheme.displaySmall!;

  /// 36.sp
  TextStyle get displayMedium => theme.textTheme.displayMedium!;

  /// 42.sp
  TextStyle get displayLarge => theme.textTheme.displayLarge!;

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  // theme mode
  bool get isDark =>
      findAncestorStateOfType<MyAppState>()?.themeMode == ThemeMode.dark;
  bool get isLite =>
      findAncestorStateOfType<MyAppState>()?.themeMode == ThemeMode.light;
  ThemeMode get themeMode =>
      findAncestorStateOfType<MyAppState>()?.themeMode ?? ThemeMode.light;

  // lite mode - dark mode (every project i handle this to my ussage)
  // Color get purpleWhiteColor => isLite ? ColorM.purple : ColorM.white;
  // Color get purpleBlackColor => isLite ? ColorM.purple : ColorM.black;
  // Color get lightPurpleHeavyPurpleColor =>
  //     isLite ? Color(0xFFFFC9E9) : ColorM.purpleHeavy;
  // Color get purpleHeavyPurple2Color =>
  //     isLite ? ColorM.purple : ColorM.purpleHeavy2;
  // Color get blackWhiteColor => isLite ? ColorM.black : ColorM.white;
  // Color get black2WhiteColor => isLite ? ColorM.black2 : ColorM.white;
  // Color get whiteBlackColor => isLite ? ColorM.white : ColorM.black;
  // Color get whiteHeavyPurpleColor => isLite ? ColorM.white : ColorM.purpleHeavy;
  // Color get grayHeavyPurpleColor => isLite ? ColorM.gray : ColorM.purpleHeavy;
  // Color get grayHeavyPurple2Color => isLite ? ColorM.gray : ColorM.purpleHeavy2;
  // Color get gray3HeavyPurple2Color =>
  //     isLite ? ColorM.gray3 : ColorM.purpleHeavy2;
  // Color get grayPurpleColor => isLite ? ColorM.gray : ColorM.purple;
  // Color get heavyPurpleWhiteColor => isLite ? ColorM.purpleHeavy : ColorM.white;
  // Color get whiteHeavyPurple2Color =>
  //     isLite ? ColorM.white : ColorM.purpleHeavy2;
  // Color get redWhiteColor => isLite ? ColorM.red : ColorM.white;
  // Color get heavyBlueWhiteColor => isLite ? ColorM.heavyBlue : ColorM.white;
  // Color get titaryWhiteColor => isLite ? ColorM.titary : ColorM.white;
  // Color get whiteTitaryColor => isLite ? ColorM.white : ColorM.titary;
  // Color get gray4HeavyPurpleColor => isLite ? ColorM.gray4 : ColorM.purpleHeavy;
  // Color get gray5HeavyPurpleColor =>
  //     isLite ? ColorM.gray5 : ColorM.purpleHeavy2;
  // Color get purplePurpleLightColor =>
  //     isLite ? ColorM.purple : ColorM.purpleLight;
  // Color get redRedLightColor => isLite ? ColorM.red : ColorM.redLight;
  // Color get redHeavyPurple2Color => isLite ? ColorM.red : ColorM.purpleHeavy2;
  // Color get greenWhiteColor => isLite ? Color(0xFF169995) : ColorM.white;
  // Color get redRed2Color => isLite ? ColorM.red : ColorM.red2;
}

extension OnlyNumber on String {
  String get onlyDoubles => replaceAll(RegExp(r'[^0-9.]'), '');
  String get onlyNumbers => replaceAll(RegExp(r'[^0-9]'), '');
}

extension ListReplaceExtension<T> on List<T> {
  void replaceWhere(bool Function(T) test, T replacement) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        this[i] = replacement;
      }
    }
  }

  void replaceFirstWhere(bool Function(T) test, T replacement) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        this[i] = replacement;
        break;
      }
    }
  }
}


extension AnimationsExtension on Widget {
  Widget animatedOnAppear(int index, [SlideDirection slideDirection = SlideDirection.down]) {
    return AnimatedOnAppear(
      delay: Constants.animationDelay + (30 * index),
      animationDuration: Constants.animationDuration,
      animationCurve: Constants.animationCurve,
      animationTypes: {AnimationType.fade, AnimationType.slide},
      slideDirection: slideDirection,
      slideDistance: Constants.animationSlideDistance,
      child: this,
    );
  }
}