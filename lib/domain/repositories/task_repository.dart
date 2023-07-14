import 'package:either_dart/either.dart';

import '../entities/response_entity.dart';
import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<ResponseEntity> create(TaskEntity task);
  Future<Either<ResponseEntity, List<List<TaskEntity>>>> readAll();
  Future<Either<ResponseEntity, List<TaskEntity>>> readByList(String listUuid);
  Future<ResponseEntity> update(String uuid, TaskEntity task);
  Future<ResponseEntity> delete(String uuid);
}
