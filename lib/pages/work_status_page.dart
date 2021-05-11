import 'package:flutter/material.dart';
import 'package:project_testing/menus/drawer_menus.dart';
import 'package:project_testing/database/event_operations.dart';
import 'package:project_testing/calendar_utils/status_events_list.dart';

class WorkStatus extends StatefulWidget {
  @override
  _WorkStatusState createState() => _WorkStatusState();
}

class _WorkStatusState extends State<WorkStatus> {

  EventOperations eventOperations = EventOperations();

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
                  'Work Status',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ),
          body: FutureBuilder(
            future: eventOperations.getAllEvents(),
            builder: (context, snapshot){
              if (snapshot.hasError) {
                print('snapshot error');
              }
              var data = snapshot.data;
              return snapshot.hasData ? StatusEventsList(data) :
              new SizedBox();
            },
          )
      ),
    );
  }
}
