import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_ap/common/model/other/firestore_chat_model.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/utils/firestore_constants.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'chat_screen.dart';

class TestRecentChat extends StatefulWidget {
  const TestRecentChat({Key? key}) : super(key: key);

  @override
  _TestRecentChatState createState() => _TestRecentChatState();
}

class _TestRecentChatState extends State<TestRecentChat> {


  @override
  void initState() {
    // TODO: implement initState

    MySharedPreference.getInstance();
    getRecentChatList();
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
                                  snapshot.hasData && snapshot.data!.docs.isNotEmpty?
                                  ListView.separated(
                                    itemCount: snapshot.data!.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
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
  Widget recentChatWidget(DocumentSnapshot documentSnapshot) {
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
                child: Text(
                  getDate(
                      documentSnapshot.get(FirestoreConstants.recentTimeStamp)),

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
                onTap: () {
                  Get.to(() =>
                      ChatScreen(receiverId: documentSnapshot.get(
                          FirestoreConstants.recentUserId),
                        receiverName: documentSnapshot.get(
                            FirestoreConstants.recentUserName),
                        callFrom: "",));
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text(
                          documentSnapshot.get(
                              FirestoreConstants.recentUserName),
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
                            documentSnapshot.get(
                                FirestoreConstants.recentMessage),
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
  String getDate(String timeStamp) {
    String formattedDate = '';
    formattedDate = DateFormat('MMM dd HH:mm').format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp)));
    return formattedDate;
  }


  ///*
  ///
  ///
  getRecentChatList() {
    Stream<QuerySnapshot> snapshot ;

    snapshot = FirebaseFirestore.instance
        .collection('RecentChat')
        .doc(MySharedPreference.getInt(MyConstants.keyUserId).toString())
        .collection(MySharedPreference.getInt(MyConstants.keyUserId).toString())
        .orderBy(FirestoreConstants.recentTimeStamp, descending: true)
        .snapshots();


    snapshot.forEach((element) {
        if(element.docs.isNotEmpty){
          log('ELEMENT  ' + element.docs[0].get(FirestoreConstants.recentUserName));
          log('ELEMENT  ' + element.docs[0].get(FirestoreConstants.recentMessage));

          log('ELEMENT  ' + element.docs[1].get(FirestoreConstants.recentUserName));
          log('ELEMENT  ' + element.docs[1].get(FirestoreConstants.recentMessage));

          for (int index = 0; index < element.docs.length; index++) {
            getLastMessage(element.docs[index]);
          }
        }

      });

    return snapshot;
  }

  ///*
  ///
  ///
  void getLastMessage(DocumentSnapshot doc) async {
    String customDocId;

    if (MySharedPreference.getInt(MyConstants.keyUserId) <
        doc.get(FirestoreConstants.recentUserId)) {
      customDocId =
          MySharedPreference.getInt(MyConstants.keyUserId).toString() + "_" +
              doc.get(FirestoreConstants.recentUserId).toString();
    } else {
      customDocId = doc.get(FirestoreConstants.recentUserId).toString() + "_" +
          MySharedPreference.getInt(MyConstants.keyUserId).toString();
    }


    await FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(customDocId)
        .collection(customDocId)
        .orderBy(FirestoreConstants.timestamp, descending: false)
        .limitToLast(1)
        .snapshots()
        .forEach((snapshot) {
          if(snapshot.docs.isNotEmpty){
            log('CHAT _LIMIT : ' + snapshot.docs.length.toString());
            log('CHAT _LIMIT : ' + snapshot.docs[0].get(FirestoreConstants.message));

            int position = 0;
            FirestoreChatModel chatModel = FirestoreChatModel(
                senderId: snapshot.docs[position].get(FirestoreConstants.senderId),
                receiverId: snapshot.docs[position].get(FirestoreConstants.receiverId),
                senderName: snapshot.docs[position].get(FirestoreConstants.senderName),
                receiverName: snapshot.docs[position].get(FirestoreConstants.receiverName),
                timeStamp: snapshot.docs[position].get(FirestoreConstants.timestamp),
                message: snapshot.docs[position].get(FirestoreConstants.message),
                type: snapshot.docs[position].get(FirestoreConstants.type),
                isSeen: snapshot.docs[position].get(FirestoreConstants.isSeen));

            updateRecentChatListTest(chatModel);
          }
        });
  }


  ///*
  ///
  ///
  void updateRecentChatListTest(FirestoreChatModel firestoreChatModel) async{

    //set opp. Data in your recentChatList
    //set node of sender
    FirebaseFirestore.instance
        .collection('RecentChat')
        .doc(firestoreChatModel.senderId.toString())
        .collection(firestoreChatModel.senderId.toString())
        .doc(firestoreChatModel.receiverId.toString())
        .update({

      'recentUserId': firestoreChatModel.receiverId,
      'recentUserName': firestoreChatModel.receiverName,
      'recentMessage' : firestoreChatModel.message,
      'recentTimeStamp' : firestoreChatModel.timeStamp
    }).then((value) => log('Firestore Recent chat created successfully'));


    //set your Data in opp. recentChatList
    //here set node of receiver
    FirebaseFirestore.instance
        .collection('RecentChat')
        .doc(firestoreChatModel.receiverId.toString())
        .collection(firestoreChatModel.receiverId.toString())
        .doc(firestoreChatModel.senderId.toString())
        .update({

      'recentUserId': firestoreChatModel.senderId,
      'recentUserName': firestoreChatModel.senderName,
      'recentMessage' : firestoreChatModel.message,
      'recentTimeStamp' : firestoreChatModel.timeStamp
    }).then((value) => log('Firestore Recent chat created successfully'));

  }


}
