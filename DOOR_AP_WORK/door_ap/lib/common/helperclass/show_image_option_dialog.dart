import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ShowImageOptionDialog{
  Function galleryFunction;
  Function cameraFunction;
  BuildContext context;

  ShowImageOptionDialog({required this.context, required this.galleryFunction, required this.cameraFunction}){
    showImageDialog();
  }

  showImageDialog() {
      return showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      galleryFunction.call();
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.image, color: MyColor.themeBlue, size: 40.0,),
                        SizedBox(width: 5.0,),
                        Text('Gallery',style: TextStyle(fontSize: MyDimens.textSize16, color: MyColor.themeBlue, fontFamily: 'montserrat_semiBold')),
                      ],
                    ),
                  ),


                  InkWell(
                    onTap: (){
                      cameraFunction.call();
                      Navigator.pop(context);
                    },
                    child: Row(
                      children:  [
                        Icon(Icons.add_a_photo, color: MyColor.themeBlue, size: 40.0,),
                        SizedBox(width: 5.0,),
                        Text('Camera', style: TextStyle(fontSize: MyDimens.textSize16, color: MyColor.themeBlue, fontFamily: 'montserrat_semiBold')),
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.cancel, color: MyColor.themeBlue, size: 40.0,),
                        SizedBox(width: 5.0,),
                        Text('Cancel', style: TextStyle(fontSize: MyDimens.textSize16, color: MyColor.themeBlue, fontFamily: 'montserrat_semiBold')),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
  }
}

