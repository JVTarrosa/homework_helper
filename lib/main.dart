import 'package:flutter/material.dart';
import 'package:project_testing/calendar_utils/theme.dart';
import 'package:project_testing/pages/productivity_data_page.dart';
import 'package:project_testing/pages/study_lock_page.dart';
import 'package:project_testing/pages/template%20page.dart';
import 'package:project_testing/pages/work_status_page.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.isDarkTheme ? dark : light,
            routes: <String, WidgetBuilder>{
              'home': (context) => HomePage(),
              'study_lock': (context) => StudyLock(),
              'productivity_data': (context) => ProductivityData(),
              'work_status': (context) => WorkStatus(),
              'template_page': (context) => TemplatePage(),
            },
            home: HomePage(),
            debugShowCheckedModeBanner: false,
          );
        }));
  }
}
