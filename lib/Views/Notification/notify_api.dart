import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
 Future<void> handleMsg(RemoteMessage message)async {
  print('title:${message.notification?.title}');
    print('Body:${message.notification?.body}');
        print('Payload:${message.data}');


  }
class FirebaseApi{
  final message=FirebaseMessaging.instance;

  Future<void> Notifications()async{
    await message.requestPermission();
    final msgToken=await message.getToken();
    print('Token:$msgToken');
FirebaseMessaging.onBackgroundMessage(handleMsg);

  }

 
}