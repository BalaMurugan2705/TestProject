import 'package:flutter/material.dart';
import 'package:test_project/bloc/user_cubit.dart';
import 'package:test_project/custom_widget/button.dart';
import 'package:test_project/helper/nav_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageAdminScreen extends StatelessWidget {
  const HomePageAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: BlocBuilder<UserCubit, UserDataState>(
                  builder: (context, state) {
                var dataSource = UserdataSource(context, state);
                print(state.taskList?.length);
                return Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.1, bottom: size.height * ( state.taskList!.isNotEmpty?0.05:0.2)),
                      child: const Text(
                        "Welcome, Admin \nHere you can create task",
                        style:
                            TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
                      ),
                    ),
                    Visibility(
                      visible:  state.taskList?.length != 0,
                      child: PaginatedDataTable(
                          rowsPerPage:  (state.taskList?.length??1)>0?(state.taskList?.length??1):1,
                          showCheckboxColumn: false,
                          columns: const [
                            DataColumn(
                              label: Text(
                                "Task Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Assignee",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Status",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13),
                              ),
                            ),
                          ],
                          source: dataSource),
                    ),
                    Visibility(
                        visible: state.taskList!.isNotEmpty,
                        child: SizedBox(height: size.height *0.15,)),
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
            state!.taskList![index].taskTitle,
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
            state!.taskList![index].assignee,
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
            state!.taskList![index].status,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => (state?.taskList?.length??1)<5?(state?.taskList?.length??1):5;

  @override
  int get selectedRowCount => 0;
}
