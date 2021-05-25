import 'package:flutter/material.dart';
import 'package:project_testing/accessories/lock_visual_settings.dart';
import 'accessories/theme_settings.dart';
import 'package:project_testing/pages/productivity_data_page.dart';
import 'package:project_testing/pages/study_lock_page.dart';
import 'package:project_testing/pages/template%20page.dart';
import 'package:project_testing/pages/work_status_page.dart';
import 'package:project_testing/pages/theme_select_page.dart';
import 'package:project_testing/pages/premium_status_page.dart';
import 'package:project_testing/pages/about_page.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => LockVisualNotifier())
      ],
    child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.isDarkTheme
                ? dark
                : themePicker(notifier.themeInt),
            routes: <String, WidgetBuilder>{
              'home': (context) => HomePage(),
              'study_lock': (context) => StudyLock(),
              'productivity_data': (context) => ProductivityData(),
              'work_status': (context) => WorkStatus(),
              'template_page': (context) => TemplatePage(),
              'theme_change': (context) => ThemeSelectPage(),
              'premium_status': (context) => PremiumStatusPage(),
              'about_page': (context) => AboutPage(),
            },
            home: HomePage(),
            debugShowCheckedModeBanner: false,
          );
        }));
  }
}

// ChangeNotifierProvider(
// create: (_) => ThemeNotifier(),
// child: Consumer<ThemeNotifier>(
// builder: (context, ThemeNotifier notifier, child) {
// initPrefs();
// return MaterialApp(
// theme: notifier.isDarkTheme ? dark : themePicker(notifier.themeInt),
// routes: <String, WidgetBuilder>{
// 'home': (context) => HomePage(),
// 'study_lock': (context) => StudyLock(),
// 'productivity_data': (context) => ProductivityData(),
// 'work_status': (context) => WorkStatus(),
// 'template_page': (context) => TemplatePage(),
// 'theme_change': (context) => ThemeSelectPage(),
// 'premium_status': (context) => PremiumStatusPage(),
// 'about_page': (context) => AboutPage(),
// },
// home: HomePage(),
// debugShowCheckedModeBanner: false,
// );
// }));

// FutureBuilder(
// future: initPrefs(),
// builder: (context, snapshot) { }
// )
