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

      // white and ad degree of black colors in dark mode
      secondary: Colors.white,
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    scaffoldBackgroundColor: Colors.white,
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

  static get darkTheme => ThemeData(
    fontFamily: FontsM.Lexend.name,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: ColorM.primary,
      // black and whie
      surface: Colors.white,
      // while and black
      onSurface: Colors.black,

      // white and ad degree of black colors in dark mode
      secondary: ColorM.primaryDark,
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextStyles.customTextTheme(Colors.white),
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
      cursorColor: Colors.white,
      selectionColor: Colors.white.withValues(alpha: .1),
      selectionHandleColor: Colors.white,
    ),
  );
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
