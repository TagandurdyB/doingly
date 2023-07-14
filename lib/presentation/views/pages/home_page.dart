// ignore_for_file: must_be_immutable

import '../../../config/services/keyboard.dart';
import '../scaffold/custom_drawer.dart';
import '/presentation/views/widgets/my_pop_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/my_rout.dart';
import '../../../config/vars/constants.dart';
import '../../providers/user_provider.dart';
import '../../providers/list_provider.dart';
import '../widgets/ReadyInput/ready_input_base.dart';
import '../widgets/list_card.dart';
import 'task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ListP listP, listDo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listDo = ListP.of(context, listen: false);
      listDo.fillLists();
    });
  }

  @override
  Widget build(BuildContext context) {
    listP = ListP.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lists"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _logOut, icon: const Icon(Icons.logout))
        ],
      ),
      drawer: CustomDrawer(),
      body: buildContent(),
      floatingActionButton: FloatingActionButton(
          onPressed: _addList, child: const Icon(Icons.add)),
    );
  }

  void _logOut() {
    final userDo = UserP.of(context, listen: false);
    userDo.saveStr(Tags.hiveToken, null);
    userDo.saveBool(Tags.hiveIsLogin, false);
    Navigator.pushNamedAndRemoveUntil(context, Rout.login, (route) => false);
  }

  void _addList() {
    MyPopUpp.popInput(
      context,
      "Add List",
      "Add",
      onTap: () {
        Keyboard.close(context);
        MyPopUpp.popLoading(context);
        listDo.create(RIBase.getText(Tags.rIPop)).then((response) {
          listDo.fillLists();
          MyPopUpp.popMessage(
              context, null, response.message, !response.status);
        });
      },
      hidden: "New List name",
      label: "New List name",
    );
  }

  Widget buildContent() {
    final lists = listP.lists;
    return lists != null
        ? RefreshIndicator(
            color: Colors.orange,
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: lists.length+1,
              itemBuilder: (context, index) {
                if (index < lists.length) {
                  return ListCard(
                    obj: lists[index],
                    onTab: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TaskPage(listObj: lists[index])));
                    },
                  );
                } else {
                  return const SizedBox(height: 80);
                }
              },
            ),
          )
        : const Center(child: CircularProgressIndicator(color: Colors.orange));
  }

  Future<void> _refresh() => listDo.fillLists().then((value) => true);
}
