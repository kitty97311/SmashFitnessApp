import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

class NotificationHelper {
  late String title;
  late String body;
  late String payload;
  late String id;
  late String type;
  late BuildContext context;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationHelper() {
    initialize();
    // print("\n\nPayload : $payload");
  } // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

  initialize() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS =
    const DarwinInitializationSettings(
      // onDidReceiveLocalNotification:
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  showNotification(
      {String? title,
        String? body,
        String? payload,
        String? id,
        BuildContext? context2}) async {
    context = context2!;
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    new AndroidNotificationDetails(
      id!, body!,
      // payload! ,
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  scheduleNotification({String? title, String? body, String? payload, String? id,  int? seconds}) async{
    print("clicked");
    try{
      await flutterLocalNotificationsPlugin.zonedSchedule(
          1,
          title,
          body,
          TZDateTime.now(local).add(Duration(seconds: seconds!)),
          const NotificationDetails(
            android: AndroidNotificationDetails(
                "200", 'TBible App', channelDescription: 'TBible App'),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
    }catch(e){
      print(e.toString());
    }
    periodicNotification(
        title: title!,
        id: id!,
        payload: payload!,
        body: body!
    );


  }

  //  Future<void> scheduleNotification({
  //   String? title,
  //   String? body,
  //   String? payload,
  //   String? id,
  //   int? seconds,
  // }) async {
  //   try {
  //     await flutterLocalNotificationsPlugin.zonedSchedule(
  //       1,
  //       title,
  //       body,
  //       tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds!)),
  //       const NotificationDetails(
  //         iOS: DarwinNotificationDetails(),
  //       ),
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       androidAllowWhileIdle: true,
  //     );
  //   } on PlatformException catch (e) {
  //     log(e.code);
  //   }
  //   periodicNotification(
  //     title: title,
  //     id: id,
  //     payload: payload,
  //     body: body,
  //
  //   );
  // }

  periodicNotification(
      {String? title,
        String? body,
        String? payload,
        String? id,
      }) async {

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('Scheduled Notification', "Scheduled");
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        2, title, body, RepeatInterval.daily, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  cancelNotification(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }

// Future onSelectNotification(String payload) async {
//   print("Called");
//   if (payload != null) {
//     print('\n\nnotification payload: $payload');
//
//
//   }
// }
}
