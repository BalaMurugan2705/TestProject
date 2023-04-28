import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test_project/custom_widget/button.dart';
import 'package:test_project/helper/utils.dart';
import 'package:test_project/model/task_model.dart';
import 'package:test_project/model/userData_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_cubit.dart';

class FirebaseHelper {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  // bool isCredentialsValid(String username, String password) {
  //   for (var user in json['userlist'].values) {
  //     if (user['userdetails']['username'] == username && user['userdetails']['password'] == password) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  Future<void> addTask(TaskModel data) async {
    return await firestore
        .collection('tasklist')
        .doc(data.assignee)
        .set({
          'taskTitle': data.taskTitle,
          'taskDescription': data.taskDescription,
          'assignee': data.assignee,
          'status': data.status
        })
        .then((value) => print("Task Added"))
        .catchError((error) => print("Failed to add task: $error"));
  }

  // Future<void> getTaskData() async {
  //   final QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //   await firestore.collection('tasklist').get();
  //
  //   final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
  //       querySnapshot.docs;
  //
  //   for (final QueryDocumentSnapshot<Map<String, dynamic>> doc in docs) {
  //     final Map<String, dynamic>? data = doc.data();
  //     print('Document ID: ${doc.id}');
  //     print('Document fields: $data');
  //   }
  // }

  final databaseReference = FirebaseDatabase.instance.ref();

  void addData(TaskModel data, int count) async {
    await databaseReference
        .child("taskList")
        .child("Users")
        .child(data.assignee)
        .child("task")
        .child("$count")
        .set({
      'taskTitle': data.taskTitle,
      'taskDescription': data.taskDescription,
      'assignee': data.assignee,
      'status': data.status
    }).then((value) => print("added"));

    await databaseReference
        .child("taskList")
        .child("Admin")
        .child("task")
        .child("$count")
        .set({
      'taskTitle': data.taskTitle,
      'taskDescription': data.taskDescription,
      'assignee': data.assignee,
      'status': data.status
    }).then((value) => print("added"));
  }

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

  updateTaskData(
      String user, BuildContext context, int index, String status) async {
    await databaseReference
        .child("taskList")
        .child("Users")
        .child(user)
        .child("task")
        .child(index.toString())
        .update({'status': status}).then((value) => print("User Data Updated"));

    await databaseReference
        .child("taskList")
        .child("Admin")
        .child("task")
        .child(index.toString())
        .update({'status': status}).then((value) => print("User Data Updated"));
  }
}
