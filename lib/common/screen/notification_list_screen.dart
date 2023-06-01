import 'package:door_ap/common/controller/notification_list_controller.dart';
import 'package:door_ap/common/helperclass/ask_dialog.dart';
import 'package:door_ap/common/model/request/notification_list_request.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NotificationListScreen extends StatefulWidget {
  String userType;

  NotificationListScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {

  NotificationListController _getXController = Get.put(NotificationListController());

  @override
  void initState() {
    // TODO: implement initState
    _getXController.notificationList.clear();
    _getXController.userType = widget.userType;
    _getXController.refreshPage = refreshPage;

    Future.delayed(Duration.zero, (){
      _getXController.hitNotificationListApi();
    });
    super.initState();
  }

  ///*
  ///
  ///
  void refreshPage(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          shadowColor: MyColor.textGrey,
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: MyColor.themeBlue, // Navigation bar
            statusBarColor: MyColor.themeBlue, // Status bar
          ),
          leading: InkWell(
              onTap: (){
                Get.back();
              },
              child: Image(image: backArrowIcon, color: Colors.white,)),
          centerTitle: true,
          title: const Text(
            "Notifications",
            style: TextStyle(
                fontSize: MyDimens.textSize20,
                color: Colors.white,
                fontFamily: 'roboto_medium'),
          ),
          actions: [
            _getXController.notificationList.isNotEmpty?
            InkWell(
              onTap: (){
                showDialog(
                    context: Get.context!,
                    builder: (BuildContext context1)
                      => AskDialog(
                          my_context: Get.context!,
                          msg: "Are you sure? \n Do you want to clear all notifications ?",
                          yesFunction: yesFunction,
                          noFunction: noFunction));
                    },
                child: Center(child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text('Clear', style: TextStyle(
                  fontFamily: 'roboto_medium',
                  color:  Colors.white
              ),),
            )))
                :SizedBox()
          ],
        ),

        body:
        _getXController.notificationList.isNotEmpty?
        ListView.separated(
          itemCount: _getXController.notificationList.length,
            separatorBuilder: (context, index) {
            return Divider(height: 1, color: MyColor.dividerColor, thickness: 0.5,);
            },
            itemBuilder: (BuildContext context, int index){
                       return getNotificationWidget(context, index);
            },
             )
            :
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image : emptyNotification
                ),

                Text('No notification yet',
                  style: TextStyle(
                      color: MyColor.selectedOtp,
                      fontSize: MyDimens.textSize16,
                      fontFamily: 'roboto_bold'
                  ),),

              ],
            ))
        ),
      );
  }


  ///*
  ///
  ///
  Widget getNotificationWidget(BuildContext context, int index) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _getXController.notificationList[index].isSeen! ?
              Image(image: seenNotification,)
             :Image(image: unseenNotification,),

          SizedBox(width: 15,),
          Expanded(
            child: InkWell(
              onTap: (){
                //when user click on notification then first update the seen unseen status and then redirect to Particular screen
                _getXController.hitSeenNotificationApi(index);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getXController.notificationList[index].titleName!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MyDimens.textSize15,
                      fontFamily: 'roboto_bold'
                    ),),

                  Text(
                    _getXController.notificationList[index].notification!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MyDimens.textSize12,
                        fontFamily: 'roboto_medium'
                    ),),

                  Text(
                    _getXController.notificationList[index].notificationDays!,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: MyDimens.textSize12,
                        fontFamily: 'roboto_bold'
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///*
  ///
  /// if user agree to clear all notification then call api
  yesFunction() {
    _getXController.hitClearNotificationApi();
  }

  ///*
  ///
  /// if user not agree to clear all notifications then dismiss pop by cal this function
  noFunction() {
    Navigator.pop(Get.context!);
  }
}
