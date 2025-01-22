import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class Notifications {
  late BuildContext context;
  Notifications(BuildContext context) {
    this.context = context;
  }
  Future<void> createBasicNotification(String title, String body) async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications()
        .requestPermissionToSendNotifications()
        .then((_) => Navigator.pop(context));
      }
    });
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        icon: "resource://drawable/notif_icon",
      ),
    );
  }
}