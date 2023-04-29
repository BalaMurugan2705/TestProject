import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/custom_widget/button.dart';
import 'package:test_project/helper/firebaseHelper.dart';
import 'package:test_project/model/task_model.dart';

import '../helper/utils.dart';
import '../model/userData_model.dart';

class UserCubit extends Cubit<UserDataState> {
  UserCubit() : super(UserDataState());

  //Create  New Task For User
  addTask(Task task, BuildContext context) async {
    emit(state.copyWith(reqState: ReqState.LOADING));
    var res =
        await FirebaseHelper().addData(task, state.taskData?.task?.length ?? 0);
    if (res == "Success") {
      emit(state.copyWith(reqState: ReqState.DONE));
      customToast(
          status: ToastStatusEnum.success,
          message: "Task Added Successfully",
          context: context);
    } else {
      emit(state.copyWith(reqState: ReqState.ERROR));
      customToast(
          status: ToastStatusEnum.error,
          message: "Failed to add Task ",
          context: context);
    }
  }

  //Login as both admin and User
  login(String email, String password, context) async {
    emit(state.copyWith(reqState: ReqState.LOADING));
    state.userData = UserData();
    var data = await FirebaseHelper().getUserData(email, password, context);
    if (data != null) {
      emit(state.copyWith(userData: data, reqState: ReqState.DONE));
      print(state.userData);
      setToken();
      getTaskList(context);
      return data;
    }
    return data;
  }

  //setTokenTo Firebase
  setToken() {
    FirebaseHelper().setUserToken(state.userData?.name, state.token ?? "");
  }

  //Get Task List
  getTaskList(BuildContext context) {
    FirebaseHelper().getTaskData(state.userData?.name ?? "", context);
  }

  //get token from device
  getToken() async {
    var res = await FirebaseHelper().getToken();
    if (res != null) {
      emit(state.copyWith(token: res));
    }
  }

  //set task
  setTaskList(TaskData taskData) {
    state.taskData = taskData;
    emit(state.copyWith(taskData: state.taskData));

    print(state.taskData?.task);
  }

  //update task status
  updateStatus(
      String index, String status, String remarks, BuildContext context) async {
    emit(state.copyWith(reqState: ReqState.LOADING));
    var res = await FirebaseHelper()
        .updateTaskData(state.userData?.name ?? "", index, status, remarks);
    if (res == "Success") {
      emit(state.copyWith(reqState: ReqState.DONE));
      customToast(
          status: ToastStatusEnum.success,
          message: "Successfully Updated",
          context: context);
    } else {
      customToast(
          status: ToastStatusEnum.error,
          message: "Failed to Update",
          context: context);
    }
  }
}

enum ReqState { NONE, LOADING, ERROR, DONE }

class UserDataState {
  int? count = 0;
  UserData? userData;
  TaskData? taskData;
  ReqState? reqState;
  String? token;

  UserDataState(
      {this.count,
      this.userData,
      this.taskData,
      this.token,
      this.reqState = ReqState.NONE});

  UserDataState copyWith(
      {int? count,
      UserData? userData,
      TaskData? taskData,
      String? token,
      ReqState? reqState}) {
    return UserDataState(
        count: count ?? this.count,
        userData: userData ?? this.userData,
        taskData: taskData ?? this.taskData,
        token: token ?? this.token,
        reqState: reqState ?? this.reqState);
  }
}
