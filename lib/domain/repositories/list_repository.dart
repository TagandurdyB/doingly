import 'package:either_dart/either.dart';

import '../entities/list_entity.dart';
import '../entities/response_entity.dart';

abstract class ListRepository {
  Future<ResponseEntity> create(String name);
  Future<Either<ResponseEntity, List<ListEntity>>> read();
  Future<ResponseEntity> update(String uuid, String name);
  Future<ResponseEntity> delete(String uuid);
}
