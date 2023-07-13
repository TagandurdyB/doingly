import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:hive/hive.dart';

import '../../../config/vars/constants.dart';
import '../../models/response_model.dart';
import '../../models/task_model.dart';
import 'package:http/http.dart' as http;

import 'http_vars.dart';

abstract class TaskRemoteDataSource {
  Future<ResponseModel> create(TaskModel task);
  Future<Either<ResponseModel, List<TaskModel>>> readAll();
  Future<Either<ResponseModel, List<TaskModel>>> readByList(String listUuid);
  Future<ResponseModel> update(String uuid, TaskModel task);
  Future<ResponseModel> delete(String uuid);
}

class TaskDataSourceImpl implements TaskRemoteDataSource {
  final http.Client httpClient;
  TaskDataSourceImpl(this.httpClient);

  final myBase = Hive.box(Tags.hiveBase);
  String? get token => myBase.get(Tags.hiveToken);

  @override
  Future<ResponseModel> create(TaskModel task) async {
    print("Url:=${Uris.tasks}");
    const where = "TaskDataSourceImpl>create";
    return HttpFuncs.tokenChecker(token, where, () async {
      return await httpClient
          .post(
        Uris.tasks,
        headers: Headers.bearer(token!),
        body: json.encode(task.toJson()),
      )
          .then((response) {
        HttpFuncs.tryerChecker(where, () async {
          Map<String, dynamic> res = json.decode(response.body);
          print("$where response:=$res");
          return HttpFuncs.statusCodeChecker(
            ResponseModel(message: "Success", status: true),
            response.statusCode,
          );
        });
      });
    });
  }

  @override
  Future<Either<ResponseModel, List<TaskModel>>> readAll() async {
    print("Url:=${Uris.tasks}");
    const where = "TaskDataSourceImpl>readAll";
    return HttpFuncs.errCatcher(token, where, () async {
      final response = await httpClient.get(
        Uris.tasks,
        headers: Headers.bearer(token!),
      );
      List res = json.decode(response.body);
      print("$where response:=$res");
      return HttpFuncs.statusCodeChecker(
        TaskModel.fromJsonList(res),
        response.statusCode,
      );
    });
  }

  @override
  Future<Either<ResponseModel, List<TaskModel>>> readByList(
      String listUuid) async {
    print("Url:=${Uris.taskFromList(listUuid)}");
    const where = "TaskDataSourceImpl>readByList";
    return HttpFuncs.errCatcher(token, where, () async {
      final response = await httpClient.get(
        Uris.taskFromList(listUuid),
        headers: Headers.bearer(token!),
      );
      List res = json.decode(response.body);
      print("$where response:=$res");
      return HttpFuncs.statusCodeChecker(
        TaskModel.fromJsonList(res),
        response.statusCode,
      );
    });
  }

  @override
  Future<ResponseModel> update(String uuid, TaskModel task) async {
    print("Url:=${Uris.taskChange(uuid)}");
    const where = "TaskDataSourceImpl>update";
    return HttpFuncs.tokenChecker(token, where, () async {
      return await httpClient
          .put(
        Uris.taskChange(uuid),
        headers: Headers.bearer(token!),
        body: task.toJson(),
      )
          .then((response) {
        HttpFuncs.tryerChecker(where, () async {
          Map<String, dynamic> res = json.decode(response.body);
          print("$where response:=$res");
          return HttpFuncs.statusCodeChecker(
            ResponseModel.frowJson(res),
            response.statusCode,
          );
        });
      });
    });
  }

  @override
  Future<ResponseModel> delete(String uuid) async {
    print("Url:=${Uris.taskChange(uuid)}");
    const where = "TaskDataSourceImpl>delete";
    return HttpFuncs.errCatcher(token, where, () async {
      final response = await httpClient.delete(
        Uris.taskChange(uuid),
        headers: Headers.bearer(token!),
      );
      Map<String, dynamic> res = json.decode(response.body);
      print("$where response:=$res");
      return HttpFuncs.statusCodeChecker(
        ResponseModel.frowJson(res),
        response.statusCode,
      );
    });
  }
}
