import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
//User===========================
import 'presentation/providers/user_provider.dart';
import '/domain/usecases/user_case.dart';
import '/data/repositories/user_repository.dart';
import '/data/datasourses/remote/user_remote_datasource.dart';
//List===========================
import 'presentation/providers/list_provider.dart';
import '/domain/usecases/list_case.dart';
import '/data/repositories/list_repository.dart';
import '/data/datasourses/remote/list_remote_datasource.dart';
//Task===========================
import 'presentation/providers/task_provider.dart';
import '/domain/usecases/task_case.dart';
import '/data/repositories/task_repository.dart';
import '/data/datasourses/remote/task_remote_datasource.dart';
//Theme==========================
import 'presentation/providers/theme_provider.dart';

class Injector extends StatelessWidget {
  final Widget router;
  const Injector({required this.router, super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          //=======================================
          ChangeNotifierProvider<UserP>(
              create: (_) => UserP(
                    userCase: UserCase(
                        UserRepositoryImpl(UserDataSourceImpl(http.Client()))),
                  )),
          ChangeNotifierProvider<ListP>(
              create: (_) => ListP(
                    listCase: ListCase(
                        ListRepositoryImpl(ListDataSourceImpl(http.Client()))),
                  )),
          ChangeNotifierProvider<TaskP>(
              create: (_) => TaskP(
                    taskCase: TaskCase(
                        TaskRepositoryImpl(TaskDataSourceImpl(http.Client()))),
                  )),
          //=======================================
          ChangeNotifierProvider<ThemeP>(create: (context) => ThemeP()),
        ],
        child: router,
      );
}
