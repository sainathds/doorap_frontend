// ignore_for_file: prefer_const_constructors

import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OKDialog extends StatefulWidget {
  // final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final String? title;
  final String? descriptions, text;
  final AssetImage img;

  const OKDialog(
      {required Key? key,
      required this.title,
      required this.descriptions,
      required this.text,
      required this.img})
      : super(key: key);

  @override
  _OKDialogState createState() => _OKDialogState();
}

class _OKDialogState extends State<OKDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // ignore: prefer_const_constructors
      shape: RoundedRectangleBorder(
          // ignore: prefer_const_constructors
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      elevation: 20.0,
      backgroundColor: Colors.white,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    var dialog_context = context;
    return Container(
        width: double.infinity,
        // ignore: avoid_unnecessary_containers, unnecessary_new
        child: new Container(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, bottom: 20, top: 10),
            // ignore: unnecessary_new
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Image(image: widget.img, height: 60, width: 60,),
                    SizedBox(height: 10),
                    widget.title != ""
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  widget.title!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: MyDimens.textSize18,
                                      fontFamily: 'lato_semibold'),
                                ),
                              )
                            ],
                          )
                        : SizedBox(),
                    widget.title != "" ? SizedBox(height: 20) : SizedBox(),
                    widget.descriptions != ""
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  widget.descriptions!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: MyDimens.textSize16,
                                      fontFamily: 'lato_regular'),
                                ),
                              )
                            ],
                          )
                        : SizedBox(),
                    SizedBox(height: 20),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(dialog_context).pop();
                      },
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 40,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColor.themeBlue),
                          child: Center(
                            child: Text("OK",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MyDimens.textSize18,
                                    fontFamily: 'lato_semibold')),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
