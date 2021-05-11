import 'package:project_testing/database/database.dart';
import 'package:project_testing/calendar_utils/event_item.dart';
import 'package:intl/intl.dart';

class EventOperations {
  DatabaseRepository dbProvider = DatabaseRepository.instance;
  final DateFormat dateFormat = DateFormat('yyyy.MM.dd');

  createEvent(Event event) async {
    final db = await dbProvider.database;
    print(event.title);
    db.insert('eventTable', event.toMap());
    print('Event inserted');
  }

  updateEvent(Event event) async {
    final db = await dbProvider.database;
    db.update('eventTable', event.toMap(),
        where: 'eventId=?', whereArgs: [event.id]);
  }

  deleteEvent(Event event) async {
    final db = await dbProvider.database;
    db.delete('eventTable', where: 'eventId=?', whereArgs: [event.id]);
    print('event deleted');
  }

  Future<List<Event>> getAllEvents() async {
    final db = await dbProvider.database;
    var allRows = await db.query('eventTable');
    List<Event> events =
    allRows.map((event) => Event.fromMap(event)).toList();
    return events;
  }

  Future<List<Event>> getEventsForDay(DateTime date) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> eventList = await db.query(
        'eventTable',
        where: 'eventDate=?',
        whereArgs: [dateFormat.format(date)]
    );
    List<Event> events =
    eventList.map((event) => Event.fromMap(event)).toList();
    return events;
  }
}
