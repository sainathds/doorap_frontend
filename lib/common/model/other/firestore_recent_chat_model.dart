import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_ap/common/utils/firestore_constants.dart';

class FirestoreRecentChatModel{


  String recentUserId;
  String recentUserName;
  String recentMessage;
  String recentTimeStamp;


  FirestoreRecentChatModel({ required this.recentUserId, required this.recentUserName,
    required this.recentMessage, required this.recentTimeStamp});


  Map<String, dynamic> toJson() {

    return {
      FirestoreConstants.recentUserId : recentUserId,
      FirestoreConstants.recentUserName : recentUserName,
      FirestoreConstants.recentMessage : recentMessage,
      FirestoreConstants.recentTimeStamp : recentTimeStamp,
    };
  }


  factory FirestoreRecentChatModel.fromDocument(DocumentSnapshot documentSnapshot){
    String recentUserId = documentSnapshot.get(FirestoreConstants.recentUserId);
    String recentUserName = documentSnapshot.get(FirestoreConstants.recentUserName);
    String recentMessage = documentSnapshot.get(FirestoreConstants.recentMessage);
    String recentTimeStamp = documentSnapshot.get(FirestoreConstants.recentTimeStamp);

    return FirestoreRecentChatModel(
        recentUserId: recentUserId,
        recentUserName: recentUserName,
        recentMessage: recentMessage,
        recentTimeStamp: recentTimeStamp);
  }

  }