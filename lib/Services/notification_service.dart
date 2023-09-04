import 'dart:io';
import 'dart:math';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:push_notification/Models/notification_model.dart';
import 'package:push_notification/Pages/detail_page.dart';

import '../Pages/message_page.dart';
import '../Providers/notification_provider.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permission.");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User Granted Provisional Permission.");
    } else {
      AppSettings.openNotificationSettings();
      print("User Denied Permission.");
    }
  }

  

  void initLocalNotifications(BuildContext context,RemoteMessage message) async {
    var androidInitializationSettings =
        AndroidInitializationSettings('@drawable/pon_icon');
    var iosInitializationSettings = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
          handleMessage(context, message);
        });
  }


  void firebaseInit(BuildContext context) async{
    FirebaseMessaging.onMessage.listen((message) {

      if (Platform.isAndroid) {
        initLocalNotifications(context,message);
        showNotification(message);
      }else{
        showNotification(message);

      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notification'.toString(),
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'Your Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    DarwinNotificationDetails darwinInitializationSettings =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinInitializationSettings,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print("Refresh");
    });
  }



  Future<void> setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    
    //When App Terminated 
    if(initialMessage!=null){
      handleMessage(context, initialMessage);
    }

    //When App In Background 
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
     });
  }
  void handleMessage(BuildContext context,RemoteMessage message){
    if(message.data['Name'] == 'Pon'){
      String name = message.data['Title'];
      String des = message.data['Body'];
      String image = message.data['Image'] ?? 'https://img.freepik.com/premium-vector/account-icon-user-icon-vector-graphics_292645-552.jpg';
      NotificationModel myNotfi = NotificationModel(title: name,description: des,image: image);
      context.read<NotificationProvider>().addList(myNotfi);
      debugPrint(context.read<NotificationProvider>().notificationStoreList.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(message: myNotfi,)));
    }
  }
}
