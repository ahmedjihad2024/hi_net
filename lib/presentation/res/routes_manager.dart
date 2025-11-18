import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_net/app/dependency_injection.dart';
import 'package:hi_net/app/enums.dart';
import 'package:hi_net/presentation/views/checkout/view/screens/checkout_view.dart';
import 'package:hi_net/presentation/views/currency/view/screens/currency_view.dart';
import 'package:hi_net/presentation/views/edit_account/bloc/edit_account_bloc.dart';
import 'package:hi_net/presentation/views/edit_account/screens/views/edit_account_view.dart';
import 'package:hi_net/presentation/views/esim_details/view/screens/esim_details_view.dart';
import 'package:hi_net/presentation/views/help_and_support/view/screens/help_and_support_view.dart';
import 'package:hi_net/presentation/views/home/view/screens/home_view.dart';
import 'package:hi_net/presentation/views/instructions/view/screens/instructions_view.dart';
import 'package:hi_net/presentation/views/legal_and_polices/screens/views/legal_and_polices_view.dart';
import 'package:hi_net/presentation/views/my_esim_details/view/screens/my_esim_details_view.dart';
import 'package:hi_net/presentation/views/notification/bloc/notification_bloc.dart';
import 'package:hi_net/presentation/views/notification/screens/view/notification_view.dart';
import 'package:hi_net/presentation/views/on_boarding/screens/on_boarding_view.dart';
import 'package:hi_net/presentation/views/order_history/view/screens/order_history_view.dart';
import 'package:hi_net/presentation/views/search/view/screens/search_view.dart';
import 'package:hi_net/presentation/views/share_and_win/view/screens/share_and_win_view.dart';
import 'package:hi_net/presentation/views/sign_in/view/screens/sign_in_view.dart';
import 'package:hi_net/presentation/views/sign_up/view/screens/sign_up_view.dart';
import 'package:hi_net/presentation/views/verify_number/view/screens/verify_number_view.dart';
import 'package:hi_net/presentation/views/wallet/view/screens/wallet_view.dart';

import '../views/splash/view/splash_view.dart';

enum RoutesManager {
  splash('splash/'),
  onBoarding('on-boarding/'),
  signUp('sign-up/'),
  signIn('sign-in/'),
  verifyNumber('verify-number/'),
  home('home/'),
  search('search/'),
  esimDetails('esim-details/'),
  checkout('checkout/'),
  notifications('notifications/'),
  myEsimDetails('my-esim-details/'),
  instructions('instructions/'),
  editAccount('edit-account/'),
  orderHistory('order-history/'),
  legalAndPolices('legal-and-polices/'),
  currency('currency/'),
  shareAndWin('share-and-win/'),
  wallet('wallet/'),
  helpAndSupport('help-and-support/');

  final String route;

  const RoutesManager(this.route);
}

class RoutesGeneratorManager {
  static Widget _getScreen(String? name, RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    return switch (RoutesManager.values.firstWhere((t) => t.route == name)) {
      RoutesManager.splash => const SplashView(),
      RoutesManager.onBoarding => const OnBoardingView(),
      RoutesManager.signUp => const SignUpView(),
      RoutesManager.signIn => const SignInView(),
      RoutesManager.verifyNumber => VerifyNumberView(
        phoneNumber: args?['phone-number'] as String,
        countryCode: args?['country-code'] as String,
        verifyType: args?['verify-type'] as VerifyType,
      ),
      RoutesManager.home => const HomeView(),
      RoutesManager.search => SearchView(
        showHistory: args?['show-history'] as bool? ?? false,
      ),
      RoutesManager.esimDetails => EsimDetailsView(
        type: args!['type'] as EsimsType,
      ),
      RoutesManager.checkout => const CheckoutView(),
      RoutesManager.notifications => BlocProvider(
        create: (context) => instance<NotificationBloc>(),
        child: const NotificationView(),
      ),
      RoutesManager.myEsimDetails => const MyEsimDetailsView(),
      RoutesManager.instructions => const InstructionsView(),
      RoutesManager.editAccount => BlocProvider(
        create: (context) => instance<EditAccountBloc>(),
        child: const EditAccountView(),
      ),
      RoutesManager.orderHistory => const OrderHistoryView(),
      RoutesManager.legalAndPolices => const LegalAndPolicesView(),
      RoutesManager.currency => const CurrencyView(),
      RoutesManager.shareAndWin => const ShareAndWinView(),
      RoutesManager.wallet => const WalletView(),
      RoutesManager.helpAndSupport => const HelpAndSupportView(),
    };
  }

  static Route<dynamic> getRoute(RouteSettings settings) => PageRouteBuilder(
    settings: settings,
    transitionDuration: Duration(milliseconds: 400),
    reverseTransitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) =>
        _getScreen(settings.name, settings),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.fastLinearToSlowEaseIn,
      );

      return Opacity(opacity: curvedAnimation.value, child: child);
    },
  );

  // custom navigation animation
  // static Route<dynamic> getRoute(RouteSettings settings) => PageRouteBuilder(
  //       settings: settings,
  //       transitionDuration: Duration(milliseconds: 400),
  //       reverseTransitionDuration: Duration(milliseconds: 300),
  //       pageBuilder: (context, animation, secondaryAnimation) =>
  //           _getScreen(settings.name, settings),
  //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //         const begin = Offset(1, 0.0);
  //         const end = Offset.zero;
  //         final tween = Tween(begin: begin, end: end);
  //         final curvedAnimation = CurvedAnimation(
  //           parent: animation,
  //           curve: Curves.fastLinearToSlowEaseIn,
  //         );

  //         return Opacity(
  //           opacity: curvedAnimation.value,
  //           child: SlideTransition(
  //             position: tween.animate(curvedAnimation),
  //             child: child,
  //           ),
  //         );
  //       },
  //     );

  // static Route<dynamic> getRoute(RouteSettings settings) => MaterialPageRoute(
  //     builder: (_) => _getScreen(settings.name, settings), settings: settings);
}
