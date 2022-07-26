
import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/model/notification_response.dart';
import 'package:door_ap/customer/screen/customer_btm_screen.dart';
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
  Future<void> _showNotification(String title, String desc, String userType, String status, String channelId) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(channelId, 'card_channel', 'card_description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('alarm'));
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(id++, title, desc, platformChannelSpecifics, /*payload: payload*/);

    if(userType == 'Vendor'){
      navigateToVendorHomeScreen();

    }else if(userType == 'Customer'){
      navigateToCustomerHomeScreen();
    }

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

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
        log("NOTIFICATION _PAYLOAD: " + message.data.toString());
        print('Message body: ${message.notification?.body}, data: ${message.data}');


        NotificationResponse responseModel = NotificationResponse.fromJson(message.data);
        String userType = responseModel.userType!;
        String orderStatus = responseModel.orderStatus!;
        log('NOTIFICATION FOREGROUND _UserType ' + userType);
        log('NOTIFICATION FOREGROUND _orderStatus ' + orderStatus);

        _showNotification('${message.notification?.title}', '${message.notification?.body}', userType, orderStatus, 'android_channel_id');
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
  }

  ///*
  ///
  ///
  void tapNotificationAppKilled() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      NotificationResponse responseModel = NotificationResponse.fromJson(message!.data);
      String userType = responseModel.userType!;
      String orderStatus = responseModel.orderStatus!;
      log('NOTIFICATION APP_KILL _UserType ' + userType);
      log('NOTIFICATION APP_KILL _orderStatus ' + orderStatus);

      if(userType == 'Vendor'){
        navigateToVendorHomeScreen();

      }else if(userType == 'Customer'){
        navigateToCustomerHomeScreen();
      }
    });

  }


  ///*
  ///
  ///
  void tapNatiFicationAppBackground() async{
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      NotificationResponse responseModel = NotificationResponse.fromJson(message.data);
      String userType = responseModel.userType!;
      String orderStatus = responseModel.orderStatus!;
      log("NOTIFICATION BACKGROUND UserType : " + userType);
      log("NOTIFICATION BACKGROUND Status : " + orderStatus);

      if(userType == 'Vendor'){
        navigateToVendorHomeScreen();

      }else if(userType == 'Customer'){
        navigateToCustomerHomeScreen();
      }
    });

  }


  ///*
  ///
  ///
  void navigateToVendorHomeScreen(){
    Navigator.pushAndRemoveUntil(
      Get.context!,
      MaterialPageRoute(
          builder: (context) => VendorHomeScreen()),
            (route) => false);
  }


  ///*
  ///
  ///
  void navigateToCustomerHomeScreen(){
    Navigator.pushAndRemoveUntil(
        Get.context!,
        MaterialPageRoute(builder: (context) => CustomerBtmScreen() ),
            (route) => false);
  }


}

