import 'package:either_dart/either.dart';

import '../entities/response_entity.dart';
import '/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<ResponseEntity, String?>> signUp(UserEntity user);
  Future<Either<ResponseEntity, String?>> login(UserEntity user);
}
