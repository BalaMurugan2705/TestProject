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

enum ToastStatusEnum { success, warning, error }

status(String value) {
  List<String> sample = [];
  switch (value) {
    case "Todo":
      sample = ["InProgress", "Completed"];
      break;
    case "InProgress":
      sample = ["Todo", "Completed"];
      break;
    case "Completed":
      sample = ["Todo", "InProgress"];
      break;
    default:
      sample = ["Todo", "InProgress", "Completed"];
      break;
  }
  return sample;
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class TaskModel {
  String taskTitle;
  String taskDescription;
  String assignee;
  String status;

  TaskModel(
      {this.assignee = "",
      this.taskDescription = "",
      this.taskTitle = "",
      this.status = ""});
}
