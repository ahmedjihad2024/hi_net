import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hi_net/app/constants.dart';
import 'package:hi_net/app/services/awesome_notifications.dart';
import 'package:hi_net/app/services/flutter_background_services.dart';
import 'package:hi_net/app/supported_locales.dart';
import 'app/app.dart';
import 'app/dependency_injection.dart';

//* For development build
//? flutter run --flavor dev
//? flutter run --release --flavor dev
//? flutter build apk --release --flavor dev

//* For production APK
//? flutter build apk --release --flavor prod
//* For production App Bundle
//? flutter build appbundle --release --flavor prod

void main() {
  runZonedGuarded(
    () async {
      // Before anything else
      WidgetsFlutterBinding.ensureInitialized();

      // init app modules
      await initAppModules();

      // init notification first
      // await MyAwesomeNotifications.instance.initialize();

      // if (!(await MyBackgroundService.instance.service.isRunning())) {
      //   await MyBackgroundService.instance.initialize();
      // }

      // init localization for ar and en
      await EasyLocalization.ensureInitialized();

      // set system ui overlay style
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: null,
          // systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: null,
          statusBarBrightness: null,
        ),
      );

      // set system ui mode to edge to edge
      // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      runApp(
        EasyLocalization(
          supportedLocales: SupportedLocales.allLocales,
          path: Constants.translationsPath,
          fallbackLocale: SupportedLocales.EN.locale,
          startLocale: SupportedLocales.AR.locale,
          child: Phoenix(key: Key("phoenix"), child: MyApp()),
        ),
      );
    },
    (_, error) {
      if (kDebugMode) {
        print(error.toString());
      }
    },
  );
}
