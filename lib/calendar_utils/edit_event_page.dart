import 'package:flutter/material.dart';
import 'package:project_testing/database/event_operations.dart';
import 'event_object.dart';
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
  late int icon;

  @override
  void initState() {
    super.initState();

    title = widget.event?.title ?? '';
    description = widget.event?.description ?? '';
    icon = widget.event?.icon ?? 1;
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
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Form(
            key: _formKey,
            child: Container(
              child: ListView(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: changeIconPortion(),
                    ),
                    EventForm(
                      context: context,
                      title: title,
                      description: description,
                      onChangedTitle: (title) =>
                          setState(() => this.title = title),
                      onChangedDescription: (description) =>
                          setState(() => this.description = description),
                      generalTextColor: Theme.of(context).accentColor,
                    ),
                    buildButton()
                  ],
                ),
              ]),
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
          primary: isFormValid
              ? Theme.of(context).accentColor
              : Colors.grey.shade700,
        ),
        onPressed: () {
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
    final event =
        widget.event!.copy(title: title, description: description, icon: icon);
    eventOperations.updateEvent(event);

    print('EVENT UPDATED:\n'
        'TITLE: $title\n'
        'DESC: $description');
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

  Widget editIconButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.white, primary: Theme.of(context).accentColor),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Icon Select'),
                    actions: [ListView(children: [iconSelection()])],
                  ));
        },
        child: Text('Change Icon'),
      ),
    );
  }

  Widget changeIconPortion() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset('assets/event_icons/$icon.png'),
                ),
                editIconButton()
              ],
            ),
          ),
        ),
      ],
    );
  }

  final double iconPadding = 2;

  // ICON SELECTION
  Widget iconSelection() => Container(
        child: Column(
          children: [
            Row(
              // FIRST ROW
              children: [
                Padding(
                  padding: EdgeInsets.all(iconPadding),
                  child: TextButton(
                    child: Container(
                        padding: EdgeInsets.all(iconPadding),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.asset('assets/event_icons/1.png')),
                    onPressed: () {
                      icon = 1;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(iconPadding),
                  child: TextButton(
                    child: Container(
                        padding: EdgeInsets.all(iconPadding),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.asset('assets/event_icons/2.png')),
                    onPressed: () {
                      icon = 2;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(iconPadding),
                  child: TextButton(
                    child: Container(
                        padding: EdgeInsets.all(iconPadding),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.asset('assets/event_icons/3.png')),
                    onPressed: () {
                      icon = 3;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            Row(
              // SECOND ROW
              children: [
                Padding(
                  padding: EdgeInsets.all(iconPadding),
                  child: TextButton(
                    child: Container(
                        padding: EdgeInsets.all(iconPadding),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.asset('assets/event_icons/4.png')),
                    onPressed: () {
                      icon = 4;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(iconPadding),
                  child: TextButton(
                    child: Container(
                        padding: EdgeInsets.all(iconPadding),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.asset('assets/event_icons/5.png')),
                    onPressed: () {
                      icon = 5;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(iconPadding),
                  child: TextButton(
                    child: Container(
                        padding: EdgeInsets.all(iconPadding),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.asset('assets/event_icons/6.png')),
                    onPressed: () {
                      icon = 6;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            Row(
              // THIRD ROW
              children: [
                Padding(
                  padding: EdgeInsets.all(iconPadding),
                  child: TextButton(
                    child: Container(
                        padding: EdgeInsets.all(iconPadding),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.asset('assets/event_icons/7.png')),
                    onPressed: () {
                      icon = 7;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(iconPadding),
                  child: TextButton(
                    child: Container(
                        padding: EdgeInsets.all(iconPadding),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.asset('assets/event_icons/8.png')),
                    onPressed: () {
                      icon = 8;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(iconPadding),
                  child: TextButton(
                    child: Container(
                        padding: EdgeInsets.all(iconPadding),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.asset('assets/event_icons/9.png')),
                    onPressed: () {
                      icon = 9;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            Row(
              // FOURTH ROW
              children: [
                Padding(
                  padding: EdgeInsets.all(iconPadding),
                  child: TextButton(
                    child: Container(
                        padding: EdgeInsets.all(iconPadding),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.asset('assets/event_icons/10.png')),
                    onPressed: () {
                      icon = 10;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(iconPadding),
                  child: TextButton(
                    child: Container(
                        padding: EdgeInsets.all(iconPadding),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.asset('assets/event_icons/11.png')),
                    onPressed: () {
                      icon = 11;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(iconPadding),
                  child: TextButton(
                    child: Container(
                        padding: EdgeInsets.all(iconPadding),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.asset('assets/event_icons/12.png')),
                    onPressed: () {
                      icon = 12;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
