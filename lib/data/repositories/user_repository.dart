import '/domain/entities/response_entity.dart';
import 'package:either_dart/either.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasourses/remote/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<ResponseEntity,String?>> signUp(UserEntity user) async {
    final model = UserModel.fromEntity(user);
    return await remoteDataSource.signUp(model);
  }

  @override
   Future<Either<ResponseEntity,String?>> login(UserEntity user) async {
    final model = UserModel.fromEntity(user);
    return await remoteDataSource.login(model);
  }
}
