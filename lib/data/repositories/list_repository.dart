import 'package:either_dart/either.dart';

import '../../domain/entities/list_entity.dart';
import '../../domain/entities/response_entity.dart';
import '../../domain/repositories/list_repository.dart';
import '../datasourses/remote/list_remote_datasource.dart';

class ListRepositoryImpl implements ListRepository {
  final ListRemoteDataSource remoteDataSource;
  ListRepositoryImpl(this.remoteDataSource);

  @override
  Future<ResponseEntity> create(String name) async {
    return await remoteDataSource.create(name);
  }

  @override
  Future<Either<ResponseEntity, List<ListEntity>>> read() async {
    return await remoteDataSource.read();
  }

  @override
  Future<ResponseEntity> update(String uuid, String name) async {
    return await remoteDataSource.update(uuid, name);
  }

  @override
  Future<ResponseEntity> delete(String uuid) async {
    return await remoteDataSource.delete(uuid);
  }
}
