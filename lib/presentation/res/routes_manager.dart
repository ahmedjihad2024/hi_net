
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hi_net/presentation/views/on_boarding/screens/on_boarding_view.dart';
import 'package:hi_net/presentation/views/sign_up/screens/sign_up_view.dart';

import '../views/splash/view/splash_view.dart';

enum RoutesManager {
  splash('splash/'),
  onBoarding('on-boarding/'),
  signUp('sign-up/');

  final String route;

  const RoutesManager(this.route);
}

class RoutesGeneratorManager {
  static Widget _getScreen(String? name, RouteSettings settings) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return switch (RoutesManager.values.firstWhere((t) => t.route == name)) {
      RoutesManager.splash => const SplashView(),
      RoutesManager.onBoarding => const OnBoardingView(),
      RoutesManager.signUp => const SignUpView(),
    };
  }
  // custom navigation animation
  static Route<dynamic> getRoute(RouteSettings settings) => PageRouteBuilder(
        settings: settings,
        transitionDuration: Duration(milliseconds: 400),
        reverseTransitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            _getScreen(settings.name, settings),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.fastLinearToSlowEaseIn,
          );

          return Opacity(
            opacity: curvedAnimation.value,
            child: SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            ),
          );
        },
      );

// static Route<dynamic> getRoute(RouteSettings settings) => MaterialPageRoute(
//     builder: _getBuilder(settings.name, settings), settings: settings);
}
