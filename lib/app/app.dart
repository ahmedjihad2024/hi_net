import 'package:easy_localization/easy_localization.dart';
import 'package:hi_net/app/dependency_injection.dart';
import 'package:hi_net/app/services/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hi_net/presentation/common/utils/global_keyboard_dismissal.dart';

import 'package:hi_net/presentation/res/routes_manager.dart';
import 'package:hi_net/presentation/res/theme_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

GlobalKey<ScaffoldMessengerState> SCAFFOLD_MESSENGER_KEY =
    GlobalKey<ScaffoldMessengerState>();
GlobalKey<NavigatorState> NAVIGATOR_KEY = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // Key key = UniqueKey();
  late ThemeMode _themeMode;

  @override
  void initState() {
    SCAFFOLD_MESSENGER_KEY = GlobalKey<ScaffoldMessengerState>();
    NAVIGATOR_KEY = GlobalKey<NavigatorState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _themeMode = instance<AppPreferences>().isDark
        ? ThemeMode.dark
        : ThemeMode.light;
    // _themeMode = ThemeMode.light;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, details) {
        return MaterialApp(
          scaffoldMessengerKey: SCAFFOLD_MESSENGER_KEY,
          navigatorKey: NAVIGATOR_KEY,
          debugShowCheckedModeBanner:
              false, //  FlavorConfig.instance.showBanner,
          initialRoute: RoutesManager.splash.route,
          theme: ThemeManager.lightTheme(context),
          darkTheme: ThemeManager.darkTheme(context),
          themeMode: _themeMode,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: RoutesGeneratorManager.getRoute,
          builder: (context, child) {
            return GlobalKeyboardDismissal(child: child!);
          },
        );
      },
    );
  }

  set setTheme(ThemeMode themeMode) {
    instance<AppPreferences>().setTheme(themeMode == ThemeMode.dark);
    setState(() {
      _themeMode = themeMode;
    });
    // Phoenix.rebirth(context);
  }

  ThemeMode get themeMode => _themeMode;
}
