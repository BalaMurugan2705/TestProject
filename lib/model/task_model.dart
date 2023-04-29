class TaskData {
  List<Task>? task;

  TaskData({this.task});

  TaskData.fromJson(Map<String, dynamic> json) {
    if (json['task'] != null) {
      task = <Task>[];
     var t = json['task'];
      t['task'].forEach((v) {
        Map<String, dynamic> myMap = {};

        if(v!=null){
          v.forEach((key, value) {
            myMap[key.toString()] = value;
          });
          task!.add(Task.fromJson(myMap));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (task != null) {
      data['task'] = task!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Task {
  String? taskDescription;
  String? assignee;
  String? taskTitle;
  String? status;
  String? remarks;
  String? sNo;
  Task({this.taskDescription, this.assignee, this.taskTitle, this.status,this.remarks,this.sNo});

  Task.fromJson(Map<String, dynamic> json) {
    taskDescription = json['taskDescription'];
    assignee = json['assignee'];
    taskTitle = json['taskTitle'];
    status = json['status'];
    remarks = json['remarks'];
    sNo = json['sNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskDescription'] = taskDescription;
    data['assignee'] = assignee;
    data['taskTitle'] = taskTitle;
    data['status'] = status;
    data['remarks'] = remarks;
    data['sNo'] = sNo;
    return data;
  }
}

