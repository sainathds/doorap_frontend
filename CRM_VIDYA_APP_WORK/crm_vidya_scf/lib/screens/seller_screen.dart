import 'package:crm_vidya_scf/models/customer.dart';
import 'package:crm_vidya_scf/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import './item_screen.dart';
import '../services/servicehandle.dart';

//import '../models/seller.dart';
import '../widgets/seller_item.dart';

class SellerScreen extends StatefulWidget {
  static const routeName = '/seller_screen';
  //final String sellername;
  //SellerScreen({Key? key, required this.sellername}) : super(key: key);

  const SellerScreen({Key? key}) : super(key: key);

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  List<Color> sellerItemsBackgroundColor = [];
  final TextEditingController _search = TextEditingController();

 // List<Seller> filteredSeller = [];
  List<Customer> filteredSeller = [];

  @override
  void initState() {
    super.initState();

    sellerItemsBackgroundColor.add(const Color(0xffE6F3EC));
    sellerItemsBackgroundColor.add(const Color(0xffE6E6F2));
    sellerItemsBackgroundColor.add(const Color(0xffE4EDF4));
    sellerItemsBackgroundColor.add(const Color(0xffE4DAD9));
  }

  //List<Seller> sellers = [];
  List<Customer> customers = [];

  void onFilter(String value, List<Customer> customers) {
    List<Customer> newCutomers = [];
    List<String> filterArray = value.toUpperCase().split("");
    if (filterArray.isNotEmpty &&
        customers.isNotEmpty &&
        _search.text.isNotEmpty) {
      for (var customer in customers) {
        if (customer.CustName![0] == filterArray[0]) {
          newCutomers.add(customer);
        }
      }
    }
    setState(() {
      filteredSeller = newCutomers;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Customer> customers =
        ModalRoute.of(context)!.settings.arguments as List<Customer>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0274BB),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dashboard())),
        ),
        title: Text(
          "Select Buyer",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _search,
                  onChanged: (value) => onFilter(value, customers),
                  autofocus: true,
                  style: TextStyle(fontSize: 15.0),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 12.0, top: 0.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
              ),
              Column(
                  children: filteredSeller.isEmpty
                      ? customers
                          .map((e) => SellerItem(
                                customer: e,
                                backgroundColor: sellerItemsBackgroundColor[
                                    customers.indexOf(e) % 4],
                              ))
                          .toList()
                      : filteredSeller
                          .map((e) => SellerItem(
                                customer: e,
                                backgroundColor: sellerItemsBackgroundColor[
                                    customers.indexOf(e) % 4],
                              ))
                          .toList()),
            ],
          ),
        ),
      ),
    );
  }
}
