import 'package:door_ap/common/controller/change_password_controller.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ChangePasswordController _getXController = Get.put(ChangePasswordController());

  @override
  void initState() {
    // TODO: implement initState
    _getXController.clearTextField();
    super.initState();
  }

  void refreshPage(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 33.0),
        child: Column(
          children: [
            //title and back arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image(image: backArrowIcon, height: 16.0, width: 18.0,)),

                Text(MyString.changePassword!,
                  style: const TextStyle(
                      fontSize: MyDimens.textSize20,
                      color: MyColor.themeBlue,
                      fontFamily: 'roboto_bold'
                  ),),

                const SizedBox(height: 16, width: 18,),

              ],),

            ///*
            ///
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(image: changePassImage,),
                  ),


                  //old password
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: oldPasswordField(),
                  ),

                  //new password
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: passwordField(),
                  ),

                  //confirm password
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: confirmPasswordField(),
                  ),

                  ///*
                  /// button
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 35.0),
                    child: ElevatedButton(
                        onPressed: (){
                          _getXController.isDataValid();
                          refreshPage();
                        },
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),),
                            elevation: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(MyString.saveChanges!,
                            style: const TextStyle(
                                fontSize: MyDimens.textSize16,
                                color: Colors.white,
                                fontFamily: 'sf_pro_bold'
                            ),),
                        )),
                  ),


                ],),
              ),
            )



          ],
        ),
      ),
    ));
  }


  ///*
  ///
  ///
  Widget oldPasswordField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.oldPassEditController,
      keyboardType: TextInputType.text,
      obscureText: _getXController.isOldPassObscure,
      textInputAction: TextInputAction.next,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        border: OutlineInputBorder(),
        labelText: MyString.currentPassword,
        labelStyle: labelStyle(),
        hintText: MyString.enterCurrentPassword,
        suffixIcon: IconButton(
          icon: Icon(
            _getXController.isOldPassObscure
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
          ),
          onPressed: () {
            setState(() {
              _getXController.isOldPassObscure = !_getXController.isOldPassObscure;
            });
          },
        ),
        errorText: _getXController.isOldPassEmpty ? "Please Enter Password" : _getXController.isOldPassValid ? "Required minimum 6 character of Password" : null ,

      ),
    );
  }


  ///*
  ///
  Widget passwordField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.passwordEditController,
      keyboardType: TextInputType.text,
      obscureText: _getXController.isPasswordObscure,
      textInputAction: TextInputAction.next,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        border: OutlineInputBorder(),
        labelText: MyString.newPassword,
        labelStyle: labelStyle(),
        hintText: MyString.enterNewPassword,
        suffixIcon: IconButton(
          icon: Icon(
            _getXController.isPasswordObscure
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
          ),
          onPressed: () {
            setState(() {
              _getXController.isPasswordObscure = !_getXController.isPasswordObscure;
            });
          },
        ),
        errorText: _getXController.isPasswordEmpty ? "Please Enter Password" :
                   _getXController.isPasswordValid ? "Required minimum 6 character of Password" :
                   _getXController.isOldNewPassMatch? "Your new password cannot be the same as your current password" :  null ,

      ),
    );
  }


  ///*
  ///
  ///
  Widget confirmPasswordField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.confirmPassEditController,
      keyboardType: TextInputType.text,
      obscureText: _getXController.isConfirmPassObscure,
      textInputAction: TextInputAction.next,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        border: OutlineInputBorder(),
        labelText: MyString.confirmPassword,
        labelStyle: labelStyle(),
        hintText: MyString.enterConfirmPassword,
        suffixIcon: IconButton(
          icon: Icon(
            _getXController.isConfirmPassObscure
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
          ),
          onPressed: () {
            setState(() {
              _getXController.isConfirmPassObscure = !_getXController.isConfirmPassObscure;
            });
          },
        ),
        errorText: _getXController.isConfirmPassEmpty ? "Please Enter Confirm Password" : _getXController.isConfirmPassValid ? "Confirm password doesn't matched" : null ,

      ),
    );

  }


  ///*
  ///
  TextStyle fieldStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize14,
        color: MyColor.fieldGrey,
        fontFamily: 'sf_pro_regular'
    );
  }

  ///*
  ///
  TextStyle labelStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize10,
        color: MyColor.labelGrey,
        fontFamily: 'sf_pro_semibold'
    );
  }


}
