// ignore_for_file: must_be_immutable

import '../../../config/services/keyboard.dart';
import '../../../domain/entities/list_entity.dart';
import '../widgets/task_view.dart';
import '/presentation/views/widgets/my_pop_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/my_rout.dart';
import '../../../config/vars/constants.dart';
import '../../../domain/entities/task_entity.dart';
import '../../providers/task_provider.dart';
import '../../providers/user_provider.dart';
import '../widgets/ReadyInput/ready_input_base.dart';

class TaskPage extends StatefulWidget {
  final ListEntity? listObj;
  const TaskPage({this.listObj, super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late TaskP taskP, taskDo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      taskDo = TaskP.of(context, listen: false);
      _fillTask();
    });
  }

  Future<void> _fillTask() async {
    if (widget.listObj != null) {
      taskDo.fillTaskByList(widget.listObj!.uuid);
    } else {
      taskDo.fillAllTask();
    }
  }

  @override
  Widget build(BuildContext context) {
    taskP = TaskP.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _logOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _fillTask(),
        color: Colors.orange,
        child: SingleChildScrollView(child: buildView()),
      ),
      floatingActionButton: widget.listObj != null
          ? FloatingActionButton(
              onPressed: _addList, child: const Icon(Icons.add))
          : null,
    );
  }

  Widget buildView() {
    if (widget.listObj != null) {
      return TaskView(
        objs: taskP.tasks,
        listObj: widget.listObj!,
        cardFunc: () {
          // TODO
          taskDo.fillTaskByList(widget.listObj!.uuid);
        },
      );
    } else if (taskP.tasksAll != null) {
      return Column(
          children: taskP.tasksAll!
              .map((taskList) => TaskView(
                    objs: taskList,
                    listObj: taskList.first.list!,
                    cardFunc: () {
                      // TODO
                      taskDo.fillAllTask();
                    },
                  ))
              .toList());
    } else {
      return const Center(
          child: CircularProgressIndicator(color: Colors.orange));
    }
  }

  void _logOut() {
    final userDo = UserP.of(context, listen: false);
    userDo.saveStr(Tags.hiveToken, null);
    userDo.saveBool(Tags.hiveIsLogin, false);
    Navigator.pushNamedAndRemoveUntil(context, Rout.login, (route) => false);
  }

  void _addList() {
    MyPopUpp.popInput(
      context,
      "Add Task",
      "Add",
      onTap: () {
        Keyboard.close(context);
        MyPopUpp.popLoading(context);
        taskDo
            .create(TaskEntity(
                name: RIBase.getText(Tags.rIPop),
                completed: false,
                uuid: widget.listObj!.uuid))
            .then((response) {
          taskDo.fillTaskByList(widget.listObj!.uuid);
          MyPopUpp.popMessage(
              context, null, response.message, !response.status);
        });
      },
      hidden: "New Task name",
      label: "New Task name",
      iconD: Icons.task_outlined,
    );
  }
}
