import 'dart:async';
import 'dart:convert';

import 'package:either_dart/either.dart';

import '../../models/response_model.dart';
import '../../models/user_model.dart';
import 'package:http/http.dart' as http;

import 'http_vars.dart';

abstract class UserRemoteDataSource {
  Future<Either<ResponseModel, String?>> signUp(UserModel user);
  Future<Either<ResponseModel, String?>> login(UserModel user);
}

class UserDataSourceImpl implements UserRemoteDataSource {
  final http.Client httpClient;
  UserDataSourceImpl(this.httpClient);

  @override
  Future<Either<ResponseModel, String?>> signUp(UserModel user) async {
    print("Url:=${Uris.register}");
    const where = "UserDataSourceImpl>signUp";
    return await httpClient
        .post(
      Uris.register,
      headers: Headers.contentJson,
      body: json.encode(user.toJsonRegister()),
    )
        .then((response) {
      Map<String, dynamic> res = json.decode(response.body);
      print("$where response:=$res");
      final result = HttpFuncs.tryerChecker(
          where,
          HttpFuncs.statusCodeChecker(
            res["token"],
            response.statusCode,
            isEith: true,
          ));
      try {
        return Right(result);
      } catch (e) {
        return Left(result);
      }
    });
  }

  @override
  Future<Either<ResponseModel, String?>> login(UserModel user) async {
    print("Url:=${Uris.login}");
    const where = "UserDataSourceImpl>login";
    return await httpClient
        .post(
      Uris.login,
      headers: Headers.contentJson,
      body: json.encode(user.toJsonLogin()),
    )
        .then((response) {
      Map<String, dynamic> res = json.decode(response.body);
      print("$where response:=$res");
      final result = HttpFuncs.tryerChecker(
          where,
          HttpFuncs.statusCodeChecker(
            res["token"],
            response.statusCode,
            isEith: true,
          ));
      try {
        return Right(result);
      } catch (e) {
        return Left(result);
      }
    });
  }
}
