import 'package:either_dart/either.dart';

import '../entities/response_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class UserCase {
  final UserRepository repository;
  UserCase(this.repository);

  Future<Either<ResponseEntity, String?>> signUp(UserEntity user) async =>
      await repository.signUp(user);

  Future<Either<ResponseEntity, String?>> login(UserEntity user) async =>
      await repository.login(user);
}
