//import 'package:flutter/material.dart';
//import 'package:http/browser_client.dart'
import 'dart:convert';

import 'package:crm_vidya_scf/models/customer.dart';
import 'package:http/http.dart' as http;

import '../models/seller.dart';
import '../models/item.dart';
import '../models/porder.dart';

class ServerHandler {
  final String _baseUrl = "https://crmscf.vidyasystems.com/api";
  //"https://whoisrishav.com/pk/better-buys/api/gen/sellers";
  //https://${baseUrl}/wp-json/wc/v2/products?category=${categoryId}

  // get list of PO
  Future<List<Porder>> getPorders() async {
    try {
      List<Porder> porders = [];
 
      http.Response response = await http
          //    .get(Uri.parse('https://crmscf.vidyasystems.com/api/gen/mycustomers.php?salesmanid=0'));
          .get(Uri.parse('https://crmscf.vidyasystems.com/api/ktest/pos'));
          
print('test1');
      List polist = (json.decode(response.body))['porders'];
      //  List sellersList = (json.decode(response.body))['customer'];
     
      for (Map m in polist) {
        porders.add(Porder.fromMap(m));
      }

      return porders;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  // get list pf seller
  Future<List<Seller>> getSellers() async {
    try {
      List<Seller> sellers = [];

      http.Response response = await http
          //    .get(Uri.parse('https://crmscf.vidyasystems.com/api/gen/mycustomers.php?salesmanid=0'));
          .get(Uri.parse('https://crmscf.vidyasystems.com/api/gen/sellers'));

      List sellersList = (json.decode(response.body))['sellers'];
      //  List sellersList = (json.decode(response.body))['customer'];

      for (Map m in sellersList) {
        sellers.add(Seller.fromMap(m));
      }

      return sellers;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<List<Customer>> getCustomers() async {
    try {
      List<Customer> customers = [];

      // http.Response response = await http.get(Uri.parse('$_baseUrl/gen/sellers'));

      // List sellersList = (json.decode(response.body))['sellers'];

      http.Response response = await http.get(Uri.parse(
          'https://crmscf.vidyasystems.com/api/gen/mycustomers.php?salesmanid=1'));
      // .get(Uri.parse('https://crmscf.vidyasystems.com/api/gen/sellers'));

      // List sellersList = (json.decode(response.body))['sellers'];
      List sellersList = (json.decode(response.body))['customers'];

      for (Map m in sellersList) {
        customers.add(Customer.fromMap(m));
      }

      return customers;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  // get list pf seller
  Future<List<Item>> getItems() async {
    try {
      List<Item> items = [];

      http.Response response = await http.get(Uri.parse('$_baseUrl/gen/items'));

      List itemsList = (json.decode(response.body))['items'];

      for (Map m in itemsList) {
        items.add(Item.fromMap(m));
      }

      return items;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future getLogin(loginID, password) async {
    List users = [];

    http.Response response = await http.get(Uri.parse(
        //  'http://vidyasystem.innovativebusinesssolution.co.in/userdata_table_api/userdata_table_api/product/read.php'));
        'https://crmscf.vidyasystems.com/api/gen/myusers'));

    //List userList = (json.decode(response.body))['records'];
    List userList = (json.decode(response.body))['success'];

    for (Map m in userList) {
      users.add(m);
    }

    for (Map user in users) {
      if (user["id"] == loginID && user["password"] == password) {
        return user;
      }
    }

    return "Incorrect";
  }
}
