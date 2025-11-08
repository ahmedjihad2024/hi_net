// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

// Top-level static method for handling notification actions in background
// This must be a global or static function for Awesome Notifications to work in background
@pragma('vm:entry-point')
Future<void> onAwesomeNotificationActionReceivedMethod(
  ReceivedAction action,
) async {
  debugPrint("💬 Message tapped from awesome notifications: ${action.payload}");
  final payload = action.payload ?? {};
  if ((payload['remote_message'] ?? '').isNotEmpty) {
    final Map<String, dynamic> remote = jsonDecode(payload['remote_message']!);
    // FirebaseMessegingServices.instance.handleNotificationTap(RemoteMessage.fromMap(remote));
  }
}

class MyAwesomeNotifications {
  static final MyAwesomeNotifications _instance = MyAwesomeNotifications._();
  static MyAwesomeNotifications get instance => _instance;
  MyAwesomeNotifications._();

  final AwesomeNotifications _awesomeNotifications = AwesomeNotifications();
  AwesomeNotifications get awesomeNotifications => _awesomeNotifications;

  String _channelKey = 'basic_channel';
  String get channelKey => _channelKey;
  String? _channelName = 'Basic notifications';
  String? get channelName => _channelName;
  String? _channelDescription = 'Notification channel for basic notifications';
  String? get channelDescription => _channelDescription;
  int _notificationId = 1;
  int get notificationId => _notificationId;

  // Background service channel
  String _backgroundChannelKey = 'background_channel';
  String get backgroundChannelKey => _backgroundChannelKey;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  bool _isPermissionGranted = false;
  bool get isPermissionGranted => _isPermissionGranted;

  // Initialize notifications
  Future<bool> initialize({
    NotificationChannel? basicChannel,
    bool isForeground = false,
  }) async {
    // Check if notifications are already initialized and permission is granted
    if (_isInitialized) {
      return _isInitialized;
    }

    // Set basic channel
    if (basicChannel != null) {
      if (basicChannel.channelKey == null) {
        throw const AwesomeNotificationsException(
          message: 'Property channelKey is required',
        );
      }
      _channelName = basicChannel.channelName;
      _channelDescription = basicChannel.channelDescription;
      _channelKey = basicChannel.channelKey!;
    }

    // Initialize notifications if not initialized
    if (!_isInitialized) {
      _isInitialized = await _awesomeNotifications.initialize(null, [
        basicChannel ??
            NotificationChannel(
              channelKey: _channelKey,
              channelName: _channelName,
              channelDescription: _channelDescription,
              defaultColor: Colors.teal,
              ledColor: Colors.white,
              // groupKey: "basic_group",
              importance: NotificationImportance.High,
              enableVibration: true,
              onlyAlertOnce: false,
              enableLights: true,
              playSound: true,
            ),

        // Background service notification channel - minimum visibility
        // NotificationChannel(
        //     channelKey: _backgroundChannelKey,
        //     channelName: "Background Service",
        //     channelDescription: "Notification channel for background service",
        //     defaultColor: Colors.teal,
        //     ledColor: Colors.white,
        //     importance: NotificationImportance.Min, // Minimum importance
        //     enableVibration: false,
        //     onlyAlertOnce: true,
        //     enableLights: false,
        //     playSound: false,
        //     locked: true, // User can't modify this channel
        //     channelShowBadge: false), // Don't show badge for this channel
      ]);
    }

    // Request notification permissions after initialization
    if (_isInitialized && !_isPermissionGranted && !isForeground) {
      _isPermissionGranted = await requestPermissionToSendNotifications();
    }

    return _isInitialized;
  }

  // On Mesasge Tapped
  // Listen to message tapped
  Future<void> listenToMessageTapped() async {
    await _awesomeNotifications.setListeners(
      onActionReceivedMethod: onAwesomeNotificationActionReceivedMethod,
    );
  }

  // Request notification permissions
  Future<bool> requestPermissionToSendNotifications({
    List<NotificationPermission> permissions = const [
      NotificationPermission.Alert,
      NotificationPermission.Sound,
      NotificationPermission.Badge,
      NotificationPermission.Vibration,
      NotificationPermission.Light,
      NotificationPermission.FullScreenIntent,
      NotificationPermission.CriticalAlert,
    ],
  }) async {
    // Request notification permissions
    return await _awesomeNotifications.requestPermissionToSendNotifications(
      permissions: permissions,
    );
  }

  // Add basic channel
  Future<void> setChannel(
    NotificationChannel notificationChannel, {
    bool forceUpdate = false,
  }) async {
    await _awesomeNotifications.setChannel(
      notificationChannel,
      forceUpdate: forceUpdate,
    );
  }

  // Show basic notification
  Future<bool> showBasicNotification({
    required String title,
    required String body,
    String? groupKey,
    Map<String, String?>? payload,
  }) async {
    return await _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: _channelKey,
        title: title,
        body: body,
        groupKey: groupKey,
        notificationLayout: NotificationLayout.MessagingGroup,
        wakeUpScreen: true,
        payload: payload,
      ),
    );
  }

  Future<void> showNotification({
    required NotificationContent notificationContent,
    NotificationSchedule? schedule,
    List<NotificationActionButton>? actionButtons,
    Map<String, NotificationLocalization>? localizations,
  }) async {
    await _awesomeNotifications.createNotification(
      content: notificationContent,
      schedule: schedule,
      actionButtons: actionButtons,
      localizations: localizations,
    );
  }
}
