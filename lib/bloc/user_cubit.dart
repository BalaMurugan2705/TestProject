import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/helper/firebaseHelper.dart';
import 'package:test_project/model/task_model.dart';

import '../helper/utils.dart';
import '../model/userData_model.dart';

class UserCubit extends Cubit<UserDataState> {
  UserCubit() : super(UserDataState());

addTask(TaskModel taskModel){
  state.taskList ??= [];
  var res=FirebaseHelper().addData(taskModel,state.taskData?.task?.length??0);
}
login(String email, String password,context)async{
  state.userData=UserData();
  var data=await FirebaseHelper().getUserData(email, password,context);
  if(data !=null) {
    emit(state.copyWith(userData: data));
    print(state.userData);
    getTaskList(context);
    return data;
  }
  return data;


}
getTaskList(BuildContext context){
   FirebaseHelper().getTaskData(state.userData?.name??"",context);

}
setTaskList(TaskData taskData){
  state.taskData=taskData;
  emit(state.copyWith(taskData: state.taskData));
  print(state.taskData?.task);
}

}

class UserDataState {
 List<TaskModel>? taskList=[];
 int? count=0;
 UserData ?userData;
 TaskData ? taskData;

 UserDataState({
this.taskList,
   this.count,
   this.userData,
   this.taskData
  });

UserDataState copyWith({
  List<TaskModel>?taskList,
  int? count,
  UserData ?userData,
  TaskData ? taskData

  }) {
    return UserDataState(
      taskList: taskList ?? this.taskList,
      count: count ?? this.count,
      userData: userData ?? this.userData,
      taskData: taskData ?? this.taskData

    );
  }
}
