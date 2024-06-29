import 'dart:convert';
import 'dart:math' as math;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/src/date_time.dart';
import 'package:timezone/src/location.dart';
import 'package:uuid/uuid.dart';

class LocalNotificationService {
// Instance of Flutternotification plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  //
  static void initialize() {
    // Initialization setting for android
    InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
      android: AndroidInitializationSettings("logo"),
      iOS: DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {
          //print(
          //"la fonction = onDidReceiveLocalNotification : $id , $title, $body, $payload ");
        },
      ),
    );
    //
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        //
        print('::::::::');
        print('notification(${notificationResponse.id}) action tapped: '
            '${notificationResponse.actionId} with'
            ' payload: ${notificationResponse.payload}');
        print(
            '-------(${notificationResponse.notificationResponseType.name}) action: '
            '${notificationResponse.notificationResponseType.index} ');
        //
        Map data = json.decode(notificationResponse.payload!);
        //
        if (data['topic'] == "evenement" || data['topic'] == "nouvel") {
          //
          // Get.to(
          //   DetailsEvenement(
          //     data,
          //   ),
          // );
        }

        //
      },
      //onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static Future<void> display(RemoteMessage message, Map e) async {
    // To display the notification in device
    //
    //Map e = await notificationController.envoyerMaPosition();//
    //message.data['body'] = "${e['latitude']} -- ${e['longitude']}";
    var uuid = Uuid();
    //
    var channel = AndroidNotificationChannel(
      uuid.v1(), // id
      'High Importance Notifications ${uuid.v1()}', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    try {
      if (message.data['title'] != null && !kIsWeb) {
        //
        print("::::: J'ai un objet notif");
        _notificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          message.data['title'],
          "${e['latitude']} -- ${e['longitude']}",
          //notification.title,
          //notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              actions: [
                AndroidNotificationAction(
                  "view",
                  "View",
                  showsUserInterface: true,
                ),
                // AndroidNotificationAction(
                //   "close",
                //   "Close",
                //   cancelNotification: true,
                //   showsUserInterface: false,
                // ),
              ],
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "logo",
            ),
          ),
          payload: json.encode(message.data),
        );
      } else {
        //
        print("::::: J'ai pas un objet notif");
        _notificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          message.data['title'],
          "${e['latitude']} -- ${e['longitude']}",
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              actions: [
                AndroidNotificationAction(
                  "view",
                  "View",
                  showsUserInterface: true,
                ),
                // AndroidNotificationAction(
                //   "close",
                //   "Close",
                //   cancelNotification: true,
                //   showsUserInterface: false,
                // ),
              ],
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "logo",
            ),
          ),
          payload: json.encode(message.data),
        );
      }

      //_____________________________________
      // await _notificationsPlugin.show(
      //   id,
      //   message.data['title'],
      //   message.data['body'],
      //   NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           channelDescription: channel.description,
      //           // actions: [
      //           //   AndroidNotificationAction("close", "Close"),
      //           // ],
      //           // TODO add a proper drawable resource to android, for now using
      //           //      one that already exists in example app.
      //           icon: "logo",
      //         ),
      //       ),
      //   //notificationDetails,
      //   payload: message.data['route'],
      // );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //
  static Future<void> displayBackground(Map data, Map e) async {
    // To display the notification in device
    //
    //Map e = await notificationController.envoyerMaPosition();//
    //message.data['body'] = "${e['latitude']} -- ${e['longitude']}";
    var uuid = Uuid();
    //
    var channel = AndroidNotificationChannel(
      uuid.v1(), // id
      'High Importance Notifications ${uuid.v1()}', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    try {
      if (data['title'] != null && !kIsWeb) {
        //
        print("::::: J'ai un objet notif");
        _notificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          data['title'],
          "${e['latitude']} -- ${e['longitude']}",
          //notification.title,
          //notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              actions: [
                AndroidNotificationAction(
                  "view",
                  "View",
                  showsUserInterface: true,
                ),
                // AndroidNotificationAction(
                //   "close",
                //   "Close",
                //   cancelNotification: true,
                //   showsUserInterface: false,
                // ),
              ],
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "logo",
            ),
          ),
          payload: json.encode(data),
        );
      } else {
        //
        print("::::: J'ai pas un objet notif");
        _notificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          data['title'],
          "${e['latitude']} -- ${e['longitude']}",
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              actions: [
                AndroidNotificationAction(
                  "view",
                  "View",
                  showsUserInterface: true,
                ),
                // AndroidNotificationAction(
                //   "close",
                //   "Close",
                //   cancelNotification: true,
                //   showsUserInterface: false,
                // ),
              ],
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "logo",
            ),
          ),
          payload: json.encode(data),
        );
      }

      //_____________________________________
      // await _notificationsPlugin.show(
      //   id,
      //   message.data['title'],
      //   message.data['body'],
      //   NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           channelDescription: channel.description,
      //           // actions: [
      //           //   AndroidNotificationAction("close", "Close"),
      //           // ],
      //           // TODO add a proper drawable resource to android, for now using
      //           //      one that already exists in example app.
      //           icon: "logo",
      //         ),
      //       ),
      //   //notificationDetails,
      //   payload: message.data['route'],
      // );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //
  static Future<void> displayCommande(RemoteMessage message) async {
    // To display the notification in device
    //
    var uuid = Uuid();
    //
    var channel = AndroidNotificationChannel(
      uuid.v1(), // id
      'High Importance Notifications ${uuid.v1()}', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    try {
      if (message.data['title'] != null && !kIsWeb) {
        //
        print("::::: J'ai un objet notif");
        _notificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          message.data['title'],
          message.data['commande'],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              actions: [
                AndroidNotificationAction(
                  "view",
                  "View",
                  showsUserInterface: true,
                ),
                // AndroidNotificationAction(
                //   "close",
                //   "Close",
                //   cancelNotification: true,
                //   showsUserInterface: false,
                // ),
              ],
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "logo",
            ),
          ),
          payload: json.encode(message.data),
        );
      } else {
        //
        print("::::: J'ai pas un objet notif");
        _notificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          message.data['title'],
          message.data['commande'],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              actions: [
                AndroidNotificationAction(
                  "view",
                  "View",
                  showsUserInterface: true,
                ),
                // AndroidNotificationAction(
                //   "close",
                //   "Close",
                //   cancelNotification: true,
                //   showsUserInterface: false,
                // ),
              ],
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "logo",
            ),
          ),
          payload: json.encode(message.data),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //
}
