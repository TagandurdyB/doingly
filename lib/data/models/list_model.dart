// ignore_for_file: overridden_fields

import '../../../domain/entities/list_entity.dart';

class ListModel extends ListEntity {
  @override
  final String name;
  @override
  final String uuid;
  @override
  final int taskCount;
  @override
  final int completedTaskCount;

  ListModel({
    required this.name,
    required this.uuid,
    this.taskCount = 0,
    this.completedTaskCount = 0,
  }) : super( name: '', uuid: '');

  static ListModel get empty => ListModel( name: "", uuid: "");

  factory ListModel.frowJson(Map<String, dynamic> json) {
    try {
      return ListModel(
        name: json["name"] ?? "",
        uuid: json["uuid"] ?? "",
        taskCount: json["taskCount"] ?? 0,
        completedTaskCount: json["completedTaskCount"] ?? 0,
      );
    } catch (err) {
      throw ("Error in ListModel>frowJson: $err");
    }
  }

  static List<ListModel> fromJsonList(List jsonList) =>
      jsonList.map((json) => ListModel.frowJson(json)).toList();
}
