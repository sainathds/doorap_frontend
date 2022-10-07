import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_ap/common/utils/firestore_constants.dart';

class FirestoreUserModel{

  String name = '';
  String email = '';
  String fcmToken = '';
  String isVendor = '';
  String isCustomer = '';

  String userId = '';

  FirestoreUserModel({ required this.name, required this.email, required this.fcmToken, required this.isVendor,
    required this.isCustomer, required this.userId});


  ///
  ///
  ///
  Map<String, dynamic> toJson(){

    return {
      FirestoreConstants.userId : userId,
      FirestoreConstants.name : name,
      FirestoreConstants.email : email,
      FirestoreConstants.fcmToken : fcmToken,
      FirestoreConstants.isVendor : isVendor,
      FirestoreConstants.isCustomer : isCustomer,
    };
  }


   ///
   ///
  ///
 factory FirestoreUserModel.fromDocument(DocumentSnapshot documentSnapshot){

   String userId = documentSnapshot.get(FirestoreConstants.userId);;
   String name = documentSnapshot.get(FirestoreConstants.name);
   String email = documentSnapshot.get(FirestoreConstants.email);
   String fcmToken = documentSnapshot.get(FirestoreConstants.fcmToken);
   String isVendor = documentSnapshot.get(FirestoreConstants.isVendor);
   String isCustomer = documentSnapshot.get(FirestoreConstants.isCustomer);

   return FirestoreUserModel(
       name: name,
       email: email,
       fcmToken: fcmToken,
       isVendor: isVendor,
       isCustomer: isCustomer,
       userId: userId);
 }


}