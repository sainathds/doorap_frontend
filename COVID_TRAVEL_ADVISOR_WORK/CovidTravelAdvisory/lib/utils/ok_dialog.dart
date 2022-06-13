import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OKDialogBox extends StatelessWidget {

  final String? title, description;
  final Image? image;
  final BuildContext? my_context;
   BuildContext? dialog_context;

  OKDialogBox({
    @required this.title,
    @required this.description,
    this.image,
    @required this.my_context,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    dialog_context = context;
    return Container(
        width: double.infinity,
        child: new Container(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, bottom: 20, top: 10),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Center(
                      child: Image.asset(
                        'assets/images/infoicon.png',
                        height: 70.0,
                        width: 70.0,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //SizedBox(width: 10),
                        Flexible(
                          child: new Text(
                            title!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                height: 1.1,
                                fontFamily: 'normal'),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 0),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 00, left: 20, right: 00, top: 30),
                      height: 35,
                      width: 150,
                      decoration: gradientDecoration,
                      child: RaisedButton(
                        color: Colors.transparent,
                        elevation: 0.0,
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'LatoBold',
                            letterSpacing: 0,
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        splashColor: Colors.white,
                        onPressed: () {
                          Navigator.of(dialog_context!).pop();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  BoxDecoration gradientDecoration = const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0XFFF55151),
          Color(0xfffbb7b7),
          Color(0xfff76e6e),
        ],
      ),
      borderRadius: BorderRadius.all(Radius.circular(80.0)));
}
