import 'package:flutter/material.dart';

void hideKeyboard(BuildContext buildContext) {
  FocusScopeNode currentFocus = FocusScope.of(buildContext);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

bool isEmailValid(String email) {
  if (email.isNotEmpty) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return !emailValid;
  }
  return true;
}

class TaskModel {
  String taskTitle;
  String taskDescription;
  String assignee;
  String status;

  TaskModel(
      {this.assignee = "", this.taskDescription = "", this.taskTitle = "",this.status=""});
}
