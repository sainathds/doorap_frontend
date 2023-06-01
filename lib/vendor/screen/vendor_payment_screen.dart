import 'package:door_ap/common/helperclass/ask_dialog.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/controller/vendor_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VendorPaymentScreen extends StatefulWidget {
  const VendorPaymentScreen({Key? key}) : super(key: key);

  @override
  _VendorPaymentScreenState createState() => _VendorPaymentScreenState();
}

class _VendorPaymentScreenState extends State<VendorPaymentScreen> {

  VendorPaymentController _getXController = Get.put(VendorPaymentController());
  bool _showSecond = false;

  @override
  void initState() {
    // TODO: implement initState

    _getXController.refreshPage = refreshPage;

    Future.delayed(Duration.zero, () async {
      _getXController.hitToGetBalanceApi();
    });
    Future.delayed(Duration.zero, () async {
      _getXController.hitGetReceivedPayment();
    });
    MySharedPreference.getInstance();
    super.initState();
  }

  ///*
  ///
  ///
  refreshPage() {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: _getXController.receivedPaymentList.isNotEmpty? showReceivedPayment():const SizedBox(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: MyColor.themeBlue,
          child: Column(
            children: [

              headerWidget(),

              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
                    color: Colors.white,
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          SizedBox(height: 10.0,),
                          Image(
                            image: paymentImg,
                            height: 200.0,
                          ),

                          SizedBox(height: 5.0,),
                          Text(
                            'Total balance',
                            style: TextStyle(
                              fontSize: MyDimens.textSize15,
                              color: MyColor.textThemeBlue,
                              fontFamily: 'montserrat_semiBold'
                            ),
                          ),


                          SizedBox(height: 5.0,),
                          Text(
                            '\$'+_getXController.totalBalance.toString(),
                            style: TextStyle(
                                fontSize: MyDimens.textSize24,
                                color: MyColor.orangeColor,
                                fontFamily: 'montserrat_semiBold'
                            ),
                          ),


                          SizedBox(height: 5.0,),
                          _getXController.pendingStatus?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  _getXController.pendingAmount,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: MyDimens.textSize20,
                                      color: MyColor.textThemeBlue,
                                      fontFamily: 'montserrat_semiBold',
                                      height: 1.5
                                  ),
                                ),
                              ),
                            ],
                          ):SizedBox(),


                          ///*
                          /// button
                          _getXController.totalBalance != 0.0 && !_getXController.pendingStatus?
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 15.0, bottom: 30.0),
                            child: ElevatedButton(
                                onPressed: (){
                                  showDialog(
                                      context: Get.context!,
                                      builder: (BuildContext context1) => AskDialog(
                                          my_context: Get.context!,
                                          msg: "Do you want to Withdraw of \n \$ ${_getXController.totalBalance} ?",
                                          yesFunction: yesFunction,
                                          noFunction: noFunction));
                                  refreshPage();
                                },
                                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),),
                                    elevation: 5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Text(
                                    'Withdraw',
                                    style: const TextStyle(
                                        fontSize: MyDimens.textSize18,
                                        color: Colors.white,
                                        fontFamily: 'montserrat_medium'
                                    ),),
                                )),
                          ):SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),

              )
            ],
          ),
        ),
      ),

    );
  }


  ///*
  ///
  ///
  headerWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 21.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Image(image: backArrowIcon, height: 16.0, width: 18.0, color: Colors.white,)),

          Text(MyString.payment!,
            style: const TextStyle(
                fontSize: MyDimens.textSize20,
                color: Colors.white,
                fontFamily: 'roboto_medium'
            ),),

          const SizedBox(height: 16, width: 18,),

        ],),
    );

  }




  ///*
  ///
  /// show bottom sheet
  Widget showReceivedPayment() {
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) => AnimatedContainer(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        child: AnimatedCrossFade(
            firstChild: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, top: 10.0, bottom:10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Received Payment",
                          style: TextStyle(
                              fontSize: MyDimens.textSize16,
                              color: Colors.white,
                              fontFamily: 'montserrat_semibold'),
                        ),
                        InkWell(
                            onTap: () {
                              setState(() => _showSecond = true);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: Colors.white,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            secondChild: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 3,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Received Payment",
                          style: TextStyle(
                              fontSize: MyDimens.textSize16,
                              color: Colors.white,
                              fontFamily: 'montserrat_semibold'),
                        ),
                        InkWell(
                            onTap: () {
                              setState(() => _showSecond = false);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: _getXController.receivedPaymentList.length,
                                itemBuilder: (BuildContext context, int index){
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 18),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(getFormattedDate(_getXController.receivedPaymentList[index].paymentReceiveDate!),
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: MyDimens.textSize12,
                                                  fontFamily: 'montserrat_semibold'
                                              ),),
                                          ],
                                        ),


                                        Text('+ \$'+_getXController.receivedPaymentList[index].paymentAmount!.toString(),
                                          style: TextStyle(
                                              color: Colors.green[400],
                                              fontSize: MyDimens.textSize13,
                                              fontFamily: 'montserrat_semibold'
                                          ),),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  )
                ],
              ),
            ),
            crossFadeState: _showSecond
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 400)),
        duration: Duration(milliseconds: 400),
      ),
    );
  }


  ///*
  ///
  ///
  yesFunction(){
    _getXController.hitToWithdrawPayment();
  }


  ///*
  ///
  ///
  noFunction() {
    Navigator.pop(Get.context!);
  }


  ///*
  ///
  ///
  getFormattedDate(String date){
    String bookDateTime = date + " " + '00:00:00';
    String formattedDateTime = '';
    formattedDateTime = DateFormat("dd MMM yyyy")
        .format(DateTime.parse(bookDateTime.toString()));
    return formattedDateTime;
  }

}
