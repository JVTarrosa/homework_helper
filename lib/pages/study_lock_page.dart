import 'package:flutter/material.dart';
import 'package:project_testing/accessories/drawer_menus.dart';
import 'package:project_testing/study_lock_utils/improvise_timer_button.dart';
import 'package:project_testing/database/time_input_operations.dart';
import 'package:project_testing/study_lock_utils/saved_timer_list.dart';
import 'package:project_testing/study_lock_utils/time_input_object.dart';
import 'package:project_testing/study_lock_utils/create_timer_button.dart';
import 'package:project_testing/study_lock_utils/time_selectors.dart';
import 'package:project_testing/study_lock_utils/change_visual_button.dart';

class StudyLock extends StatefulWidget {
  @override
  _StudyLockState createState() => _StudyLockState();
}

class _StudyLockState extends State<StudyLock> {
  TimeInputOperations timeInputOperations = TimeInputOperations();
  TimeInput input = TimeInput(studyTime: 0, pauseTime: 0, cycle: 0);

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
              onPressed: () => Scaffold.of(context).openDrawer(),
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
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              TimeSelectors(input: input),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImproviseTimerButton(
                    timeInput: input,
                  ),
                  SizedBox(width: 5,),
                  CreateTimerButton(timeInput: input),
                ],
              ),
              SizedBox(height: 10),
              ChangeVisualButton(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SAVED TIMERS',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              FutureBuilder(
                future: timeInputOperations.getAllTimeInputs(),
                builder:
                    (context, AsyncSnapshot<List<TimeInput>> snapshot) {
                  if (snapshot.hasError) {
                    print('snapshot error');
                  }
                  var data = snapshot.data;
                  return snapshot.hasData
                      ? SavedTimerList(data)
                      : Text('no data');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
