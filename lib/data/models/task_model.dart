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
      final Map<String, dynamic>? list = json["list"];
      return TaskModel(
        name: json["name"] ?? "null",
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

  Map<String, dynamic> toJson() => {
        "name": name,
        "uuid": uuid,
        "completed": completed,
      };
}
