import 'package:flutter/material.dart';
import 'package:test_project/bloc/user_cubit.dart';
import 'package:test_project/custom_widget/dropdown.dart';
import 'package:test_project/helper/nav_helper.dart';
import 'package:test_project/helper/utils.dart';

import '../../custom_widget/button.dart';
import '../../custom_widget/text_field_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  ValueNotifier<String> assignee = ValueNotifier("User1");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add Task",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFieldButton(
                    controller: taskTitle,
                    validate: (val) {
                      if (val!.isEmpty) {
                        return "Please Enter Title";
                      }
                      return null;
                    },
                    onChange: (val) {},
                    inputType: TextInputType.emailAddress,
                    labelText: "Enter Task Title",
                    fontweight: FontWeight.w400,
                    floating: FloatingLabelBehavior.auto,
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter Description",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      TextFieldButton(
                        maxLines: 6,
                        controller: taskDescription,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter Description";
                          }
                          return null;
                        },
                        onChange: (val) {},
                        inputType: TextInputType.emailAddress,
                        fontweight: FontWeight.w400,
                        floating: FloatingLabelBehavior.auto,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Select Assignee",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: assignee,
                  builder: (context, String value, _) {
                    return MyDropdownWidget(
                        items: ["User1", "User2"],
                        selectedValue: value,
                        onChanged: (value) {
                          assignee.value = value ?? "";
                        });
                  }),

            ],
          ),
        ),
      )),
      bottomSheet:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: customButton(
            buttonTitle: "Save",
            onTap: () async{
              var body=TaskModel(
                  taskTitle: taskTitle.text,
                  taskDescription: taskDescription.text,
                  assignee: assignee.value,
                status: "Todo"
              );
              print(body.toString());
              await context.read<UserCubit>().addTask(body);
              back(null);
            }),
      ),
    );
  }
}
