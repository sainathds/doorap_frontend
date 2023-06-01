import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_ap/common/model/other/firestore_user_model.dart';
import 'package:door_ap/common/model/other/firestore_chat_model.dart';
import 'package:door_ap/common/model/request/chat_notification_request.dart' as chatNotificationRequest;
import 'package:door_ap/common/model/response/chat_notification_response.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/firestore_constants.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/screen/customer_btm_screen.dart';
import 'package:door_ap/vendor/screen/vendor_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:encrypt/encrypt.dart' as encrypt;



class ChatScreen extends StatefulWidget {

  int receiverId;
  String receiverName;
  String callFrom;


  ChatScreen({Key? key, required this.receiverId, required this.receiverName, required this.callFrom}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  ScrollController scrollController=ScrollController();
  TextEditingController msgEditController = TextEditingController();
  late int senderId ;


  @override
  void initState() {
    // TODO: implement initState

   /* if(scrollController.hasClients){
      scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(seconds: 1), curve: Curves.easeOut);
    }*/
    senderId = MySharedPreference.getInt(MyConstants.keyUserId); //senderId means current
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
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
                          height: MediaQuery.of(context).size.height * 0.7,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
                            color: Colors.white,
                          ),

                          child: Column(
                            children: [
                              Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: getChatMessage(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot){

                                    return
                                      snapshot.data != null && snapshot.data!.docs.isNotEmpty?
                                      ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          controller: scrollController,
                                          shrinkWrap: true,
                                          reverse: true,
                                          itemBuilder: (context , index){
                                            if(snapshot.data?.docs[index].get(FirestoreConstants.receiverId) == MySharedPreference.getInt(MyConstants.keyUserId)
                                                && snapshot.data?.docs[index].get(FirestoreConstants.isSeen) == false){
                                              //update isSeen value in chat
                                              updateMsgIsSeen(snapshot.data?.docs[index], index);
                                            }
                                            return
                                              showMsgList(context, snapshot.data?.docs[index]);
                                          }): SizedBox();
                                  },),
                              ),

                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: MyColor.themeBlue
                                ),
                                child: TextFormField(
                                  onTap: (){
                                    if(scrollController.hasClients){
                                      scrollController.animateTo(
                                          scrollController.position.minScrollExtent,
                                          duration: const Duration(seconds: 1), curve: Curves.easeOut);
                                    }
                                  },
                                  controller: msgEditController,
                                  cursorColor: Colors.white,
                                  cursorHeight: 20,
                                  keyboardType: TextInputType.multiline,
                                  maxLength: null,
                                  maxLines: null,

                                  textInputAction: TextInputAction.newline,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'montserrat_medium',
                                      fontSize: MyDimens.textSize14
                                  ),

                                  decoration: InputDecoration(
                                      hintText: 'Type here ...',
                                      hintStyle: TextStyle(
                                        color: MyColor.textGrey,
                                        fontFamily: 'montserrat_medium',
                                      ),
                                      border: InputBorder.none,
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            if (msgEditController.text.trim().isNotEmpty) {
                                              String msg = msgEditController.text.trim();
                                              msgEditController.clear();
                                              sendMsg(senderId, widget.receiverId, widget.receiverName, msg);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20.0, right: 10),
                                            child: Icon(Icons.send, size: 30, color: Colors.white,),
                                          ))
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ))
                  ],
                ),
              )
        ),
      ),
    );
  }


  ///*
    ///
    /// show msg list sender and receiver Side
  /// left side indicate Sender Side
  /// right side indicate Receiver Side
  Widget showMsgList(BuildContext context, DocumentSnapshot? documentSnapshot ) {

    if(documentSnapshot != null){
      FirestoreChatModel firestoreChatModel = FirestoreChatModel.fromDocument(documentSnapshot);
      if(firestoreChatModel.senderId == MySharedPreference.getInt(MyConstants.keyUserId)){

        //left side sender side
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.45,),
              margin: EdgeInsets.only(right: 10, top: 15,),
              padding: EdgeInsets.symmetric(vertical: 10.0 , horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: MyColor.chatBlue,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          getDecryptedMsg(firestoreChatModel.message),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: MyColor.themeBlue,
                            fontFamily: 'montserrat_medium'
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5,),
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(
                              int.parse(firestoreChatModel.timeStamp),
                            )),
                        style: TextStyle(
                            color: MyColor.textGrey,
                            fontSize: 12.0,
                             fontFamily: 'roboto_medium'
                        ),
                      ),

                      firestoreChatModel.isSeen?
                      // Text('seen', style: TextStyle(color: Colors.blue),) : SizedBox()
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Image(image: msgRead, width: 15, height: 15,),
                      ) : SizedBox()
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      }else{

        //receiver side
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.45,),
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(left: 10, top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: MyColor.chatGrey,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              getDecryptedMsg(firestoreChatModel.message),
                              style: TextStyle(
                                  color: MyColor.themeBlue,
                                  fontFamily: 'montserrat_medium'
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('HH:mm').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(firestoreChatModel.timeStamp),
                                )),
                            style: TextStyle(
                                color: MyColor.textGrey,
                                fontSize: 12.0,
                                 fontFamily: 'roboto_medium'
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),

          ],
        );
      }
    }else{
      return SizedBox.shrink();
    }

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
                // Navigator.pop(context);
                _onWillPop();
              },
              child: Image(image: backArrowIcon, height: 16.0, width: 18.0, color: Colors.white,)),

          Text(widget.receiverName,
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
  /// save message to Chat Collection in Firestore
  void sendMsg( int senderId, int receiverId,  String receiverName ,String message) {

    String customDocId ;

    if(senderId < widget.receiverId){
      customDocId = senderId.toString() + "_" + widget.receiverId.toString();
    }else{
      customDocId = widget.receiverId.toString() + "_" + senderId.toString();
    }


    //get Chat collection
    DocumentReference documentReference =
    FirebaseFirestore.instance
        .collection('Chat')
        .doc(customDocId)
        .collection(customDocId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    //update All data in FirestoreChatModel
    FirestoreChatModel firestoreChatModel = FirestoreChatModel(
        senderId: senderId,
        receiverId: receiverId,
        senderName: MySharedPreference.getString(MyConstants.keyName),
        receiverName: receiverName,
        timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
        message: getEncryptedMsg(message), //get encrypted message to save
        type: 'Text',
        isSeen: false);



    FirebaseFirestore.instance.runTransaction((transaction) async{
      transaction.set(documentReference, firestoreChatModel.toJson());
    }).then((value){

      if(scrollController.hasClients){
        scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: const Duration(seconds: 1), curve: Curves.easeOut);
      }

      sendNotification(MySharedPreference.getString(MyConstants.keyName), senderId, receiverId, message);
      setRecentChatListTest(firestoreChatModel);

    });

  }


  ///*
  ///
  /// get messages of Sender and receiver
  Stream<QuerySnapshot> getChatMessage() {
    String customDocId ;

    if(senderId < widget.receiverId){
      customDocId = senderId.toString() + "_" + widget.receiverId.toString();

    }else{
      customDocId = widget.receiverId.toString() + "_" + senderId.toString();

    }

    return FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(customDocId)
        .collection(customDocId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .snapshots();
  }



  ///*
  ///
  /// update isSeen param status to True
  Future<void> updateMsgIsSeen(DocumentSnapshot? documentSnapshot, int index) async{

    String customDocId ;

    if(senderId < widget.receiverId){
      customDocId = senderId.toString() + "_" + widget.receiverId.toString();

    }else{
      customDocId = widget.receiverId.toString() + "_" + senderId.toString();

    }

    final query = await FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(customDocId)
        .collection(customDocId)
        .where(FirestoreConstants.receiverId, isEqualTo: MySharedPreference.getInt(MyConstants.keyUserId))
        .where(FirestoreConstants.isSeen, isEqualTo: false)
        .get();


    query.docs[0].reference.update({FirestoreConstants.isSeen: true});

  }


  ///*
  ///
  /// set last message to RecentChat collection
  void setRecentChatListTest(FirestoreChatModel firestoreChatModel) async{

    //set opp. Data in your recentChatList
    //set node of sender
    FirebaseFirestore.instance
        .collection('RecentChat')
        .doc(firestoreChatModel.senderId.toString())
        .collection(firestoreChatModel.senderId.toString())
        .doc(firestoreChatModel.receiverId.toString())
        .set({

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
        .set({

      'recentUserId': firestoreChatModel.senderId,
      'recentUserName': firestoreChatModel.senderName,
      'recentMessage' : firestoreChatModel.message,
      'recentTimeStamp' : firestoreChatModel.timeStamp
    }).then((value) => log('Firestore Recent chat created successfully'));

  }


  ///*
  ///
  /// set RecentChat List for sender and receiver
  /// use to show last message in RecentChatListScreen
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



  ///*
  ///
  /// send notification to Receiver
  void sendNotification(String senderName, int senderId, int receiverId, String message) async{
    FirestoreUserModel receiverUserModel = await getReceiverUserData(receiverId);

    if(receiverUserModel.fcmToken != ''){
      List<String> registrationIds = <String>[receiverUserModel.fcmToken];

      chatNotificationRequest.Notification notification = chatNotificationRequest.Notification(
          title: senderName,
          body: message);

      String userType = '';
      if(receiverUserModel.isCustomer == 'True'){
        userType = 'Customer';
      }else{
        userType = 'Vendor';
      }
      chatNotificationRequest.Data data = chatNotificationRequest.Data(
          orderStatus: '',
          userType: userType,
          imageUrl: '',
          sound: 'alarm.mp3',
          action: 'Chat',
          actionId: senderId.toString(),
          body: message,
          title: senderName,
          clickAction: 'FLUTTER_NOTIFICATION_CLICK',
          androidChannelId: 'noti_push_app_2',
          currentDatetime: DateFormat('yyyy-mm-dd HH:mm:ss').format(DateTime.now())
      );

      chatNotificationRequest.ChatNotificationRequest requestModel =
      chatNotificationRequest.ChatNotificationRequest(
          registrationIds : registrationIds,
          notification: notification,
          data: data);

      var requestBody = json.encode(requestModel);
      log('ChatNotificationRequestBody : ' + requestBody);

      final results = await Request().requestSendPushNotification(
          url: "https://fcm.googleapis.com/fcm/send",
          parameters: json.encode(requestModel),
          context: Get.context);

      if(results != null){
        ChatNotificationResponse responseModel = ChatNotificationResponse.fromJson(results);
        log('sendNotification Response: ' + json.encode(responseModel));
        if(responseModel.success == 1){
          log('sendNotification Success: Chat Notification Send Successfully');
        }
      }
    }


  }

  ///*
  ///
  /// get ReceiverUserData to send Notification
  Future<FirestoreUserModel> getReceiverUserData(int receiverId) async{

    String name = '';
    String email = '';
    String fcmToken = '';
    String isVendor = '';
    String isCustomer = '';
    String userId = '';

    //get user
    QuerySnapshot userData = await FirebaseFirestore.instance
        .collection('Users')
        .where(FirestoreConstants.userId, isEqualTo: receiverId.toString() )
        .get();

    if(userData.docs.isNotEmpty){
      for (QueryDocumentSnapshot document in userData.docs) {
        name = document.get(FirestoreConstants.name);
        email = document.get(FirestoreConstants.email);
        fcmToken = document.get(FirestoreConstants.fcmToken);
        isVendor = document.get(FirestoreConstants.isVendor);
        isCustomer = document.get(FirestoreConstants.isCustomer);
        userId = document.get(FirestoreConstants.userId);

        log('FIREBASE FCM ' + fcmToken);
      }
    }
    return FirestoreUserModel(name: name, email: email, fcmToken: fcmToken, isVendor: isVendor, isCustomer: isCustomer, userId: userId);
  }


  ///*
  ///
  /// on system backPress redirect to HomeScreen according to userRole
  Future<bool> _onWillPop() async{
    if(widget.callFrom == 'Vendor'){
      Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(builder: (context) => VendorHomeScreen() ),
              (route) => false);

    }else if(widget.callFrom == 'Customer'){
      Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(builder: (context) => CustomerBtmScreen() ),
              (route) => false);

    }else{
      Get.back();
    }

    return false;
  }

  ///*
  ///
  /// encrypt message to save on firestore
   getEncryptedMsg(String message) {
    final key = encrypt.Key.fromUtf8(MyString.key32Length);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(message, iv: iv);

    log("Chat messageEncrypted :" + encrypted.base64);
    return encrypted.base64;
  }

  ///*
  ///
  /// decrypt message for show on Ui
  String getDecryptedMsg(String message) {
    final key = encrypt.Key.fromUtf8(MyString.key32Length);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt(encrypt.Encrypted.fromBase64(message), iv: iv);

    log("Chat messageDecrypted :" + decrypted);
    return decrypted;
  }

}
