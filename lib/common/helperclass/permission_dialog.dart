import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:flutter/material.dart';

class PermissionDialog extends StatelessWidget {
   BuildContext my_context;
   String msg;
   Function okFunction;
   Function cancelFunction;

  PermissionDialog({
    required this.my_context,
    required this.msg,
    required this.okFunction,
    required this.cancelFunction});

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
            child: Image(image: questionImage, height: 50, width: 50,),
          ),

          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, bottom: 0.0),
            child: Text(msg,
                textAlign: TextAlign.center,
                style: labelStyle()),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 35,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: MyColor.themeBlue),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                      okFunction.call();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.transparent),
                        elevation: MaterialStateProperty.all(0)),
                    child: Text("Ok",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MyDimens.textSize16,
                            fontFamily: 'lato_semibold'))),
              ),

              Container(
                width: 90,
                height: 35,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: MyColor.selectedOtp),
                child: ElevatedButton(
                    onPressed: () {
                      cancelFunction.call();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.transparent),
                        elevation: MaterialStateProperty.all(0)),
                    child: Text("Cancel",
                        style: TextStyle(
                            color: MyColor.themeBlue,
                            fontSize: MyDimens.textSize16,
                            fontFamily: 'lato_semibold'))),
              ),
            ],
          )
        ],
      ),
    );
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

}
