import 'package:flutter_bloc/flutter_bloc.dart';

import '../helper/utils.dart';

class UserCubit extends Cubit<UserDataState> {
  UserCubit() : super(UserDataState(taskList: []));

addTask(TaskModel taskModel){
  state.taskList ??= [];
  state.taskList?.add(taskModel);
  emit(state.copyWith(taskList: state.taskList));
}

}

class UserDataState {
 List<TaskModel>? taskList=[];

 UserDataState({
this.taskList

  });

UserDataState copyWith({
  List<TaskModel>?taskList,

  }) {
    return UserDataState(
      taskList: taskList ?? this.taskList

    );
  }
}
