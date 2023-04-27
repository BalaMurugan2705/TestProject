import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:test_project/screen/admin/add_task_screen.dart';
import 'package:test_project/screen/admin/home_page_admin.dart';
import 'package:test_project/screen/login_screen.dart';
import 'package:test_project/screen/user/user_home_screen.dart';

import 'nav_observer.dart';



const String landingRoute = "/landingRoute";
const String homeScreenAdmin = "/homeScreenAdmin";
const String addTaskScreen = "/addTaskScreen";


const String homeScreenUser = "/homeScreenUser";


Route<Object?>? generateRoute(RouteSettings settings) {
  return getRoute(settings.name);
}

Route<Object?>? getRoute(String? name, {LinkedHashMap? args, Function? result}) {
  switch (name) {
    case landingRoute:
      return MaterialPageRoute(
          builder: (context) =>  LoginScreen(),
          settings: RouteSettings(name: name));
    case homeScreenAdmin:
      return MaterialPageRoute(
          builder: (context) =>  HomePageAdminScreen(),
          settings: RouteSettings(name: name));
    case addTaskScreen:
      return MaterialPageRoute(
          builder: (context) =>  AddTaskScreen(),
          settings: RouteSettings(name: name));
    case homeScreenUser:
      return MaterialPageRoute(
          builder: (context) =>  UserHomeScreen(),
          settings: RouteSettings(name: name));



  }
  return null;
}

openScreen(String routeName,
    {bool forceNew = false,
    bool requiresAsInitial = false,
    LinkedHashMap? args, Function? result}) async {
  var route = getRoute(routeName, args: args, result: result);
  var context = NavObserver.navKey.currentContext;
  if (route != null && context != null) {
    if (requiresAsInitial) {
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else if (forceNew || !NavObserver.instance.containsRoute(route)) {
      Navigator.push(context, route);
    } else {
      Navigator.popUntil(context, (route) {
        if (route.settings.name == routeName) {
          if (args != null) {
            (route.settings.arguments as Map)["result"] = args;
          }
          return true;
        }
        return false;
      });
    }
  }
}

back(LinkedHashMap? args) {
  if (NavObserver.navKey.currentContext != null) {
    Navigator.pop(NavObserver.navKey.currentContext!, args);
  }
}
