class ListEntity {
  final String name;
  final String uuid;
  final int taskCount;
  final int completedTaskCount;

  ListEntity({
    required this.name,
    required this.uuid,
    this.taskCount = 0,
    this.completedTaskCount = 0,
  });
}
