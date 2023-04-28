import 'package:flutter/material.dart';
import 'package:test_project/bloc/user_cubit.dart';
import 'package:test_project/custom_widget/button.dart';
import 'package:test_project/helper/firebaseHelper.dart';
import 'package:test_project/helper/nav_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePageAdminScreen extends StatelessWidget {
  const HomePageAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.read<UserCubit>().getTaskList(context);
    return Scaffold(
      appBar:AppBar(
        actions: [
          IconButton(onPressed: (){
            openScreen(landingRoute);

          }, icon: Icon(Icons.login))
        ],
      ) ,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: BlocBuilder<UserCubit, UserDataState>(
                  builder: (context, state) {
                var dataSource = UserdataSource(context, state);
                print(state.userData?.name);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.1,
                          bottom: size.height *
                              (0.05
                                 )),
                      child: const Text(
                        "Welcome, Admin \nHere you can create task",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 24),
                      ),
                    ),
                    Visibility(
                      visible: state.taskData?.task?.length != null,
                      child: PaginatedDataTable(
                          onPageChanged: (int index) {},
                          rowsPerPage: (state.taskData?.task?.length ?? 1) > 0
                              ? (state.taskData?.task?.length ?? 1)
                              : 1,
                          showCheckboxColumn: false,
                          columns: const [
                            DataColumn(
                              label: Text(
                                "Task Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 13),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Assignee",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 13),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Status",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 13),
                              ),
                            ),
                          ],
                          source: dataSource),
                    ),
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    customButton(
                        buttonTitle: "Create New Task",
                        icon: Icons.add,
                        onTap: () {
                          openScreen(addTaskScreen);
                        })
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class UserdataSource extends DataTableSource {
  BuildContext context;
  UserDataState? state;

  UserdataSource(this.context, this.state);

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (val) {},
      cells: [
        DataCell(
          Text(
            state!.taskData?.task![index].taskTitle ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
        DataCell(
          Text(
            state?.taskData?.task?[index].assignee ?? "",
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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
