import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_testing/accessories/titled_border.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'event_object.dart';
import 'package:project_testing/database/event_operations.dart';
import 'package:project_testing/calendar_utils/events_list.dart';

import 'package:project_testing/calendar_utils/add_or_edit_event_page.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final DateFormat dateFormat = DateFormat('yyyy.MM.dd');

  Map<DateTime, List<Event>> events = {};
  EventOperations eventOperations = EventOperations();

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    _refreshEvents();
  }

  void _refreshEvents() async {
    var allEvents = await eventOperations.getAllEvents();
    for (var event in allEvents) {
      event.refreshDateStatus();
      eventOperations.updateEvent(event);
    }
  }

  void _fetchEvents() async {
    events = {};
    List<Event> allEvents = await eventOperations.getAllEvents();
    allEvents.forEach((event) {
      if (events.containsKey(event.date)) {
        events[event.date]!.add(event);
      } else {
        events[event.date] = [event];
      }
    });
    setState(() {});
  }

  List<Event> getEventsThisDay(DateTime date) {
    return events[DateFormat('yyyy.MM.dd')
            .parse(DateFormat('yyyy.MM.dd').format(date))] ??
        [];
  }

  //Calendar Widget
  Widget calendar() {
    return Container(
      key: Key('calendar_container'),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 10, blurRadius: 5)
          ]),
      child: TableCalendar(
        eventLoader: getEventsThisDay,

        // This formats the header of the calendar where the month label is
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 23,
              fontWeight: FontWeight.bold),
        ),

        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,

          // This formats the highlight for the selected day on Calendar
          selectedDecoration: BoxDecoration(
              shape: BoxShape.rectangle, color: Theme.of(context).focusColor),
          selectedTextStyle: TextStyle(color: Colors.white),

          // This formats the highlight for the current day on Calendar
          todayDecoration: BoxDecoration(
              shape: BoxShape.circle, color: Theme.of(context).focusColor),
          todayTextStyle: TextStyle(color: Colors.white70),
          defaultTextStyle: TextStyle(color: Theme.of(context).accentColor),

          markerDecoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
          weekendStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
        ),

        firstDay: DateTime.utc(1990),
        lastDay: DateTime.utc(2050),
        focusedDay: focusedDay,

        selectedDayPredicate: (day) {
          return isSameDay(selectedDay, day);
        },

        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          setState(() {
            selectedDay = selectDay;
            focusedDay = focusDay;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(children: [
        Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                // CALENDAR WIDGET CREATED ABOVE
                calendar(),

                titledBorder(context,
                    'Events This Day (${DateFormat('MM/dd').format(selectedDay)})'),

                // EVENTS LIST FOR THIS DAY
                FutureBuilder(
                  future: eventOperations.getEventsForDay(selectedDay),
                  builder: (context, AsyncSnapshot<List<Event>> snapshot) {
                    if (snapshot.hasError) {
                      print('snapshot error');
                    }
                    var data = snapshot.data;
                    return snapshot.hasData
                        ? EventsList(data)
                        : CircularProgressIndicator();
                  },
                ),

                titledBorder(context, 'Upcoming Events'),

                // CLOSE EVENTS LIST
                FutureBuilder(
                  future: eventOperations.getCloseEvents(),
                  builder: (context, AsyncSnapshot<List<Event>> snapshot) {
                    if (snapshot.hasError) {
                      print('snapshot error');
                    }
                    var data = snapshot.data;
                    return snapshot.hasData
                        ? EventsList(data)
                        : CircularProgressIndicator();
                  },
                ),

                titledBorder(context, 'Past Events'),

                FutureBuilder(
                  future: eventOperations.getPastEvents(),
                  builder: (context, AsyncSnapshot<List<Event>> snapshot) {
                    if (snapshot.hasError) {
                      print('snapshot error');
                    }
                    var data = snapshot.data;
                    return snapshot.hasData
                        ? EventsList(data)
                        : CircularProgressIndicator();
                  },
                ),
              ],
            )),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddOrEditEvent(date: selectedDay),
            ),
          );
          _fetchEvents();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
