import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/controller/vendor_bank_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VendorBankAccountScreen extends StatefulWidget {
  const VendorBankAccountScreen({Key? key}) : super(key: key);

  @override
  _VendorBankAccountScreenState createState() => _VendorBankAccountScreenState();
}

class _VendorBankAccountScreenState extends State<VendorBankAccountScreen> {

  VendorBankAccountController _getXController = VendorBankAccountController();

  @override
  void initState() {
    // TODO: implement initState
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: MyColor.themeBlue,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 21.0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Image(image: backArrowIcon, height: 16.0, width: 18.0, color: Colors.white,)),

                  Text(MyString.bankAccount!,
                    style: const TextStyle(
                        fontSize: MyDimens.textSize20,
                        color: Colors.white,
                        fontFamily: 'roboto_medium'
                    ),),

                  const SizedBox(height: 16, width: 18,),

                ],),
              ),


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
                          Image(image: bankImg, height: 250.0, width: 181.0,),

                          Padding(
                            padding: const EdgeInsets.only(top: 22.0),
                            child: accountNoField(),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 22.0),
                            child: confirmAccNoField(),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 22.0),
                            child: holderNameField(),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 22.0),
                            child: ifscCodeField(),
                          ),

                          ///*
                          /// button
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 40.0),
                            child: ElevatedButton(
                                onPressed: (){
                                  _getXController.isBankDataValid();
                                  refreshPage();
                                },
                                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),),
                                    elevation: 5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Text(MyString.submit!,
                                    style: const TextStyle(
                                        fontSize: MyDimens.textSize20,
                                        color: Colors.white,
                                        fontFamily: 'montserrat_medium'
                                    ),),
                                )),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }


  ///*
  /// Mobile no Field
  Widget accountNoField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllFieldToFalse();
        });
      },
      controller: _getXController.accountNoEditController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      textInputAction: TextInputAction.next,
      focusNode: _getXController.accountNoFocus,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        border: OutlineInputBorder(),
        labelText: MyString.accountNo,
        labelStyle: labelStyle(),
        hintText: MyString.enterYourAccountNo,
        errorText: _getXController.isAccountNoEmpty ? "Please Enter Account no" : null ,
      ),
      onEditingComplete: (){
        _getXController.confirmAccNoFocus.requestFocus();
      },
    );
  }

  ///*
  ///
  ///
  Widget confirmAccNoField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllFieldToFalse();
        });
      },
      controller: _getXController.confirmAccNoEditController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      textInputAction: TextInputAction.next,
      focusNode: _getXController.confirmAccNoFocus,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        border: OutlineInputBorder(),
        labelText: MyString.confirmAccountNo,
        labelStyle: labelStyle(),
        hintText: MyString.enterYourAccountNo,
        errorText: _getXController.isConfirmAccNoEmpty ? "Please Enter Confirm Account no" : _getXController.isConfirmAccNoValid ? "Confirm account no doesn't matched" : null ,
      ),
      onEditingComplete: (){
        _getXController.holderNameFocus.requestFocus();
      },
    );
  }

  ///*
  ///
  ///
  Widget holderNameField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllFieldToFalse();
        });
      },
      controller: _getXController.holderNameEditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _getXController.holderNameFocus,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        border: OutlineInputBorder(),
        labelText: MyString.accountHoldersName,
        labelStyle: labelStyle(),
        hintText: MyString.enterName,
        errorText: _getXController.isHolderNameEmpty ? "Please Enter Name" : null ,
      ),
      onEditingComplete: (){
        _getXController.ifscCodeFocus.requestFocus();
      },
    );

  }

  ///*
  ///
  ///
  Widget ifscCodeField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllFieldToFalse();
        });
      },
      controller: _getXController.ifscCodeEditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _getXController.ifscCodeFocus,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        border: OutlineInputBorder(),
        labelText: MyString.ifscCode,
        labelStyle: labelStyle(),
        hintText: MyString.enterIfscCode,
        errorText: _getXController.isIfscCodeEmpty ? "Please Enter IFSC Code" : null ,
      ),
    );

  }


  ///*
  ///
  TextStyle fieldStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize15,
        color: MyColor.fieldGrey,
        fontFamily: 'montserrat_regular'
    );
  }

  ///*
  ///
  TextStyle labelStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize12,
        color: MyColor.themeBlue,
        fontFamily: 'montserrat_regular'
    );
  }




}
