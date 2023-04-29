import 'package:flutter/material.dart';
import 'package:test_project/bloc/user_cubit.dart';
import 'package:test_project/custom_widget/dropdown.dart';
import 'package:test_project/helper/nav_helper.dart';
import 'package:test_project/model/task_model.dart';

import '../../custom_widget/button.dart';
import '../../custom_widget/text_field_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  //Global Key
  final _formKey = GlobalKey<FormState>();

  //TextEditingCOntroller
  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDescription = TextEditingController();

  //ValueNotifier
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add Task",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    titleWidget(),
                    descriptionWidget(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "Select Assignee",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    selectUserDropDown(),
                  ],
                ),
              ),
              BlocBuilder<UserCubit, UserDataState>(builder: (context, state) {
                return Visibility(
                  visible: state.reqState == ReqState.LOADING,
                  child: CircularProgressIndicator(),
                );
              }),
            ],
          ),
        ),
      )),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: customButton(
            buttonTitle: "Save",
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                var body = Task(
                    taskTitle: taskTitle.text,
                    taskDescription: taskDescription.text,
                    assignee: assignee.value,
                    status: "Todo",
                    remarks: "");
                print(body.toString());
                await context.read<UserCubit>().addTask(body, context);
                back(null);
              }
            }),
      ),
    );
  }

  ValueListenableBuilder<String> selectUserDropDown() {
    return ValueListenableBuilder(
        valueListenable: assignee,
        builder: (context, String value, _) {
          return MyDropdownWidget(
              items: ["User1", "User2"],
              selectedValue: value,
              onChanged: (value) {
                assignee.value = value ?? "";
              });
        });
  }

  Card descriptionWidget() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Description",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
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
    );
  }

  Card titleWidget() {
    return Card(
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
    );
  }
}
