import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/io_client.dart';
import 'package:test_project/custom_widget/button.dart';
import 'package:test_project/helper/constant.dart';
import 'package:test_project/helper/utils.dart';
import 'package:test_project/model/task_model.dart';
import 'package:test_project/model/userData_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_cubit.dart';

class FirebaseHelper {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //getTokenFromDevice
  getToken() async {
    String? tokenData = "";
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.getToken().then((token) {
      print(token);
      tokenData = token;
    });
    return tokenData;
  }

  //Login and get UserData
  getUserData(String email, String password, context) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection('users').get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          querySnapshot.docs;
      UserData userData = UserData();
      for (final QueryDocumentSnapshot<Map<String, dynamic>> doc in docs) {
        final Map<String, dynamic> data = doc.data();
        if ((doc.get("email") == email) && (doc.get("password") == password)) {
          userData = UserData.fromJson(data);
          return userData;
        }
      }
      customToast(
          status: ToastStatusEnum.error,
          message: "Please enter Valid Credentials",
          context: context);
      return null;
    } catch (e) {
      customToast(
          status: ToastStatusEnum.error,
          message: "Please enter Valid Credentials",
          context: context);
      return null;
    }
  }

  final databaseReference = FirebaseDatabase.instance.ref();

//Task Creation
  addData(Task data, int count) async {
    String res = "";
    await databaseReference
        .child("taskList")
        .child("Users")
        .child(data.assignee ?? "")
        .child("task")
        .child("$count")
        .set({
      "sNo": "$count",
      'taskTitle': data.taskTitle,
      'taskDescription': data.taskDescription,
      'assignee': data.assignee,
      'status': data.status,
      'remarks': ""
    }).then((value) => print("added"));

    await databaseReference
        .child("taskList")
        .child("Admin")
        .child("task")
        .child("$count")
        .set({
      "sNo": "$count",
      'taskTitle': data.taskTitle,
      'taskDescription': data.taskDescription,
      'assignee': data.assignee,
      'status': data.status,
      'remarks': ""
    }).then((value) => res = "Success");
    sendPushNotification(data.assignee??"");
    return res;
  }

  //getTaskData
  getTaskData(String user, BuildContext context) {
    if (user == "Admin") {
      databaseReference
          .child("taskList")
          .child(user)
          .onValue
          .listen((DatabaseEvent event) async {
        print('Data : ${event.snapshot.value}');
        Map<String, dynamic> data = {"task": event.snapshot.value};
        BlocProvider.of<UserCubit>(context)
            .setTaskList(TaskData.fromJson(data));
      });
    } else {
      databaseReference
          .child("taskList")
          .child("Users")
          .child(user)
          .onValue
          .listen((DatabaseEvent event) async {
        print('Data : ${event.snapshot.value}');
        Map<String, dynamic> data = {"task": event.snapshot.value};
        BlocProvider.of<UserCubit>(context)
            .setTaskList(TaskData.fromJson(data));
      });
    }
  }

  //updateTask
  updateTaskData(
      String user, String index, String status, String remarks) async {
    var data;
    await databaseReference
        .child("taskList")
        .child("Users")
        .child(user)
        .child("task")
        .child(index.toString())
        .update({
      'status': status,
      "remarks": remarks,
    }).then((value) => print("User Data Updated"));

    await databaseReference
        .child("taskList")
        .child("Admin")
        .child("task")
        .child(index.toString())
        .update({
      'status': status,
      "remarks": remarks,
    }).then((value) => data = "Success");

    return data;
  }

  //setTokenTo server
  void setUserToken(String? name, String token) async {
    await firestore.collection('users').doc(name).update({"token": token}).then(
        (value) => debugPrint("tokenAdded$token"));
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //send Push Notification
  void sendPushNotification(String user) async {
    try {
      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      String? token = await getUserToken(user);

      final message = {
        'notification': {
          'title': "Notification From Admin",
          'body': "Admin Added New task",
          'click_actiobn': 'FLUTTER_NOTIFICATION_CLICK'
        },
        'to': token,
      };

      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final https = new IOClient(ioc);

      final response = await https.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': apiKey,
        },
        body: jsonEncode(message),
      );

      print("Success");
    } catch (e) {
      print('Error sending push notification: $e');
    }
  }

  //get token for Push Notification
  getUserToken(String user) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection('users').get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          querySnapshot.docs;
      UserData userData = UserData();
      for (final QueryDocumentSnapshot<Map<String, dynamic>> doc in docs) {
        final Map<String, dynamic> data = doc.data();
        if ((doc.get("name") == user)) {
          String token = doc.get("token");
          return token;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
