import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_testing/database/event_operations.dart';
import 'package:project_testing/calendar_utils/event_object.dart';
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
        ? Container(
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                '(No Events)',
                style: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    )
        : Column(children: [
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
