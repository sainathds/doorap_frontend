import 'package:crm_vidya_scf/screens/login_screen.dart';
import 'package:crm_vidya_scf/screens/porder_screen.dart';
import 'package:crm_vidya_scf/screens/seller_screen.dart';
import 'package:crm_vidya_scf/services/servicehandle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'item_screen.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';

  final Map<dynamic, dynamic>? currentUser;

  const Dashboard({Key? key, this.currentUser}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void getSellers() async {
    ServerHandler()
      ..getCustomers()
          .then((value) => Navigator.of(context)
              .popAndPushNamed(SellerScreen.routeName, arguments: value))
          .catchError((e) => print(e));
  }

  void getPorders() async {
    ServerHandler()
      ..getPorders()
          .then((value) => Navigator.of(context)
              .popAndPushNamed(PorderScreen.routeName, arguments: value))
          .catchError((e) => print(e));
  }

  void getItems() {
    ServerHandler()
        .getItems()
        .then((value) => Navigator.of(context)
            .popAndPushNamed(ItemScreen.routeName, arguments: value))
        .catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())),
        ),
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 30.0,
            crossAxisSpacing: 30.0,
            children: [
              Card(
                  child: new InkWell(
                onTap: () {
                  getSellers();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.post_add,
                              color: Colors.blue,
                              size: 60.0,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Create Order",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 20.0))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
              Card(
                  child: new InkWell(
                onTap: () {
                  getPorders();
                 //   getSellers();
                  // Navigator.push(context,
                  //    MaterialPageRoute(builder: (context) => PorderScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.list_alt,
                              color: Colors.blue,
                              size: 60.0,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("My Orders",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 20.0))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.insert_chart_outlined,
                              color: Colors.blue,
                              size: 60.0,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("My Target",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 20.0))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                  child: new InkWell(
                onTap: () {
                  //print("tapped");
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => ItemScreen()));
                  // getItems();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 60.0,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("My Profile",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 20.0))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
