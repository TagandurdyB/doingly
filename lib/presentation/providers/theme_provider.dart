import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../config/vars/constants.dart';

class ThemeP extends ChangeNotifier {
  bool _isSystem = true;
  bool get isSystem => _isSystem;
  void get getIsSystem {
    bool? read = _read(Tags.themeSystem);
    if (read == null) {
      changeSystem(true);
    } else {
      _isSystem = read;
    }
    notifyListeners();
  }

  bool _isLight = true;
  bool get isLight => _isLight;
  void get getIsLight {
    bool? read = _read(Tags.themeLight);
    if (read == null) {
      changeLight(true);
    } else {
      _isLight = read;
    }
    notifyListeners();
  }

  ThemeMode get mode => _isSystem
      ? ThemeMode.system
      : _isLight
          ? ThemeMode.light
          : ThemeMode.dark;

  void changeSystem(bool val) {
    _save(Tags.themeSystem, val);
    _isSystem = val;
    notifyListeners();
  }

  void changeLight(bool val) {
    _save(Tags.themeLight, val);
    _isLight = val;
    notifyListeners();
  }

  void get tongleSystem {
    try {
      _isSystem = !_isSystem;
      notifyListeners();
      _save(Tags.themeSystem, _isSystem);
    } catch (err) {
      print("Error on data Theme Provider tongleSystem:$err");
      notifyListeners();
    }
  }

  void get tongleLight {
    try {
      _isLight = !_isLight;
      notifyListeners();
      _save(Tags.themeLight, _isLight);
    } catch (err) {
      print("Error on data Theme Provider tongleMode:$err");
      notifyListeners();
    }
  }

  final myBase = Hive.box(Tags.hiveBase);

  void _save(String tag, bool val) {
    myBase.put(tag, val);
    notifyListeners();
  }

  bool? _read(String tag) => myBase.get(tag);

//PopUp==================================
  bool _isLoading = false;
  bool get isLoding => _isLoading;
  void changeIsLoading(bool isLoad) {
    _isLoading = isLoad;
    notifyListeners();
  }

  bool _warningOk = false;
  bool get warningOk => _warningOk;
  void changeWarning(bool isWar) {
    _warningOk = isWar;
    notifyListeners();
  }

//==
  static ThemeP of(BuildContext context, {listen = true}) =>
      Provider.of<ThemeP>(context, listen: listen);
}
