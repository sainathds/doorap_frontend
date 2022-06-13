import 'package:crm_vidya_scf/models/customer.dart';
import 'package:crm_vidya_scf/models/porder.dart';
import 'package:crm_vidya_scf/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import './item_screen.dart';
import '../services/servicehandle.dart';

//import '../models/Porder.dart';
import '../widgets/Porder_item.dart';

class PorderScreen extends StatefulWidget {
  static const routeName = '/Porder_screen';
  //final String Pordername;
  //PorderScreen({Key? key, required this.Pordername}) : super(key: key);

  const PorderScreen({Key? key}) : super(key: key);

  @override
  State<PorderScreen> createState() => _PorderScreenState();
}

class _PorderScreenState extends State<PorderScreen> {
  List<Color> PorderItemsBackgroundColor = [];
  final TextEditingController _search = TextEditingController();

 // List<Porder> filteredPorder = [];
  List<Porder> filteredPorder = [];

  @override
  void initState() {
    super.initState();

    PorderItemsBackgroundColor.add(const Color(0xffE6F3EC));
    PorderItemsBackgroundColor.add(const Color(0xffE6E6F2));
    PorderItemsBackgroundColor.add(const Color(0xffE4EDF4));
    PorderItemsBackgroundColor.add(const Color(0xffE4DAD9));
  }

  //List<Porder> Porders = [];
  List<Porder> porders = [];

  void onFilter(String value, List<Porder> porders) {
    List<Porder> newPorders = [];
    List<String> filterArray = value.toUpperCase().split("");
    if (filterArray.isNotEmpty &&
        porders.isNotEmpty &&
        _search.text.isNotEmpty) {
      for (var porder in porders) {
        if (porder.PNoStr![0] == filterArray[0]) {
          newPorders.add(porder);
        }
      }
    }
    setState(() {
      filteredPorder = newPorders;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Porder> porders =
        ModalRoute.of(context)!.settings.arguments as List<Porder>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0274BB),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dashboard())),
        ),
        title: Text(
          "Orders",
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
                  onChanged: (value) => onFilter(value, porders),
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
/*
              Column(
                  children: filteredPorder.isEmpty
                      ? porders
                          .map((e) => PorderItem(
                                porder: e,
                                backgroundColor: PorderItemsBackgroundColor[
                                    porders.indexOf(e) % 4],
                              ))
                          .toList()
                      : filteredPorder
                          .map((e) => PorderItem(
                                porder: e,
                                backgroundColor: PorderItemsBackgroundColor[
                                    porders.indexOf(e) % 4],
                              ))
                          .toList()),
*/
            ],
          ),
        ),
      ),
    );
  }
}
