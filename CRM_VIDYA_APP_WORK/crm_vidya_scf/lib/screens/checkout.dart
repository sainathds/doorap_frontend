import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOut extends StatefulWidget {
  String seller;
  CheckOut(this.item, this.seller);
  final List<Map<String, String>> item;

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  String username = "";
  String fullname = "";
  getCurrentUser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    setState(() {
      username = _prefs.getString('username') ?? "";
      fullname = _prefs.getString('fullname') ?? "";
    });
  }

  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              'Name Of the Customer: ${widget.seller} ',
              style: TextStyle(fontSize: 19),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'User Name: $username',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Date and Time: ${DateFormat('dd.MM.yyyy  kk:mm').format(dateTime)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'The Items are:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      Text(
                        'S.NO',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'ITEM',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'QUANTITY',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  for (int i = 0; i < widget.item.length; i++)
                    TableRow(children: [
                      Text(
                        '${i + 1}',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.item[i]['item'].toString(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.item[i]['quantity'].toString(),
                        textAlign: TextAlign.center,
                      )
                    ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//appworks1302@gmail.com