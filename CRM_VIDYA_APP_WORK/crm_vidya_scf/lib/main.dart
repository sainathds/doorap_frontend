import 'package:crm_vidya_scf/screens/dashboard.dart';
import 'package:crm_vidya_scf/screens/item_screen.dart';
import 'package:crm_vidya_scf/screens/porder_screen.dart';
import 'package:crm_vidya_scf/screens/seller_screen.dart';

import 'screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        Dashboard.routeName: (_) => Dashboard(),
        PorderScreen.routeName: (_) => PorderScreen(),
        ItemScreen.routeName: (_) => const ItemScreen(),
        SellerScreen.routeName: (_) => const SellerScreen(),
      },
    );
  }
}
