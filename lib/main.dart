import 'dart:developer';

import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'common/resources/my_colors.dart';
import 'common/screen/splash_screen.dart';
import 'common/service/push_notification_service.dart';
import 'common/utils/my_shared_preference.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//below function used when notification receive in background then this function initialise firebase
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  print('A big message just show up :  ${message.messageId}');


}

//doorap private token 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  use for only 30 days from 06/07/2022

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = MyString.stripePublishableKey;

  await Firebase.initializeApp();
  PushNotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print("onMessage: $message");
  });
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  Map<int, Color> color =
  {
    50:Color.fromRGBO(21, 28, 41, 1.0),
    100:Color.fromRGBO(21, 28, 41, .2),
    200:Color.fromRGBO(21, 28, 41, .3),
    300:Color.fromRGBO(21, 28, 41, .4),
    400:Color.fromRGBO(21, 28, 41, .5),
    500:Color.fromRGBO(21, 28, 41, .6),
    600:Color.fromRGBO(21, 28, 41, .7),
    700:Color.fromRGBO(21, 28, 41, .8),
    800:Color.fromRGBO(21, 28, 41, .9),
    900:Color.fromRGBO(21, 28, 41, 1.0),
  };


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFF151C29, color);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyString.doorap!,
      theme: ThemeData(
          primaryColor: MyColor.themeBlue,
          primaryColorDark : MyColor.themeBlue,
          primarySwatch: colorCustom
      ),
      home: SplashScreen(),
    );
  }
}


