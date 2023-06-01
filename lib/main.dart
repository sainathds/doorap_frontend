import 'dart:developer';
import 'dart:io';

import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_http_overrides.dart';
import 'package:door_ap/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'common/resources/my_colors.dart';
import 'common/screen/splash_screen.dart';
import 'common/service/push_notification_service.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//below function used when notification receive in background then this function initialise firebase
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  print('A Notifications msg show:  ${message.messageId}');
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();  //use to run api on android_version <= 7
  Stripe.publishableKey = MyString.stripePublishableKey; //use to initialize stripe (generate publishable api key on stripe developer console)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PushNotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print("onMessage: $message");
  });

  runApp(
      RootRestorationScope(restorationId: 'root',
        child: MyApp()));
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


