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

var taskStatus = ["Todo", "Inprogress", "Completed"];

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

