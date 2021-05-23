import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_testing/calendar_utils/event_object.dart';
import 'package:project_testing/database/event_operations.dart';
import 'package:intl/intl.dart';
import 'package:project_testing/accessories/snackbar.dart';

class CollapsingEventItem extends StatefulWidget {
  List<Event>? events;
  late int index;

  CollapsingEventItem(this.events, this.index, {Key? key}) : super(key: key);

  @override
  _CollapsingEventItemState createState() =>
      _CollapsingEventItemState(events, index);
}

class _CollapsingEventItemState extends State<CollapsingEventItem> {
  List<Event>? events;
  bool _isOpen = false;
  late int index;

  _CollapsingEventItemState(this.events, this.index);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        firstChild: TextButton(
          child: WorkStatusClosed(
            key: UniqueKey(),
            events: widget.events ?? [],
            index: this.index,
          ),
          onPressed: () => setState(() => _isOpen = true),
        ),
        secondChild: TextButton(
          child: WorkStatusItem(
            key: UniqueKey(),
            events: widget.events ?? [],
            index: index,
          ),
          onPressed: () => setState(() => _isOpen = false),
        ),
        crossFadeState:
            _isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 200));
  }
}

class WorkStatusItem extends StatefulWidget {
  List<Event> events;
  int index;
  EventStatus? radioGroupValue;

  WorkStatusItem({Key? key, required this.events, required this.index})
      : super(key: key);

  @override
  _WorkStatusItemState createState() =>
      _WorkStatusItemState(events: events, index: index);
}

class _WorkStatusItemState extends State<WorkStatusItem> {
  List<Event> events;
  int index;
  EventStatus? radioGroupValue;
  final EventOperations eventOperations = EventOperations();

  @override
  initState() {
    setState(() {
      radioGroupValue = events[index].status;
    });
    super.initState();
  }

  _WorkStatusItemState({
    required this.events,
    required this.index,
  });

  onChanged(EventStatus? val) {
    radioGroupValue = val;
    events[index].status = val;
    eventOperations.updateEvent(events[index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),

      // ACTUAL CONTAINER
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5,
                  spreadRadius: 3,
                  offset: Offset.fromDirection(20))
            ]),
        child: Column(
          children: [
            //TITLE CONTAINER
            Container(
              decoration: BoxDecoration(
                  color: statusColor(events[index].status),
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Row(
                children: [
                  SizedBox(width: 2),
                  Container(
                      decoration: BoxDecoration(
                          color: statusColor(events[index].status),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.white)),
                      width: 75,
                      height: 75,
                      child: Center(
                          child: Image.asset(
                              'assets/event_icons/${events[index].icon}.png'))),
                  Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              '${DateFormat('MM/dd/yyyy').format(events[index].date)}',
                              style: TextStyle(color: Colors.white)),
                          Text(
                            events[index].title.length < 25
                                ? '${events[index].title}'
                                : events[index].title.substring(0, 25) + '...',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    events[index].title.length < 20 ? 25 : 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //DESC AND RADIO CONTAINER
            Row(
              children: [
                //DESC CONTAINER
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    width: 175,
                    child: Center(
                        child: Text(
                      events[index].description,
                      style: TextStyle(color: Theme.of(context).accentColor),
                    )),
                  ),
                ),

                Container(
                  height: 200,
                  width: 1,
                  color: Theme.of(context).accentColor,
                ),

                //RADIO BUTTONS CONTAINER
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                        'CHANGE EVENT STATUS',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 11),
                        textAlign: TextAlign.center,
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // RADIO FOR SKIPPED
                            Row(
                              children: [
                                Radio(
                                  value: EventStatus.skipped,
                                  groupValue: radioGroupValue,
                                  onChanged: onChanged,
                                ),
                                Text(
                                  'Skipped',
                                  style: TextStyle(
                                      color: statusColor(EventStatus.skipped)),
                                )
                              ],
                            ),

                            // RADIO FOR ON HOLD
                            Row(
                              children: [
                                Radio(
                                    value: EventStatus.onHold,
                                    groupValue: radioGroupValue,
                                    onChanged: onChanged),
                                Text(
                                  'On Hold',
                                  style: TextStyle(
                                      color: statusColor(EventStatus.onHold)),
                                )
                              ],
                            ),

                            //RADIO FOR IN PROGRESS
                            Row(
                              children: [
                                Radio(
                                    value: EventStatus.inProgress,
                                    groupValue: radioGroupValue,
                                    onChanged: onChanged),
                                Text(
                                  'In Progress',
                                  style: TextStyle(
                                      color: statusColor(EventStatus.inProgress)),
                                )
                              ],
                            ),

                            //RADIO FOR COMPLETE
                            Row(
                              children: [
                                Radio(
                                    value: EventStatus.complete,
                                    groupValue: radioGroupValue,
                                    onChanged: onChanged),
                                Text(
                                  'Complete',
                                  style: TextStyle(
                                      color: statusColor(EventStatus.complete)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WorkStatusClosed extends StatefulWidget {
  List<Event> events;
  int index;

  WorkStatusClosed({Key? key, required this.events, required this.index})
      : super(key: key);

  @override
  _WorkStatusClosedState createState() =>
      _WorkStatusClosedState(events: events, index: index);
}

class _WorkStatusClosedState extends State<WorkStatusClosed> {
  List<Event> events;
  int index;
  final EventOperations eventOperations = EventOperations();

  @override
  initState() {
    super.initState();
  }

  _WorkStatusClosedState({
    required this.events,
    required this.index,
  });

  onChanged(EventStatus? val) {
    events[index].status = val;
    eventOperations.updateEvent(events[index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),

      // ACTUAL CONTAINER
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5,
                  spreadRadius: 3,
                  offset: Offset.fromDirection(20))
            ]),
        child: Column(
          children: [
            //TITLE CONTAINER
            Container(
              decoration: BoxDecoration(
                  color: statusColor(events[index].status),
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Row(
                children: [
                  SizedBox(width: 2),
                  Container(
                      decoration: BoxDecoration(
                          color: statusColor(events[index].status),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.white)),
                      width: 75,
                      height: 75,
                      child: Center(
                          child: Image.asset(
                              'assets/event_icons/${events[index].icon}.png'))),
                  Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              '${DateFormat('MM/dd/yyyy').format(events[index].date)}',
                              style: TextStyle(color: Colors.white)),
                          Text(
                            events[index].title.length < 25
                                ? '${events[index].title}'
                                : events[index].title.substring(0, 25) + '...',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    events[index].title.length < 20 ? 25 : 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
