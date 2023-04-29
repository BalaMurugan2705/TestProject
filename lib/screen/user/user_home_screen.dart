import 'package:flutter/material.dart';
import 'package:test_project/custom_widget/dropdown.dart';
import 'package:test_project/custom_widget/text_field_input.dart';
import 'package:test_project/helper/dialog_helper.dart';
import 'package:test_project/helper/firebaseHelper.dart';
import 'package:test_project/helper/nav_helper.dart';
import 'package:test_project/helper/utils.dart';

import '../../bloc/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../custom_widget/button.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.read<UserCubit>().getTaskList(context);
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          actions: [
            IconButton(
                onPressed: () {
                  openScreen(landingRoute, requiresAsInitial: true);
                },
                icon: const Icon(Icons.login)),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<UserCubit, UserDataState>(
                builder: (context, state) {
              var dataSource = UserdataSource(context, state);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * (0.05)),
                      child: Text(
                        "Welcome, ${state.userData?.name ?? ""}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 24),
                      ),
                    ),
                    taskTable(state, dataSource),
                    Visibility(
                        visible: ((state.taskData?.task?.length == null) ||
                            (state.taskData?.task?.length == 0)),
                        child: const Center(
                            child: Text(
                          "No Task Assigned yet",
                          style: TextStyle(fontSize: 18),
                        ))),
                  ],
                ),
              );
            }),
          ),
        ));
  }

  Visibility taskTable(UserDataState state, UserdataSource dataSource) {
    return Visibility(
      visible: state.taskData?.task?.length != null,
      child: PaginatedDataTable(
          onPageChanged: (int index) {},
          rowsPerPage: (state.taskData?.task?.length ?? 1) > 0
              ? (state.taskData?.task?.length ?? 1)
              : 1,
          showCheckboxColumn: false,
          columns: const [
            DataColumn(
              label: Flexible(
                flex: 1,
                child: Text(
                  "Task Name",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ),
            ),
            DataColumn(
              label: Flexible(
                flex: 1,
                child: Text(
                  "Assignee",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ),
            ),
            DataColumn(
              label: Flexible(
                flex: 1,
                child: Text(
                  "Status",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ),
            ),
          ],
          source: dataSource),
    );
  }
}

class UserdataSource extends DataTableSource {
  BuildContext context;
  UserDataState? state;

  UserdataSource(
    this.context,
    this.state,
  );

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (val) {
        customModalBottomSheet(
            context, state!.taskData?.task![index], state?.userData,
            index: index);
        //     state?.userData?.name ?? "", context, index, "completed");
      },
      cells: [
        DataCell(
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              state!.taskData?.task![index].taskTitle ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ),
        ),
        DataCell(
          Text(
            state!.taskData?.task![index].assignee ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
        DataCell(customContainer(state?.taskData?.task?[index].status ?? "",
            size: 13,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: state?.taskData?.task?[index].status?.toLowerCase() ==
                    "inprogress"
                ? Colors.orange
                : state?.taskData?.task?[index].status?.toLowerCase() ==
                        "completed"
                    ? Colors.green
                    : Colors.grey.shade100)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => (state?.taskData?.task?.length ?? 0);

  @override
  int get selectedRowCount => 0;
}
