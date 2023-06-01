import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_ap/common/utils/firestore_constants.dart';

class FirestoreChatModel {

  int senderId;
  int receiverId;
  String senderName;
  String receiverName;
  String timeStamp;
  String message;
  String type;
  bool isSeen;


  FirestoreChatModel({ required this.senderId, required this.receiverId, required this.senderName, required this.receiverName,
     required this.timeStamp, required this.message, required this.type, required this.isSeen});


   ///*
  ///
  /// use to send data to firestore
  Map<String, dynamic> toJson(){
    return{
      FirestoreConstants.senderId : senderId,
      FirestoreConstants.receiverId : receiverId,
      FirestoreConstants.senderName : senderName,
      FirestoreConstants.receiverName : receiverName,
      FirestoreConstants.timestamp : timeStamp,
      FirestoreConstants.message : message,
      FirestoreConstants.type : type,
      FirestoreConstants.isSeen : isSeen
    };
  }


  ///*
  ///
  ///
  factory FirestoreChatModel.fromDocument(DocumentSnapshot documentSnapshot){
    int senderId = documentSnapshot.get(FirestoreConstants.senderId);
    int receiverId = documentSnapshot.get(FirestoreConstants.receiverId);
    String senderName = documentSnapshot.get(FirestoreConstants.senderName);
    String receiverName = documentSnapshot.get(FirestoreConstants.receiverName);
    String timeStamp = documentSnapshot.get(FirestoreConstants.timestamp);
    String message = documentSnapshot.get(FirestoreConstants.message);
    String type = documentSnapshot.get(FirestoreConstants.type);
    bool isSeen = documentSnapshot.get(FirestoreConstants.isSeen);


    return FirestoreChatModel(
        senderId: senderId,
        receiverId: receiverId,
        senderName: senderName,
        receiverName: receiverName,
        timeStamp: timeStamp,
        message: message,
        type: type,
        isSeen: isSeen);
  }
}