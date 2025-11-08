// import 'dart:convert';
// import 'dart:io';

// import 'package:hi_net/app/app.dart';
// import 'package:hi_net/presentation/res/routes_manager.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';

// import 'awesome_notifications.dart';

// // Top-level background message handler. Must be a global or static function.
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   debugPrint("💬 Background message received: ${message.data}");
//   // final notification = message.notification;
//   // final title = notification?.title ?? message.data['title']?.toString() ?? 'Notification';
//   // final body = notification?.body ?? message.data['body']?.toString() ?? '';

//   // // Initialize channels minimally in background to ensure we can display
//   // await MyAwesomeNotifications.instance.initialize(isForeground: true);

//   // await MyAwesomeNotifications.instance.showNotification(
//   //   notificationContent: NotificationContent(
//   //     id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
//   //     channelKey: MyAwesomeNotifications.instance.channelKey,
//   //     title: title,
//   //     body: body,
//   //     notificationLayout: NotificationLayout.Default,
//   //   ),
//   // );
// }

// class FirebaseMessegingServices {
//   FirebaseMessegingServices._();
//   static final FirebaseMessegingServices instance =
//       FirebaseMessegingServices._();

//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   static bool _backgroundHandlerRegistered = false;

//   Future<String?> get fcmToken => _messaging.getToken();
//   Future<RemoteMessage?> get initialMessage => _messaging.getInitialMessage();

//   Future<void> initialize() async {
//     await _messaging.setAutoInitEnabled(true);
//     // Register background handler early and only once
//     if (!_backgroundHandlerRegistered) {
//       FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//       _backgroundHandlerRegistered = true;
//     }

//     // Request permissions (especially for iOS 10+)
//     await _requestPermissionIfNeeded();

//     // Ensure notification channels are ready
//     await MyAwesomeNotifications.instance.initialize();

//     // Foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       debugPrint("💬 Foreground message received");
//       final notification = message.notification;
//       final title = notification?.title ??
//           message.data['title']?.toString() ??
//           'Notification';
//       final body = notification?.body ?? message.data['body']?.toString() ?? '';

//       await MyAwesomeNotifications.instance.showBasicNotification(
//         title: title,
//         body: body,
//         groupKey: 'notification',
//         payload: {
//           'remote_message': jsonEncode(message.toMap()),
//         },
//       );
//     });
    
//   }

//   Future<void> handleInitialMessage() async {
//     final _initialMessage = await this.initialMessage;
//     if (_initialMessage != null) {
//       handleNotificationTap(_initialMessage);
//     }

//     // App in background and user taps the notification
//     FirebaseMessaging.onMessageOpenedApp.listen(handleNotificationTap);
//   }

//   Future<void> _requestPermissionIfNeeded() async {
//     if (Platform.isIOS) {
//       await _messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//     }
//   }

//   void handleNotificationTap(RemoteMessage message) {
//     if (kDebugMode) {
//       print('Notification tap data: ' + message.data.toString());
//     }

//     // NAVIGATOR_KEY.currentState!.pushNamed(
//     //   RoutesManager.serviceDetails.route,
//     //   arguments: {
//     //     'serviceId': message.data['service-id'] ?? 1,
//     //     'is-from-notification': true,
//     //   },
//     // ); 
//   }
// }

