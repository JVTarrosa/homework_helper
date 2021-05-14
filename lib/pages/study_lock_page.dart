import 'package:flutter/material.dart';
import 'package:project_testing/menus/drawer_menus.dart';
import 'package:project_testing/study_lock_utils/pomodoro_button.dart';

class StudyLock extends StatefulWidget {
  @override
  _StudyLockState createState() => _StudyLockState();
}

class _StudyLockState extends State<StudyLock> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

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
                  'Study Lock',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ),
          body: Container(
            child: Center(


              // POMODORO BUTTON
              child: PomodoroButton()


            ),
          )
      ),
    );
  }
}
