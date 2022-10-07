// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:door_ap/common/resources/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final BuildContext my_context;
  BuildContext? dialog_context;
  Function okBtnFunction;
  final AssetImage img;

  CustomDialog({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.img,
    required this.okBtnFunction,
    required this.my_context,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: new Color(0xff202020),
      child: Container(
        padding: EdgeInsets.only(
          top: 10.0 + 16,
          bottom: 16,
          left: 16,
          right: 16,
        ),
        margin: EdgeInsets.only(top: 6),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.white70,
              blurRadius: 0.0,
              offset: const Offset(0.0, 0.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,// To make the card compact
          children: <Widget>[
            Center(
             child: Image(image: img, height: 60, width: 60,),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            description == "" ? SizedBox() : SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    description ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(
                          bottom: 00, left: 20, right: 20, top: 30),
                      height: 35,
                      width: 150,
                      child: RaisedButton(
                        color: MyColor.themeBlue,
                        elevation: 0.0,
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'LatoBold',
                            letterSpacing: 0,
                          ),
                        ),
                        // ignore: unnecessary_new
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        splashColor: Colors.white,
                        onPressed: () {
                          if (okBtnFunction == null) {
                            Navigator.of(context).pop(); // To close the dialog
                          } else {
                            Navigator.of(context).pop(); // To close the dialog
                            okBtnFunction.call();
                          }
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
