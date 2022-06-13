
import 'package:door_ap/vendor/screen/vendor_home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


class PushNotificationService{

  static final PushNotificationService _notificationService = PushNotificationService._internal();

  factory PushNotificationService() {
    return _notificationService;
  }

  PushNotificationService._internal();

  late FirebaseMessaging _messaging;
  int id = 0;
  // PushNotification _notificationInfo;
  bool _initialized = false;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    if (!_initialized) {
      registerNotification();
      registerLocalNotification();
      _initialized = true;
    }
  }


  ///*
  ///
  ///
  Future<void> registerLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: null
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }




  ///*
  ///
  ///
  Future<void> _showNotification(String title, String desc, /*String payload,*/ String channelId) async {

    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(channelId, 'card_channel', 'card_description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('alarm'),);
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(id++, title, desc, platformChannelSpecifics, /*payload: payload*/);
  }


  ///*
  ///
  ///
  void registerNotification() async {

    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true, badge: true, provisional: false, sound: true,);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message body: ${message.notification?.body}, data: ${message.data}');
        print('Message  data: ${message.notification}');
        // Parse the message received
/*        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          data: message.data,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );*/

        _showNotification('${message.notification?.title}', '${message.notification?.body}',
            'android_channel_id');
      });



      tapNatiFicationAppBackground();
      tapNotificationAppKilled();

    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void dispose() {
    _initialized = false;
  }

  ///*
  ///
  /// tap notification when app foreground
  Future selectNotification(String? payload) async {
    print('LocalNotification Payload : ${payload}');
    // navigateToCompleteTripScreen();

  }

  ///*
  ///
  ///
  void tapNotificationAppKilled() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if(message != null){
        navigateToVendorHomeScreen();
      }
    });

  }


  ///*
  ///
  ///
  void tapNatiFicationAppBackground() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp:");
      navigateToVendorHomeScreen();
    });

  }


  ///*
  ///
  ///
  void navigateToVendorHomeScreen(){
    Navigator.pushAndRemoveUntil(
      Get.context!,
      MaterialPageRoute(
        builder: (BuildContext context) => VendorHomeScreen(),
      ),
          (route) => false,
    );
  }



}

