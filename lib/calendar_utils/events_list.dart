import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_testing/calendar_utils/edit_event_page_alt.dart';
import 'package:project_testing/database/event_operations.dart';
import 'package:project_testing/calendar_utils/event_item.dart';
import 'package:project_testing/menus/snackbar.dart';
import 'custom_dismissible.dart';
import 'edit_event_page_alt.dart';

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
            return CustomDismissible(
              key: UniqueKey(),

              // CUSTOM DISMISSIBLE PARAMETER
              item: events![index],

              child: listItem(
                  context: context,
                  events: events ??= [],
                  index: index,
                  iconBG: Theme
                      .of(context)
                      .accentColor,
                  listBarColor: Theme
                      .of(context)
                      .focusColor
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  eventOperations.deleteEvent(events![index]);
                  EditableSnackBar.showSnackBar(
                      context, 'Event has been deleted');
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditEvent(event: events![index]);
                  }));
                }
              },
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
            child: Image.asset('assets/event_icons/${events[index].icon}.png'),
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
