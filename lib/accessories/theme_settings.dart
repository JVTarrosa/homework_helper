import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData themePicker(int number) {
  switch(number) {
    case 1: return classic;
    case 2: return pink;
    case 3: return green;
    case 4: return cobalt;
    case 5: return orange;
    case 6: return teal;
    case 7: return red;
    default: return classic;
  }
}

// classic Theme
ThemeData classic = ThemeData(
    backgroundColor: Color.fromARGB(255, 245, 245, 245),
    primaryColor: Colors.white,
    accentColor: Colors.blueGrey,
    focusColor: Color.fromARGB(255, 144, 164, 174),
    cardColor: Colors.blueGrey,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.blueGrey,
        textTheme: TextTheme(
            bodyText1: TextStyle(
                color: Colors.white
            )
        )
    ),
);

ThemeData pink = ThemeData(
    backgroundColor: Color.fromARGB(255, 245, 245, 245),
    primaryColor: Colors.white,
    accentColor: Color.fromARGB(255, 185, 95, 155),
    focusColor: Color.fromARGB(255, 180, 135, 167),
    cardColor: Color.fromARGB(255, 185, 95, 155),
    appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 185, 95, 155),
        textTheme: TextTheme(
            bodyText1: TextStyle(
                color: Colors.white
            )
        )
    ),
);

ThemeData green = ThemeData(
  backgroundColor: Color.fromARGB(255, 245, 245, 245),
  primaryColor: Colors.white,
  accentColor: Color.fromARGB(255, 95, 140, 70),
  focusColor: Color.fromARGB(255, 130, 160, 130),
  cardColor: Color.fromARGB(255, 95, 140, 70),
  appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 95, 140, 70),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Colors.white
          )
      )
  ),
);

ThemeData cobalt = ThemeData(
  backgroundColor: Color.fromARGB(255, 245, 245, 245),
  primaryColor: Colors.white,
  accentColor: Color.fromARGB(255, 20, 100, 175),
  focusColor: Color.fromARGB(255, 90, 140, 190),
  cardColor: Color.fromARGB(255, 20, 100, 175),
  appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 20, 100, 175),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Colors.white
          )
      )
  ),
);

ThemeData orange = ThemeData(
  backgroundColor: Color.fromARGB(255, 245, 245, 245),
  primaryColor: Colors.white,
  accentColor: Color.fromARGB(255, 230, 115, 30),
  focusColor: Color.fromARGB(255, 230, 165, 120),
  cardColor: Color.fromARGB(255, 230, 115, 30),
  appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 230, 115, 30),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Colors.white
          )
      )
  ),
);

ThemeData teal = ThemeData(
  backgroundColor: Color.fromARGB(255, 245, 245, 245),
  primaryColor: Colors.white,
  accentColor: Color.fromARGB(255, 10, 140, 130),
  focusColor: Color.fromARGB(255, 95, 160, 155),
  cardColor: Color.fromARGB(255, 10, 140, 130),
  appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 10, 140, 130),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Colors.white
          )
      )
  ),
);

ThemeData red = ThemeData(
  backgroundColor: Color.fromARGB(255, 245, 245, 245),
  primaryColor: Colors.white,
  accentColor: Color.fromARGB(255, 190, 40, 40),
  focusColor: Color.fromARGB(255, 195, 116, 116),
  cardColor: Color.fromARGB(255, 190, 40, 40),
  appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 190, 40, 40),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Colors.white
          )
      )
  ),
);

// Dark Theme
ThemeData dark = ThemeData(
    backgroundColor: Color.fromARGB(255, 33, 33, 33),
    primaryColor: Color.fromARGB(255, 31, 31, 31),
    accentColor: Color.fromARGB(255, 170, 170, 170),
    focusColor: Colors.white12,
    cardColor: Colors.grey,
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 66, 66, 66),
    ),
);

Future<SharedPreferences> initPrefs() async {
  return await SharedPreferences.getInstance();
}

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  late SharedPreferences _prefs;
  bool _isDarkTheme = false;
  int _themeInt = 0;

  bool get isDarkTheme => _isDarkTheme;
  int get themeInt => _themeInt;

  ThemeNotifier() {
    _isDarkTheme = false;
    _initPrefs();
  }

  // Initiate a preference
  _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get saved theme preference
  _getThemPref() async {
    await _initPrefs();
    _isDarkTheme = _prefs.getBool(key) ?? false;
    notifyListeners();
  }

  // Switch theme
  toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _setThemePrefs();
    notifyListeners();
  }

  // Set theme preference
  _setThemePrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _isDarkTheme);
  }

  //THEME CHANGE SHENANIGANS

  Future<void> setThemeInt(int themeInt) async {
    await _initPrefs();
    _themeInt = themeInt;
    _setThemePrefs();
    notifyListeners();
  }


}