import 'package:flutter/material.dart';
import 'package:project_testing/menus/drawer_menus.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_testing/database/event_operations.dart';
import 'event_item.dart';

class AddEvent extends StatefulWidget {
  DateTime dateSelected;

  AddEvent(this.dateSelected);

  @override
  _AddEventState createState() => _AddEventState(dateSelected);
}

class _AddEventState extends State<AddEvent> {
  DateTime date;

  _AddEventState(this.date);

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
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
              'Add Event',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Center(

          // INPUT BARS
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Event Title'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 2,
                  controller: _descController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Event Description'),
                ),
              ),

              // ADD EVENT BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(

                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor
                    ),
                  ),
                    onPressed: () {
                      final event = Event(
                        title: _titleController.text.isEmpty ?
                          '(untitled event)' : _titleController.text,
                        description: _descController.text,
                        date: date,
                        status: EventStatus.inProgress
                      );
                      eventOperations.createEvent(event);
                      Navigator.of(context).pushReplacementNamed('home');
                    },
                    child: Center(
                      child: Text(
                        'Add Event',
                        style: TextStyle(
                            color: Colors.white,
                          fontSize: 25
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
