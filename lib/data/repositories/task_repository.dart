import 'package:either_dart/either.dart';

import '../models/response_model.dart';
import '/data/models/task_model.dart';

import '../../domain/entities/response_entity.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasourses/remote/task_remote_datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<ResponseEntity> create(TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    return await remoteDataSource.create(model);
  }

  @override
  Future<Either<ResponseEntity, List<List<TaskEntity>>>> readAll() async {
    return await remoteDataSource.readAll();
  }

  @override
  Future<Either<ResponseEntity, List<TaskEntity>>> readByList(
      String listUuid) async {
    return await remoteDataSource.readByList(listUuid);
  }

  @override
  Future<ResponseEntity> update(String uuid, TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    return await remoteDataSource.update(uuid, model);
  }

  @override
  Future<ResponseEntity> delete(String uuid) async {
    return await remoteDataSource.delete(uuid);
  }
}
