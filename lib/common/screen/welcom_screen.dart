import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:door_ap/common/model/other/wecome_model.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/social_login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  CarouselController buttonCarouselController = CarouselController();
  late Size size;

  //add all slider data in list
  List<WelcomeModel> welcomeList = [
    WelcomeModel(homeMakeoverImg, MyString.homeMakeoverTitle!, MyString.homeMakeoverDescription!),
    WelcomeModel(qualifiedProfessionalImg, MyString.qualifiedProfessionalTitle!, MyString.qualifiedProfessionalDescription!),
    WelcomeModel(easyServiceImg, MyString.easyServiceTitle!, MyString.easyServiceDescription!)
  ];

  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                         navigateToLoginScreen();
                        },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 56.0, right: 18.0,),
                        child: Text(MyString.skip, style: TextStyle(color: Colors.black, fontSize: MyDimens.textSize18,),),
                      ),
                    )
                  ]
                ),

                SizedBox(height: 30,),

                // Slider
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: CarouselSlider.builder(
                          carouselController: buttonCarouselController,
                          itemCount: welcomeList.length,
                          itemBuilder: (context,index, position ){
                            return MyImageView(welcomeList[index]);
                          },
                          options: CarouselOptions(
                              height: MediaQuery.of(context).size.height,
                              autoPlay: false,
                              viewportFraction: 1.0,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentPos = index;
                                });
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                // Indicator And next button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: welcomeList.map((url) {
                          int index = welcomeList.indexOf(url);
                          return Container(
                            width: 20.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: currentPos == index ? BoxShape.rectangle : BoxShape.circle,
                              color: currentPos == index
                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        if(currentPos != 2){
                          buttonCarouselController.nextPage(
                              duration: Duration(milliseconds: 300), curve: Curves.linear);
                        }else{
                          navigateToLoginScreen();
                        }
                        },
                      child: Container(
                        child: Image(image: forwardArrowImg, height: 194, width: 115,)
                      ),
                    ),

                  ],
                ),

              ]
          ),
        ),
      ),
    );
  }

  ///*
  ///
  ///
  /// 
  void navigateToLoginScreen() {
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SocialLoginScreen()), (route) => false);

  }
}

///slider image view
class MyImageView extends StatelessWidget{

  WelcomeModel welcomeModel;

  MyImageView(this.welcomeModel);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Expanded(child: Image(image: welcomeModel.img, width: MediaQuery.of(context).size.width, height: 236.0,)),

          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Text(welcomeModel.title, style: TextStyle(color: Colors.black, fontSize: MyDimens.textSize22, fontFamily: 'roboto_medium'), textAlign: TextAlign.center,),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding : const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Text(welcomeModel.description, style: TextStyle(color: MyColor.textGrey, fontSize: MyDimens.textSize14, height: 1.1, fontFamily: 'montserrat_medium'), textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
