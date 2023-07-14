import 'package:either_dart/either.dart';

import '../entities/response_entity.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class TaskCase {
  final TaskRepository repository;
  TaskCase(this.repository);

  Future<ResponseEntity> create(TaskEntity task) async =>
      await repository.create(task);

  Future<Either<ResponseEntity, List<List<TaskEntity>>>> readAll() async =>
      await repository.readAll();

  Future<Either<ResponseEntity, List<TaskEntity>>> read(
          String listUuid) async =>
      await repository.readByList(listUuid);

  Future<ResponseEntity> update(String uuid, TaskEntity task) async =>
      await repository.update(uuid, task);

  Future<ResponseEntity> delete(String uuid) async =>
      await repository.delete(uuid);
}
