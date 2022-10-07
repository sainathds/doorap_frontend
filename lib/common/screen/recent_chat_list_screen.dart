import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_ap/common/model/other/firestore_recent_chat_model.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/screen/chat_screen.dart';
import 'package:door_ap/common/utils/firestore_constants.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecentChatListScreen extends StatefulWidget {

  const RecentChatListScreen({Key? key}) : super(key: key);

  @override
  _RecentChatListScreenState createState() => _RecentChatListScreenState();
}

class _RecentChatListScreenState extends State<RecentChatListScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              headerWidget(),

              Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
                      color: Colors.white,
                    ),

                    child: Column(
                      children: [
                        Expanded(
                            child: StreamBuilder<QuerySnapshot> (
                              stream: getRecentChatList(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                return
                                    snapshot.hasData ?
                                        ListView.separated(
                                            itemCount: snapshot.data!.docs.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context, int index) {

                                              // getLatestMsg(snapshot.data!.docs[index]);

                                              return recentChatWidget(snapshot.data!.docs[index]);
                                              },
                                          separatorBuilder: (context, index) {
                                            return Divider(height: 1, color: MyColor.dividerColor, thickness: 0.5,);
                                          },)
                                        : SizedBox();
                              },

                            )
                        )
                      ],
                    ),
                  ))
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

          Text('Messages',
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
  ///
  Widget recentChatWidget(DocumentSnapshot documentSnapshot){

    return
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Card(
                elevation: 5,
                child: Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  child: Text (
                      getDate(documentSnapshot.get(FirestoreConstants.recentTimeStamp)),

                     textAlign: TextAlign.center,
                      style: TextStyle(
                        color: MyColor.labelGrey,
                        fontFamily: 'roboto_bold'
                      ),),
                ),
              ),

              SizedBox(width: 10,),
              Expanded(
                child: InkWell(
                  onTap: (){
                    Get.to(() => ChatScreen(receiverId: documentSnapshot.get(FirestoreConstants.recentUserId) ,
                        receiverName: documentSnapshot.get(FirestoreConstants.recentUserName),
                       callFrom: "",));
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(child: Text(
                            documentSnapshot.get(FirestoreConstants.recentUserName),
                            maxLines: 1,
                            style: TextStyle(
                              color: MyColor.themeBlue,
                              fontFamily: 'roboto_medium'
                            ),
                          )),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              documentSnapshot.get(FirestoreConstants.recentMessage),
                        maxLines: 1,
                              style: TextStyle(
                                  color: MyColor.textGrey,
                                  fontFamily: 'roboto_medium'
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }

  ///*
  ///
  ///
  getRecentChatList() {

     return FirebaseFirestore.instance
        .collection('RecentChat')
        .doc(MySharedPreference.getInt(MyConstants.keyUserId).toString())
        .collection(MySharedPreference.getInt(MyConstants.keyUserId).toString())
        .orderBy(FirestoreConstants.recentTimeStamp, descending: true)
        .snapshots();

  }

  ///*
  ///
  ///
  String getDate(String timeStamp) {

    String formattedDate = '';
    formattedDate = DateFormat('MMM dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp)));
    return formattedDate;
  }

  ///*
  ///
  ///
  getLatestMsg(DocumentSnapshot? documentSnapshot) async {
    FirestoreRecentChatModel? recentChatModel;
    String customDocId;
    int myUid = MySharedPreference.getInt(MyConstants.keyUserId);
    int oppUid = documentSnapshot!.get(FirestoreConstants.recentUserId);


    if (myUid < oppUid) {
      customDocId = myUid.toString() + "_" + oppUid.toString();
    } else {
      customDocId = oppUid.toString() + "_" + myUid.toString();
    }


  }
}
