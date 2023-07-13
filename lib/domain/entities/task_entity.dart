import 'list_entity.dart';

class TaskEntity {
  final String name;
  final String uuid;
  final bool completed;
  final ListEntity? list;

  TaskEntity({
    required this.name,
    required this.uuid,
    required this.completed,
    this.list,
  });
}
