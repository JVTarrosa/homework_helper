import 'package:flutter/material.dart';
import 'package:project_testing/menus/drawer_menus.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_testing/database/event_operations.dart';
import 'event_item.dart';

class EditEvent extends StatefulWidget {
  final Event event;

  EditEvent({
    Key? key,
    required this.event
  }) : super(key: key,);

  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  EventOperations eventOperations = EventOperations();

  final formKey =  GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descController = TextEditingController();


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    _titleController.text = widget.event.title ?? '';
    _descController.text = widget.event.description ?? '';

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
              'Edit Event',
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
                      border: OutlineInputBorder(),
                      labelText: 'Event Title'),
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
                      widget.event.title = _titleController.text;
                      widget.event.description = _descController.text;
                      eventOperations.updateEvent(widget.event);
                      Navigator.of(context).pushReplacementNamed('home');
                    },
                    child: Center(
                      child: Text(
                        'Edit Event',
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
