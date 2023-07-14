// ignore_for_file: must_be_immutable

import 'package:doingly/config/services/tost_service.dart';

import '../../../config/vars/constants.dart';
import '/domain/entities/list_entity.dart';

import '../../../config/services/my_size.dart';
import '../../../config/themes/shadows.dart';
import '../../providers/task_provider.dart';
import '/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';

import 'ReadyInput/ready_input_base.dart';
import 'my_pop_widget.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity obj;
  final ListEntity listObj;
  final Function? onTab;
  TaskCard({required this.obj, required this.listObj, this.onTab, super.key});

  final double arentir = MySize.arentir;
  late BuildContext context;
  late TaskP taskP, taskDo;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    taskP = TaskP.of(context);
    taskDo = TaskP.of(context, listen: false);
    return GestureDetector(
      onTap: () {
        taskDo
            .update(
                obj.uuid,
                TaskEntity(
                    name: obj.name,
                    uuid: listObj.uuid,
                    completed: !obj.completed))
            .then((response) {
          TostService.message(response.message, response.status);
        if (onTab != null) onTab!();

        });
      },
      // onLongPress: (){

      // },
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: arentir * 0.2,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color:obj.completed?Colors.purple: Theme.of(context).canvasColor,
            gradient:obj.completed?  LinearGradient(colors: [Theme.of(context).canvasColor, Colors.green], 
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            ):null,
            boxShadow: ShadowsLight().list,
            borderRadius: BorderRadius.circular(8)),
        child: buildContent(),
      ),
    );
  }

//=========================
  Widget buildContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          obj.name,
          style: TextStyle(fontSize: arentir * 0.045),
        ),
        buildBtns(),
      ],
    );
  }

//Btns=======================
  Widget buildBtns() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(
        obj.completed ? Icons.task_alt : Icons.check_box_outline_blank,
        color: Colors.green,
        size: arentir*0.11,
      ),
      const SizedBox(width: 20),
      buildBtn(Icons.edit, () {
        MyPopUpp.popInput(
          context,
          "Edit Task",
          "Save",
          startVal: obj.name,
          hidden: "Task name",
          label: "Task name",
          onTap: () => _update(),
          iconD: Icons.task_outlined,
        );
      }, col: Colors.blue),
      const SizedBox(width: 10),
      buildBtn(
          Icons.delete_forever, () => MyPopUpp.popWarning(context, _delete)),
    ]);
  }

  void _update() {
    MyPopUpp.popLoading(context);
    taskDo
        .update(
            obj.uuid,
            TaskEntity(
                name: RIBase.getText(Tags.rIPop),
                uuid: obj.uuid,
                completed: obj.completed))
        .then((response) {
      MyPopUpp.popMessage(context, () {
        taskDo.fillTaskByList(listObj.uuid);
      }, response.message, !response.status);
    });
  }

  void _delete() {
    MyPopUpp.popLoading(context);
    taskDo.delete(obj.uuid).then((response) {
      MyPopUpp.popMessage(context, () {
        taskDo.fillTaskByList(listObj.uuid);
      }, response.message, !response.status);
    });
  }

  Widget buildBtn(IconData iconD, Function? func, {Color col = Colors.red}) {
    return InkWell(
      onTap: () {
        if (func != null) func();
      },
      child: Container(
          decoration:
              BoxDecoration(color: col, borderRadius: BorderRadius.circular(3)),
          height: arentir * 0.09,
          width: arentir * 0.09,
          child: Icon(
            iconD,
            size: arentir * 0.06,
            color: Colors.white,
          )),
    );
  }
}
