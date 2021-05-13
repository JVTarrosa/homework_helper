import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_testing/database/event_operations.dart';
import 'package:project_testing/calendar_utils/event_item.dart';
import 'work_status_item.dart';

class EventsList extends StatelessWidget {
  List<Event>? events;

  EventsList(this.events, {Key? key}) : super(key: key);
  EventOperations eventOperations = EventOperations();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: events!.length ,
          itemBuilder: (BuildContext context, int index) {
            return WorkStatusItem(
              key: UniqueKey(),
              events: events ?? [],
              index: index,
            );
          },
        ),
      ]),
    );
  }
}

Widget listItem({
  required BuildContext context,
  required List<Event> events,
  required int index,
  required Color iconColor,
  required Color iconBG,
  required Color listBarColor,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Container(
      decoration: BoxDecoration(
        color: listBarColor,
        // borderRadius: BorderRadius.circular(10)
      ),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 80,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconBG,
              // borderRadius: BorderRadius.circular(10)
            ),
            width: 80,
            height: 80,
            child: Icon(Icons.menu_book_outlined, size: 70, color: iconColor),
          ),
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ID: ${events[index].id}'),
                  Text(
                    events[index].title.length < 25
                        ? '${events[index].title}'
                        : events[index].title.substring(0, 25) + '...',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: events[index].title.length < 20 ? 25 : 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          ' ${events[index].description}',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
