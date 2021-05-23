import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_testing/calendar_utils/edit_event_page.dart';
import 'package:project_testing/database/event_operations.dart';
import 'package:project_testing/calendar_utils/event_object.dart';
import 'custom_dismissible.dart';
import 'package:intl/intl.dart';
import 'edit_event_page.dart';

class EventsList extends StatelessWidget {
  List<Event>? events;

  EventsList(this.events, {Key? key}) : super(key: key);
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
                return CustomDismissible(
                  key: UniqueKey(),

                  // CUSTOM DISMISSIBLE PARAMETER
                  item: events![index],

                  child: listItem(
                    context: context,
                    events: events ??= [],
                    index: index,
                    iconBG: Theme.of(context).cardColor,
                    listBarColor: Theme.of(context).focusColor,
                    statusMarkerColor: statusColor(events![index].status),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      eventOperations.deleteEvent(events![index]);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Event has been deleted'),
                          actions: [
                            Center(
                              child: TextButton(
                                  child: Container(
                                    height: 30,
                                    width: 80,
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor),
                                    ),
                                  ),
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacementNamed('home')),
                            )
                          ],
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return EditEvent(event: events![index]);
                      }));
                    }
                  },
                );
              },
            ),
          ]);
  }
}

Widget listItem({
  required BuildContext context,
  required List<Event> events,
  required int index,
  required Color iconBG,
  required Color listBarColor,
  required Color statusMarkerColor,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Container(
      decoration: BoxDecoration(
        color: listBarColor,
        // borderRadius: BorderRadius.circular(10)
      ),
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconBG,
            ),
            width: 80,
            height: 80,
            child: Image.asset('assets/event_icons/${events[index].icon}.png'),
          ),
          Container(
            decoration: BoxDecoration(
              color: statusMarkerColor,
              border: Border.all(
                color: Colors.black12,
                width: 2,
              ),
            ),
            width: 10,
          ),
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${DateFormat('MM/dd/yyyy').format(events[index].date)}',
                      style: TextStyle(color: Colors.white)),
                  Text(
                    events[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: events[index].title.length < 20 ? 25 : 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          events[index].description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: events[index].description.length < 50
                                  ? 15
                                  : 10,
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
