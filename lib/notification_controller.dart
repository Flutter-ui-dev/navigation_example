import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:navigation_example/temp_screen.dart';

import 'main.dart';

navigateHelper(ReceivedAction receivedAction) {
  // this will check if there is playload and if the playload have screen name and it will navigate to specific screen
  if (receivedAction.payload != null &&
      receivedAction.payload!['screen_name'] == "TEMP_SCREEN") {
    MyApp.navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (_) => const TempScreen()));
  }
}

class NotificationController extends ChangeNotifier {
  // SINGLETON PATTERN
  static final NotificationController _instance =
      NotificationController._internal();

  factory NotificationController() {
    return _instance;
  }

  NotificationController._internal();

  ReceivedAction? initialAction;

// INITIALIZATION METHOD

  static Future<void> initializeLocalNotifications(
      {required bool debug}) async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.Max,
          enableVibration: true,
          defaultColor: Colors.redAccent,
          channelShowBadge: true,
          enableLights: true,
        ),
      ],
      debug: debug,
    );
  }

  // Local Notification Event Listener

  static Future<void> initializeNotificationsEventListeners() async {
    // Only after at least the action method is set, the notification events are delivered
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    bool isSilentAction =
        receivedAction.actionType == ActionType.SilentAction ||
            receivedAction.actionType == ActionType.SilentBackgroundAction;

// this will get call when the app is in background
    navigateHelper(receivedAction);
    Fluttertoast.showToast(
      msg:
          '${isSilentAction ? 'silent action' : 'Action'}  notification recevied',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedAction) async {
    debugPrint("Notification created");

    Fluttertoast.showToast(
      msg: 'Notification created',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedAction) async {
    debugPrint("Notification displayed");
    debugPrint("Notification Id : ${receivedAction.id}");

    Fluttertoast.showToast(
      msg: 'Notification displayed ',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("Notification dismiss");

    Fluttertoast.showToast(
      msg: 'Notification dismiss ',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }

  /// This method is call when a any given cause the app launch
  /// Note the app was terminated
  static Future<void> getInitialNotificationAction() async {
    ReceivedAction? receivedAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: true);

    if (receivedAction == null) return;

// this is get call when to come to live from termination
    navigateHelper(receivedAction);
    Fluttertoast.showToast(
        msg: 'Notification action launched app: $receivedAction',
        backgroundColor: Colors.deepPurple);
    print('Notification action launched app: $receivedAction');
  }
}
