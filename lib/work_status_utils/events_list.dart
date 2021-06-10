import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_testing/database/event_operations.dart';
import 'package:project_testing/calendar_utils/event_object.dart';
import 'package:project_testing/accessories/titled_border.dart';
import 'work_status_item.dart';

class EventsList extends StatelessWidget {
  List<Event>? events;

  EventsList(this.events, {Key? key}) : super(key: key) {
    events!.sort();
  }

  EventOperations eventOperations = EventOperations();

  @override
  Widget build(BuildContext context) {
    return events!.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
              ),
              Icon(
                Icons.help_outline_rounded,
                size: 100,
                color: Theme.of(context).focusColor,
              ),
              Text(
                'No Events Recorded',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).focusColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        : Column(children: [
            titledBorder(context, 'All Events'),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: events!.length,
              itemBuilder: (BuildContext context, int index) {
                return CollapsingEventItem(events, index);
              },
            ),
          ]);
  }
}
