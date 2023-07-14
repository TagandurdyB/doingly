class ListEntity {
  final String name;
  final String uuid;
  final int taskCount;
  final int completed;

  ListEntity({
    required this.name,
    required this.uuid,
    this.taskCount = 0,
    this.completed = 0,
  });
}
