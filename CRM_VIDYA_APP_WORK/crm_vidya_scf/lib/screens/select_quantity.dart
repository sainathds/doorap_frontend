import 'package:crm_vidya_scf/models/item.dart';
import 'package:crm_vidya_scf/models/seller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart.dart';

typedef void CartCallback(_cart);

class SelectQuantity extends StatefulWidget {
  SelectQuantity(this.item, this.username, this.onCardAdd);
  final CartCallback onCardAdd;
  final String item;

  final String username;

  @override
  _SelectQuantityState createState() => _SelectQuantityState();
}

class _SelectQuantityState extends State<SelectQuantity> {
  List<Map<String, String>> CartT = [];
  late String quantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select Quantity',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(widget.item),
            TextField(
              keyboardType: TextInputType.number,
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                quantity = newText;
              },
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.lightBlueAccent,
              onPressed: () {
                setState(() {
                  Map<String, String> items = {
                    "item": widget.item,
                    "quantity": quantity
                  };
                  CartT.add(items);
                  widget.onCardAdd(items);
                });
                Navigator.of(context).pop();

                final snackBar =
                    SnackBar(content: const Text('Item added to cart'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        ),
      ),
    );
  }
}
