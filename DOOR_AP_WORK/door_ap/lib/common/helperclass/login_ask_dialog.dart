import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:flutter/material.dart';

class LoginAskDialog extends StatelessWidget {

  BuildContext my_context;
  Function vendorFunction;
  Function customerFunction;


  LoginAskDialog({
    required this.my_context,
    required this.vendorFunction,
    required this.customerFunction});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image(image: questionImage , height: 50, width: 50,),
          ),

          Text("Do you want to continue as ", style: labelStyle(),),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

                Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
                  margin: const EdgeInsets.only(bottom: 20.0, top: 15.0, right: 15, left: 15.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: MyColor.selectedOtp
                  ),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).pop(); // To close the dialog
                      vendorFunction.call();
                    },
                    child: Text("Vendor",  style: titleStyle(),),
                  ),
                ),
              ),

              const Text("OR", style: TextStyle(
                  fontSize: MyDimens.textSize14,
                  color: MyColor.labelGrey,
                  fontFamily: 'sf_pro_semibold'
              )),

              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
                  margin: const EdgeInsets.only(bottom: 20.0, top: 15.0, left: 15, right: 15.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: MyColor.selectedOtp
                  ),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).pop(); // To close the dialog
                      customerFunction.call();
                    },
                    child: Text("Customer",  textAlign: TextAlign.center,  style: titleStyle(), ),
                  ),
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}

///*
///
TextStyle labelStyle() {
  return const TextStyle(
      fontSize: MyDimens.textSize18,
      color: MyColor.labelGrey,
      fontFamily: 'sf_pro_semibold'
  );
}
  ///*
  ///
  TextStyle titleStyle() {
    return const TextStyle(
        fontSize: MyDimens.textSize16,
        color: MyColor.themeBlue,
        fontFamily: 'sf_pro_semibold'
    );

}
