import 'package:flutter/widgets.dart';

class Constants {
  static const String baseUrl = 'https://bequeen.tsweeq.org/api/v1';
  static const String apiKey = '';
  static const int splashTimer = 4;
  static const String translationsPath = "assets/translations";
  static const String skippedOnBoarding = "skipped-on-boarding";
  static const String accessToken = "access-token";
  static const String refreshToken = "refresh-token";
  static const String language = "language";
  static const String userId = "user-id";
  static const String idToken = "id-token";
  static const String isDark = "is-dark";

  static const int animationDelay = 130;
  static const double animationSlideDistance = 60.0;
  static const Duration animationDuration = Duration(milliseconds: 800);
  static const Curve animationCurve = Curves.fastEaseInToSlowEaseOut;
}