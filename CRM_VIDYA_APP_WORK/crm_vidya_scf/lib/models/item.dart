import 'package:flutter/material.dart';

class Item {
  int? ItemID;
  late String ItemName;
  String? ItemDesc;
  double? MRP;
  double? Rate;
  String? Unit;
  double? Weight;
  String? ItemGroup;

  Item.fromMap(Map<dynamic, dynamic> map) {
    ItemID = int.parse(map['ItemID']);
    ItemName = map['ItemName'];
    ItemDesc = map['ItemDesc'];
    MRP = double.parse(map['MRP']);
    Rate = double.parse(map['Rate']);
    Unit = map['Unit'];
    Weight = double.parse(map['Weight']);
    ItemGroup = map['ItemGroup'];
  }

  // ignore: non_constant_identifier_names
  //Item({required this.ItemName});
}
