import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../screens/item_screen.dart';
//import '../models/seller.dart';
import '../services/servicehandle.dart';
import '../models/items_screen_args.dart';
import '../models/customer.dart';

class SellerItem extends StatefulWidget {
  // final Seller seller;
  final Customer customer;
  final Color backgroundColor;

  const SellerItem(
      // {Key? key, required this.seller, required this.backgroundColor})
      //: super(key: key);
      {Key? key,
      required this.customer,
      required this.backgroundColor})
      : super(key: key);

  @override
  State<SellerItem> createState() => _SellerItemState();
}

class _SellerItemState extends State<SellerItem> {
  void getItems() {
    ServerHandler()
        .getItems()
        .then((value) => Navigator.of(context).popAndPushNamed(
              ItemScreen.routeName,
              arguments: ItemScreenArguments(value, widget.customer.CustName!),
            ))
        .catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 20.0),
      height: 120.0,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  top: 15.0,
                ),
                child: Text(
                  //widget.seller.name!,
                  widget.customer.CustName!,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(  padding: const EdgeInsets.only(
                  left: 15.0,
                  top: 15.0,
                ),
                child: Text(
                  'Current O/S    : ' + widget.customer.ClosingBal!,
                  textAlign: TextAlign.left,
                 style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    
                 ),
                ),
                
                ),
              Text('Overdue Amount :' + widget.customer.Bal2!),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              getItems();
            },
            child: Icon(Icons.arrow_right, color: Colors.white),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(15),
              primary: Colors.blue, // <-- Button color
              onPrimary: Colors.red, // <-- Splash color
            ), //const Text('Enabled'),
          ),
        ],
      ),
    );
  }
}
