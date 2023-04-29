import 'package:flutter/material.dart';
import 'package:test_project/custom_widget/button.dart';
import 'package:test_project/custom_widget/text_field_input.dart';
import 'package:test_project/helper/nav_helper.dart';
import 'package:test_project/helper/utils.dart';
import 'package:test_project/model/task_model.dart';
import 'package:test_project/model/userData_model.dart';

import '../../bloc/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../custom_widget/dropdown.dart';

customModalBottomSheet(BuildContext context, Task? task, UserData? userData,{int? index}) {

  //TextEditingController
  TextEditingController remarks = TextEditingController(text: task?.remarks);

  //ValueNotifier
  ValueNotifier<String> statusChanger =
      ValueNotifier(task?.status.toString().toTitleCase() ?? "");
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Task Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    "Task Title",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: Text(
                    task?.taskTitle ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    "Task Description",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: Text(
                    task?.taskDescription ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: task?.remarks != "",
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      "Remarks",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: Text(
                      task?.remarks ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: task?.remarks == "" && userData?.isAdmin == false,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Remarks",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFieldButton(
                          controller: remarks,
                          labelText: "Enter Remarks",
                          floating: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: userData?.isAdmin == false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Status",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: ValueListenableBuilder(
                          valueListenable: statusChanger,
                          builder: (context, String val, _) {
                            return MyDropdownWidget(
                                items: taskStatus,
                                selectedValue: val,
                                color: statusChanger.value == "Completed"
                                    ? Colors.lightGreenAccent
                                    : statusChanger.value == "Inprogress"
                                        ? Colors.amber
                                        : Colors.grey,
                                onChanged: (value) {
                                  statusChanger.value = value!;
                                });
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: userData?.isAdmin ==false,
              child: ValueListenableBuilder(
                valueListenable: statusChanger,
                builder: (context,String val,_) {
                  return customButton(
                    onTap: (){
                      if((remarks.text.isNotEmpty) ||
                          (statusChanger.value != task?.status)) {
                        context.read<UserCubit>().updateStatus(task?.sNo??"", val, remarks.text, context);
                        back(null);
                      }
                    },
                      buttonTitle: "Save Changes",
                      color: ((remarks.text.isEmpty) &&
                              (statusChanger.value == task?.status)
                          ? Colors.grey
                          : Colors.black));
                }
              ),
            )
          ],
        ),
      );
    },
  );
}
