// ignore_for_file: overridden_fields

import '../../../domain/entities/task_entity.dart';
import 'list_model.dart';

class TaskModel extends TaskEntity {
  @override
  final String name;
  @override
  final String uuid;
  @override
  final bool completed;
  @override
  final ListModel? list;

  TaskModel({
    required this.name,
    required this.uuid,
    required this.completed,
    this.list,
  }) : super(name: '', uuid: '', completed: false);

  static TaskModel get empty =>
      TaskModel(name: "Empty", uuid: "", completed: false);

  factory TaskModel.fromEntity(TaskEntity entity) {
    try {
      return TaskModel(
        name: entity.name,
        uuid: entity.uuid,
        completed: entity.completed,
        list: null,
      );
    } catch (err) {
      throw ("Error in TaskModel>fromEntity : $err");
    }
  }

  factory TaskModel.frowJson(Map<String, dynamic> json) {
    try {
      final Map<String, dynamic>? list = json["List"];
      return TaskModel(
        name: json["text"] ?? "null",
        uuid: json["uuid"] ?? "null",
        completed: json["completed"] ?? false,
        list: list != null ? ListModel.frowJson(list) : null,
      );
    } catch (err) {
      throw ("Error in TaskModel>frowJson : $err");
    }
  }

  static List<TaskModel> fromJsonList(List jsonList) =>
      jsonList.map((json) => TaskModel.frowJson(json)).toList();

  static List<List<TaskModel>> fromJsonListAll(List jsonList) {
    Map<String, List<TaskModel>> map = {};
    String listName = "";
    for (int i = 0; i < jsonList.length; i++) {
      listName = jsonList[i]["List"]["name"];
      print("listName := $listName");
      if (map[listName] != null) {
        print("here 1");
        map[listName]!.add(TaskModel.frowJson(jsonList[i]));
      } else {
        print("here 2");
        map.addAll({listName: [TaskModel.frowJson(jsonList[i])]});
      }
        print("Map := $map");
    }
    return map.values.toList();
  }

  Map<String, dynamic> toJson() => {
        "text": name,
        "listUuid": uuid,
        "completed": completed,
      };
}
