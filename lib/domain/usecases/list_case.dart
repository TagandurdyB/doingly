import 'package:either_dart/either.dart';

import '../entities/response_entity.dart';
import '/domain/entities/list_entity.dart';

import '../repositories/list_repository.dart';

class ListCase {
  final ListRepository repository;
  ListCase(this.repository);

  Future<ResponseEntity> create(String name) async =>
      await repository.create(name);

  Future<Either<ResponseEntity, List<ListEntity>>> read() async =>
      await repository.read();

  Future<ResponseEntity> update(String uuid, String name) async =>
      await repository.update(uuid, name);

  Future<ResponseEntity> delete(String uuid) async =>
      await repository.delete(uuid);
}
