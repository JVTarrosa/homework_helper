import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String animatedScreen(int id) {
  switch (id) {
    case 1: return 'https://drive.google.com/'
        'uc?export=view&id=1gI-t4W4m3jBXnLdJ2_C30ZFwjVTdOLug';
    case 2: return 'https://drive.google.com/'
        'uc?export=view&id=1Z-uMhn-_oLeiWQE-weHHXqTTQsFhN8oq';
    case 3: return 'https://drive.google.com/'
        'uc?export=view&id=1QHocFamzJtBeCOQdcVzXc5mq2M1GBncs';
    default: return 'https://drive.google.com/'
        'uc?export=view&id=1gI-t4W4m3jBXnLdJ2_C30ZFwjVTdOLug';
  }
}

String stillScreen(int id) {
  switch(id) {
    case 1: return 'assets/study_lock/fishingcat.png';
    case 2: return 'assets/study_lock/sharkhunt.png';
    case 3: return 'assets/study_lock/cityriver.png';
    default: return 'assets/study_lock/fishingcat.png';
  }
}

class LockVisualNotifier extends ChangeNotifier {
  final String key = 'studyLock';
  SharedPreferences? _prefs;
  late int _lockInt;

  int get lockInt => _lockInt;


  LockVisualNotifier() {
    _lockInt = 0;
    getThemePref();
  }

  getThemePref() async {
    await _initPreferences();
    _lockInt = _prefs!.getInt(key) ?? 0;
    notifyListeners();
  }

  setLockInt(int lockInt) {
    _lockInt = lockInt;
    _setThemePrefs();
    notifyListeners();
  }

  _setThemePrefs() async {
    await _initPreferences();
    _prefs!.setInt(key, _lockInt);
  }

  _initPreferences() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }
}