import 'package:flutter/material.dart';
import 'package:project_testing/calendar_utils/calendar.dart';
import 'package:project_testing/accessories/drawer_menus.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          // NavigatorMenu() and SettingsMenu() are imported classes from drawer_menus.dart
          drawer: NavigatorMenu(),
          endDrawer: SettingsMenu(),
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(
                    Icons.reorder,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed:  () => Scaffold.of(context).openDrawer(),
              ),
            ),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                      Icons.settings,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
            ],
            title: Center(
              child: Text(
                'Schoolwork Calendar',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ),
          body: Calendar()
        ),
      );
  }
}
