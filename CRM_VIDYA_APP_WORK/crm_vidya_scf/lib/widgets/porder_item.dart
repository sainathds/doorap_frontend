import 'package:crm_vidya_scf/screens/select_quantity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/Porder.dart';

//typedef void CartCallback(_cart);

class PorderPorder extends StatelessWidget {
  final Porder porder;
  final CartCallback onCardAdd;

  final Color backgroundColor;
  final String username;

  PorderPorder(
      {Key? key,
      required this.porder,
      required this.backgroundColor,
      required this.username,
      required this.onCardAdd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 20.0),
      height: 50.0,
      decoration: BoxDecoration(
        color:
            backgroundColor, //const Color(0xff43a9f8), //Colors.yellow, //backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  top: 10.0,
                ),
                child: Text(
                 porder.PNoStr!,
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
         // ElevatedButton(
           // onPressed: () async {
            //  showModalBottomSheet(
             //   context: context,
              //  builder: (context) => SingleChildScrollView(
               //   child: Container(
                //    padding: EdgeInsets.only(
                 //       bottom: MediaQuery.of(context).viewInsets.bottom),
                  //  child: SelectQuantity(Porder.PorderName, username, onCardAdd),
                  //),
                //),
              //);
              // setState(() {
              //   widget._cart.add(widget.Porder.PorderName);
              // });
            //},
           // child: Icon(Icons.add, color: Colors.white),
            //style: ElevatedButton.styleFrom(
             // shape: CircleBorder(),
              //padding: EdgeInsets.all(15),
             // primary: Colors.blue, // <-- Button color
              //onPrimary: Colors.red, // <-- Splash color
            //),
          //),
        ],
      ),
    );
  }
}
