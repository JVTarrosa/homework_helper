import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:project_testing/calendar_utils/add_event_page_alt.dart';
import 'package:table_calendar/table_calendar.dart';
import 'event_item.dart';
import 'package:project_testing/database/event_operations.dart';
import 'package:project_testing/calendar_utils/events_list.dart';



class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final DateFormat dateFormat = DateFormat('yyyy.MM.dd');

  Map<DateTime, List<Event>> events = {};
  EventOperations eventOperations = EventOperations();

  // Map<DateTime, List<Event>> selectedEvents;
  // CalendarFormat calendarFormat = CalendarFormat.month;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  
  @override
  void initState() {
    // selectedEvents = {};
    super.initState();
    _fetchEvents();
  }

  void _fetchEvents() async{
    print('CALENDAR METHOD _fetchEvents() IS RUNNING');
    events = {};
    List<Event> allEvents = await eventOperations.getAllEvents();
    allEvents.forEach((event) {
      if(events.containsKey(event.date)){
        print('EVENT ADDED TO EXISTING DATE ON MAP: events[$events.date].add($event)');
        events[event.date]!.add(event);
      }
      else{
        print('NEW DATE ADDED TO MAP: events[$events.date] = [$event]');
        events[event.date] = [event];
      }
    }
    );
    setState(() {});
    print('EVENTS MAP $events');
  }

  List<Event> getEventsThisDay(DateTime date) {
    //
    // print('\nEVENTS MAP $events');
    // print('EVENTS MAP KEYS ${events.keys.toList()}');
    // print('DATE VALUE: $date');
    // print('events[$date] is null?: ${events[date] == null}');
    // print('');
    return events[DateFormat('yyyy.MM.dd').parse(DateFormat('yyyy.MM.dd').format(date))] ?? [];
  }

  //Calendar Widget
  Widget calendar() {
    return Container(
      key: Key('calendar_container'),
      margin:  EdgeInsets.fromLTRB(10, 0, 10, 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 10,
            blurRadius: 5
          )
        ]
      ),
      child: TableCalendar(

        eventLoader: getEventsThisDay,

        // This formats the header of the calendar where the month label is
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 23,
            fontWeight: FontWeight.bold
          ),
        ),

        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,

          // This formats the highlight for the selected day on Calendar
          selectedDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).focusColor
          ),
          selectedTextStyle: TextStyle(
            color: Colors.white
          ),

            // This formats the highlight for the current day on Calendar
          todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).focusColor
          ),
          todayTextStyle: TextStyle(
              color: Colors.white70
          ),

          defaultTextStyle: TextStyle(
            color: Theme.of(context).accentColor
          )
        ),

        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold
          ),
          weekendStyle: TextStyle(
            color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold
          ),
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
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                // CALENDAR WIDGET CREATED ABOVE
                calendar(),

                //FUTURE BUILDER FOR EVENT LIST
                FutureBuilder(
                  future: eventOperations.getEventsForDay(selectedDay),
                  builder: (context, AsyncSnapshot<List<Event>> snapshot){
                    if (snapshot.hasError) {
                      print('snapshot error');
                    }
                    var data = snapshot.data;
                    return snapshot.hasData ? EventsList(data) : Text('no data');
                  },
                )
              ],
            )
          ),
        ]
      ),
      
      
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AddEvent(dateSelected: selectedDay))
          );
          _fetchEvents();
        },
        child: Icon(
          Icons.add
        ),
      ),
    );
  }






}
