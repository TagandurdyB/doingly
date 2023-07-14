// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../config/routes/my_rout.dart';
import '../../providers/theme_provider.dart';
import '../pages/task_page.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Drawer(
        child: Column(children: [
      SizedBox(height: MediaQuery.of(context).padding.top),
      buildTop(),
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: buildContent(),
      )
    ]));
  }

  Widget buildTop() {
    return Container(
      color: Colors.orange,
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      height: 90,
      alignment: Alignment.center,
      child: const Text(
        "Doingly",
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget buildContent() {
    final themeP = ThemeP.of(context);
    final themeDo = ThemeP.of(context, listen: false);
    final bool isLight = Theme.of(context).brightness == Brightness.dark;
    final Color dviderCol = isLight ? Colors.black : Colors.white;
    return Column(
      children: [
        Divider(color: dviderCol),
        buildTitle("THEME"),
        Divider(color: dviderCol),
        buildDTBtn(
          "System mode",
          Icons.blur_off_sharp,
          Icons.blur_on_sharp,
          themeP.isSystem,
          onTap: () => themeDo.tongleSystem,
        ),
        Opacity(
          opacity: themeP.isSystem ? 0.5 : 1,
          child: buildDTBtn(
            themeP.isSystem ? "Closed" : "Light mode",
            Icons.dark_mode,
            Icons.wb_sunny_outlined,
            themeP.isLight,
            textP: "Dark mode",
            onTap: () {
              if (!themeDo.isSystem) {
                themeDo.tongleLight;
              }
            },
          ),
        ),
        Divider(color: dviderCol),
        buildTitle("TASKS"),
        Divider(color: dviderCol),
         buildDTBtn(
          "All Tasks",
          Icons.task_sharp,
          Icons.home,
          false,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const TaskPage())),
        ),
      ],
    );
  }

  Widget buildTitle(String text, {double size = 18}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: size),
      ),
    );
  }

//Theme===========================
// Widget buildTheme(){
// re
// }

  Widget buildDTBtn(
    String text,
    IconData iconP,
    IconData iconA,
    bool isOk, {
    String? textP,
    Function? onTap,
  }) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildTitle(isOk ? text : textP ?? text, size: 16),
            ),
            Icon(isOk ? iconA : iconP),
          ],
        ),
      ),
    );
  }
}
