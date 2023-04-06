import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

int createUniqueID() {
  Random random = Random();
  return random.nextInt(AwesomeNotifications.maxID);
}

class LocalNotification {
  static Future<void> createBasicNotificationWithPlayload() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueID(),
        channelKey: "basic_channel",
        title: "This is Basic Notificaition",
        body: "Press on the notificaiton on it one Temp Screen",
        payload: {
          "screen_name": "TEMP_SCREEN",
        },
      ),
    );
  }
}
