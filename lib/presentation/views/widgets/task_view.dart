import 'package:flutter/material.dart';

import '../../../domain/entities/list_entity.dart';
import '../../../domain/entities/task_entity.dart';
import 'task_card.dart';

class TaskView extends StatelessWidget {
  final List<TaskEntity>? objs;
  final ListEntity listObj;
  final Function? cardFunc;

  const TaskView({required this.objs, required this.listObj,
  this.cardFunc,
   super.key});

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }

  Widget buildContent() {
    return objs != null
        ? Column(
            children: List.generate(objs!.length + 2, (index) {
              if (index != 0 && index - 1 < objs!.length) {
                return TaskCard(
                  obj: objs![index - 1],
                  listObj: listObj,
                  onTab: cardFunc,
                );
              } else if (index == 0) {
                return buildTist();
              } else {
                return const SizedBox(height: 80);
              }
            }),
          )
        : const Center(child: CircularProgressIndicator(color: Colors.orange));
  }

  Widget buildTist() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("List : ${listObj.name}", style: const TextStyle(fontSize: 20)),
          Text("Tasks: ${objs!.length}", style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
