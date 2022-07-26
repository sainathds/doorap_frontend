import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late CollectionReference users;
  String name = '';


  @override
  void initState() {
    // TODO: implement initState

    // users = FirebaseFirestore.instance.collection('Users');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: (){
                createUser();
              },
              child: Text('CreateUser'),
            ),

            SizedBox(height: 10,),
            TextButton(
              onPressed: (){
                UpdateUser();
              },
              child: Text('UpdateUser'),
            ),
          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  void createUser() {

    FirebaseFirestore.instance.collection('Users').doc().set({

      'Email': 'sonali@gmail.com',
      'Name' : 'Sonali',

    }).then((value){
      log('Firestore UserCreated');
    }).catchError((onError) => log('Firestore Exception: ' + onError.toString()));

  }


  ///*
  ///
  ///  first get alredy created user doc id with the help of email id
  void UpdateUser() async{
    log('Firestore getUser');

    //get user
    QuerySnapshot userData = await FirebaseFirestore.instance
        .collection('Users')
        .where('Email', isEqualTo: 'sonali11@gmail.com')
        .get();

    if(userData != null){
      for (var document in userData.docs) {
        log('Firestore documentId: ' + document.id);
        log('Firestore Name: ' + document.get('Name'));
        log('Firestore Email: ' + document.get('Email'));
        updateData(document.id); //firebase user_id
      }
    }

  }

  ///*
  ///
  ///
  void updateData(String firebaseUserId) {

    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUserId)
        .update({
      'Email': 'sonali11@gmail.com'

    }).whenComplete(() => log('Firestore DataUpdated successfully'));

  }
}
