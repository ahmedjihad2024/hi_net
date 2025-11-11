import 'package:flutter/material.dart';

import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

import 'color_manager.dart';

class ThemeManager {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
    fontFamily: FontsM.Lexend.name,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: ColorM.primary,
      // black and whie
      surface: Colors.black,
      // while and black
      onSurface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,

      // white and ad degree of black colors in dark mode
      secondary: Colors.white,
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    scaffoldBackgroundColor: Color(0xFFF8F8F8),
    textTheme: TextStyles.customTextTheme(Colors.black),
    visualDensity: VisualDensity.comfortable,
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // padding: WidgetStatePropertyAll(EdgeInsets.zero),
        minimumSize: WidgetStatePropertyAll(Size.zero),
        backgroundColor: WidgetStatePropertyAll(ColorM.primary),
        iconColor: WidgetStatePropertyAll(Colors.white),
        iconSize: WidgetStatePropertyAll(12.sp),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size.zero),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.black.withValues(alpha: .5);
          }
          return ColorM.primary;
        }),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        // minimumSize: WidgetStatePropertyAll(Size(double.infinity, 60.w)),
        shape: WidgetStatePropertyAll(
          SmoothRectangleBorder(
            borderRadius: BorderRadius.circular(SizeM.commonBorderRadius.r),
          ),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontFamily: FontsM.Lexend.name,
          ),
        ),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.black.withValues(alpha: .1),
      selectionHandleColor: Colors.black,
    ),
  );

  // static get darkTheme => ThemeData(
  //       fontFamily: FontsM.IBMPlexSansArabic.name,
  //       colorScheme:
  //           ColorScheme.light(primary: ColorM.purple, secondary: ColorM.white),
  //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //       scaffoldBackgroundColor: ColorM.black,
  //       textTheme: TextStyles.customTextTheme(ColorM.white),
  //       visualDensity: VisualDensity.comfortable,
  //       iconButtonTheme: IconButtonThemeData(
  //           style: ButtonStyle(
  //               // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //               // padding: WidgetStatePropertyAll(EdgeInsets.zero),
  //               minimumSize: WidgetStatePropertyAll(Size.zero),
  //               backgroundColor: WidgetStatePropertyAll(ColorM.purple),
  //               iconColor: WidgetStatePropertyAll(ColorM.white),
  //               iconSize: WidgetStatePropertyAll(12.sp))),
  //       textButtonTheme: TextButtonThemeData(
  //           style: ButtonStyle(
  //               minimumSize: WidgetStatePropertyAll(Size.zero),
  //               backgroundColor: WidgetStateProperty.resolveWith((states) {
  //                 if (states.contains(WidgetState.disabled)) {
  //                   return ColorM.white.withValues(alpha: .5);
  //                 }
  //                 return ColorM.purple;
  //               }),
  //               padding: WidgetStatePropertyAll(EdgeInsets.zero),
  //               // minimumSize: WidgetStatePropertyAll(Size(double.infinity, 60.w)),
  //               shape: WidgetStatePropertyAll(RoundedRectangleBorder(
  //                   borderRadius:
  //                       BorderRadius.circular(SizeM.commonBorderRadius.r))),
  //               textStyle: WidgetStatePropertyAll(
  //                   TextStyle(fontSize: 18.sp, color: ColorM.white)))),
  //       textSelectionTheme: TextSelectionThemeData(
  //           cursorColor: ColorM.white,
  //           selectionColor: ColorM.white.withValues(alpha: .1),
  //           selectionHandleColor: ColorM.white),
  //     );
}

class TextStyles {
  static TextTheme customTextTheme(Color color, [additionalFontSize = 0.0]) =>
      TextTheme(
        labelSmall: TextStyle(
          fontSize: 10.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        labelMedium: TextStyle(
          fontSize: 12.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        labelLarge: TextStyle(
          fontSize: 14.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        titleSmall: TextStyle(
          fontSize: 14.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        titleMedium: TextStyle(
          fontSize: 16.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        titleLarge: TextStyle(
          fontSize: 20.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        headlineSmall: TextStyle(
          fontSize: 18.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        headlineMedium: TextStyle(
          fontSize: 22.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        headlineLarge: TextStyle(
          fontSize: 26.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        displaySmall: TextStyle(
          fontSize: 30.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        displayMedium: TextStyle(
          fontSize: 36.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
        displayLarge: TextStyle(
          fontSize: 42.sp,
          color: color,
          fontWeight: FontWeightM.regular,
          fontFamily: FontsM.Lexend.name,
        ),
      );
}
