import 'package:flutter/material.dart';
import 'package:project_testing/database/event_operations.dart';
import 'event_item.dart';
import 'event_form.dart';
import 'package:project_testing/menus/drawer_menus.dart';

class EditEvent extends StatefulWidget {
  final Event? event;

  const EditEvent({
    Key? key,
    this.event,
  }) : super(key: key);
  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  EventOperations eventOperations = EventOperations();
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.event?.title ?? '';
    description = widget.event?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
          'Edit Event',
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ),
    body: Container(
      color: Theme.of(context).primaryColor,
      child: Form(
        key: _formKey,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EventForm(
                title: title,
                description: description,
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                generalTextColor: Theme.of(context).accentColor,
              ),
              buildButton()
              ]
          ),
        ),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? Theme.of(context).accentColor : Colors.grey.shade700,
        ),
        onPressed: (){
          updateEvent();
          Navigator.of(context).pushReplacementNamed('home');
        },
        child: Text('Save'),
      ),
    );
  }

  // void addOrUpdateEvent() {
  //   final isValid = _formKey.currentState!.validate();
  //
  //   if (isValid) {
  //     final isUpdating = widget.event != null;
  //
  //     if (isUpdating) {
  //       updateEvent();
  //     } else {
  //      addEvent();
  //     }
  //
  //     Navigator.of(context).pushReplacementNamed('home');
  //   }
  // }

  updateEvent() {
    final event = widget.event!.copy(
      title: title,
      description: description,
    );
    eventOperations.updateEvent(event);

    print(
        'EVENT UPDATED:\n'
            'TITLE: $title\n'
            'DESC: $description'
    );
  }

  // addEvent() {
  //   final event = Event(
  //     title: title,
  //     description: description,
  //     date: dateSelected ?? widget.event!.date,
  //     status: EventStatus.inProgress
  //   );
  //   eventOperations.createEvent(event);
  //
  //   print(
  //       'EVENT CREATED:\n'
  //           'TITLE: $title\n'
  //           'DESC: $description'
  //   );
  // }
}
