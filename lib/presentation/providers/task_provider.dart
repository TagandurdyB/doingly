import '../../config/services/tost_service.dart';
import '../../domain/entities/response_entity.dart';
import '/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/domain/usecases/task_case.dart';

class TaskP extends ChangeNotifier {
  final TaskCase taskCase;
  TaskP({required this.taskCase});

  Future<ResponseEntity> create(TaskEntity task) async {
    if (task.name != "") {
      return await taskCase.create(task);
    }
    return ResponseEntity(status: false, message: "Task name cannot be empty");
  }

  Future<ResponseEntity> update(String uuid, TaskEntity task) async {
    if (task.name != "") {
      return await taskCase.update(uuid, task);
    }
    return ResponseEntity(status: false, message: "Task name cannot be empty");
  }

  Future<ResponseEntity> delete(String uuid) async {
    if (uuid != "") {
      return await taskCase.delete(uuid);
    }
    return ResponseEntity(status: false, message: "Task Uuid not found!");
  }

  List<TaskEntity>? tasks;
  Future<void> fillTaskByList(String listUuid) async {
    try {
      tasks = null;
      notifyListeners();
      final either = await taskCase.read(listUuid);
      if (either.isRight) {
        tasks = either.right;
        notifyListeners();
      } else {
        final response = either.left;
        TostService.message(response.message, response.status);
      }
    } catch (err) {
      throw "TaskP>fillTaskByList($listUuid) ERROR : $err";
    }
  }

  List<List<TaskEntity>>? tasksAll;
  Future<void> fillAllTask() async {
    try {
      tasksAll = null;
      notifyListeners();
      final either = await taskCase.readAll();
      if (either.isRight) {
        tasksAll = either.right;
        print("All Tasks = $tasksAll");
        notifyListeners();
      } else {
        final response = either.left;
        TostService.message(response.message, response.status);
      }
    } catch (err) {
      throw "TaskP>fillAllTask() ERROR : $err";
    }
  }

//=============================
// bool _isComplate=false;

  static TaskP of(BuildContext context, {listen = true}) =>
      Provider.of<TaskP>(context, listen: listen);
}
