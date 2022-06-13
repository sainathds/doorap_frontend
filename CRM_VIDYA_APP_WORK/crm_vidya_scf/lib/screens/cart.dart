import 'package:crm_vidya_scf/models/seller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../components.dart';
import 'checkout.dart';

class Cart extends StatefulWidget {
  String seller;
  //final List<String> item;
  //item();

  final CartCallback onGetCart;
  List<Map<String, String>> cart;

  Cart(
      {Key? key,
      required this.cart,
      required this.seller,
      required this.onGetCart});

  @override
  _CartState createState() => _CartState();
}

typedef void CartCallback(_cart);

class _CartState extends State<Cart> {
  String username = "";
  String fullname = "";
  getCurrentUser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    setState(() {
      username = _prefs.getString('username') ?? "";
      fullname = _prefs.getString('fullname') ?? "";
    });
  }

  insertData() async {
    String theUrl = 'https://crmscf.vidyasystems.com/api/gen/testorder.php';
    var res = await http.post(Uri.parse(Uri.encodeFull(theUrl)), headers: {
      "Accept": "application/json"
    }, body: {
      "p_name": "Asmi Studio",
      "p_by": "testBy",
      "i_no": "1",
      "i_name": "testIteminFunction",
      "i_qty": "3",
    });
    var respBody = json.decode(res.body);
    print(respBody);
  }

//https://crmscf.vidyasystems.com/api/gen/testorder.php?partyName=Asmi&itemName=Chandelllar
  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0274BB),
        title: Text(
          "Selected Items",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView.builder(
          itemCount: widget.cart.length,
          itemBuilder: (context, index) {
            var item = widget.cart[index]['item'];
            var quantity = widget.cart[index]['quantity'];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  title: Text(item.toString()),
                  subtitle: Text("quantity: ${quantity.toString()}"),
                  trailing: GestureDetector(
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onTap: () {
                        Map<String, String> item = {
                          "item": widget.cart[index]['item'].toString(),
                          "quantity": widget.cart[index]['quantity'].toString(),
                        };

                        setState(() {
                          widget.cart.removeAt(index);
                          widget.onGetCart(widget.cart);
                        });
                      }),
                ),
              ),
            );
          }),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Button(
                color: Colors.orange,
                text: 'Place order',
                onPressed: () {

                            var now = new DateTime.now();
                    var formatter = new DateFormat('yyyyMMdd');
                    String formattedDate = formatter.format(now);
                    var formatter2 = new DateFormat('hhmmss');
                    String formattedDate2 = formatter2.format(now);
                    String pon = formattedDate + formattedDate2 + username;
                    print(pon); 
                    // print(formattedDate2); 

                  for (var i = 0; i < widget.cart.length; i++) {
                    // insertData();
                    String theUrl =
                        'https://crmscf.vidyasystems.com/api/gen/testorder.php';
                    var res =
                        http.post(Uri.parse(Uri.encodeFull(theUrl)), headers: {
                      "Accept": "application/json"
                    }, body: {
                      "po_no": pon,
                      "p_name": widget.seller,
                      "p_by": username,
                      "i_no": i.toString(),
                      "i_name": widget.cart[i]['item'].toString(),
                      "i_qty": widget.cart[i]['quantity'].toString(),
                    });
                  }

                  // Future<List<mylist>> senddata() async {
                  //print("xxx");
                  //  var url = 'https://crmscf.vidyasystems.com/api/gen/orders.php?PartyName=Naikhil%20chavan&POCreatedBy=Ketan&ItemSrNo=1&ItemName=Super%20fine&ItemQty=3';
                  //  'https://crmscf.vidyasystems.com/api/gen/orders.php';
                  //final response = await http.post(
                  // Uri.parse("http://raushanjha.in/insertdata.php"),

                  //  http.post(Uri.parse(url), body: {
                  //   "PartyName": "Ketan Flutter",
                  //    "POCreatedBy": "Flutter",
                  //    "ItemSrNo": "1",
                  //    "ItemName": "Test Item",
                  //    "ItemQty": "333",
                  //  });
                } //
//PartyName=Nikhil%20chavan&POCreatedBy=Ketan&ItemSrNo=1&ItemName=Super%20fine&ItemQty=1
                //Navigator.push(
                //   context,
                //  MaterialPageRoute(
                //     builder: (context) =>
                //        CheckOut(widget.cart, widget.seller)));
                // },
                ),
          ),
        ],
      ),
    );
  }
}
