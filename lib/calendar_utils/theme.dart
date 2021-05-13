import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Light Theme
ThemeData light = ThemeData(
  backgroundColor: Color.fromARGB(255, 245, 245, 245),
  primaryColor: Colors.white,
  accentColor: Colors.blueGrey,
  focusColor: Color.fromARGB(255, 144, 164, 174),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueGrey,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.white
      )
    )
  ),
  // primaryColor: Color.fromARGB(255, 246, 248, 250),
  // accentColor: Color.fromARGB(255, 50, 50, 50),
  primaryTextTheme: TextTheme(
    //Section Headings
    headline1: TextStyle(
      color: Colors.blueGrey,
      // color: Color.fromARGB(255, 59, 57, 60),
      fontSize: 22,
      fontWeight: FontWeight.bold
    ),
    //Body Text
    bodyText1: TextStyle(
      color: Colors.blueGrey,
      // color: Color.fromARGB(255, 105, 105, 100),
      fontSize: 16
    )
  )
);

// Dark Theme
ThemeData dark = ThemeData(
    backgroundColor: Color.fromARGB(255, 33, 33, 33),
    primaryColor: Color.fromARGB(255, 31, 31, 31),
    accentColor: Color.fromARGB(255, 200, 200, 200),
    focusColor: Colors.white12,
    appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 66, 66, 66),
    ),
    primaryTextTheme: TextTheme(
      //Section Headings
        headline1: TextStyle(
            color: Color.fromARGB(255, 250, 250, 250),
            fontSize: 22,
            fontWeight: FontWeight.bold
        ),

        //Body Text
        bodyText1: TextStyle(
            color: Color.fromARGB(255, 66, 66, 66),
            fontSize: 16
        )
    )
);

Future<SharedPreferences> initPrefs() async {
  return await SharedPreferences.getInstance();
}


class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  late SharedPreferences _prefs;
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeNotifier() {
    _isDarkTheme = false;
    _initPrefs();
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

  // Initiate a preference
  _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }
}