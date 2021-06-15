import 'package:project_testing/database/database.dart';
import 'package:project_testing/calendar_utils/event_object.dart';
import 'package:intl/intl.dart';

class EventOperations {
  DatabaseRepository dbProvider = DatabaseRepository.instance;

  createEvent(Event event) async {
    final db = await dbProvider.database;
    final id = await db.insert(eventTableName, event.toMap());

    return event.copy(id: id);
  }

  updateEvent(Event event) async {
    final db = await dbProvider.database;
    return await db.update(eventTableName, event.toMap(),
        where: '${EventTableFields.id}=?', whereArgs: [event.id]);
  }

  deleteEvent(Event event) async {
    final db = await dbProvider.database;
    return await db.delete(eventTableName,
        where: '${EventTableFields.id}=?', whereArgs: [event.id]);
  }

  Future<List<Event>> getAllEvents() async {
    final db = await dbProvider.database;
    var allRows = await db.query(eventTableName);
    List<Event> events = allRows.map((event) => Event.fromMap(event)).toList();

    return events;
  }

  Future<List<Event>> getEventsForDay(DateTime date) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> eventList = await db.query(eventTableName,
        where: '${EventTableFields.date}=?',
        whereArgs: [DateFormat('yyyy.MM.dd').format(date)]);
    List<Event> events =
    eventList.map((event) => Event.fromMap(event)).toList();

    return events;
  }

  Future<List<Event>> getEventsByWeek(int weekNumber) async {
    List<Event> allevents = await getEventsThisMonth();
    List<Event> results = [];
    allevents.forEach((event) {
      if (event.week == weekNumber) {
        results.add(event);
      }
    });
    return results;
  }

  Future<List<Event>> getEventsThisMonth() async {
    List<Event> allevents = await getAllEvents();
    List<Event> results = [];
    allevents.forEach((event) {
      if (event.date.month == DateTime.now().month) {
        results.add(event);
      }
    });
    return results;
  }


  Future<List<Event>> getCloseEvents() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> eventList = await db.query(eventTableName,
        where: '${EventTableFields.isClose}=?',
        whereArgs: [1]);
    List<Event> events =
        eventList.map((event) => Event.fromMap(event)).toList();

    return events;
  }

  Future<List<Event>> getPastEvents() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> eventList = await db.query(eventTableName,
        where: '${EventTableFields.isPast}=?',
        whereArgs: [1]);
    List<Event> events =
    eventList.map((event) => Event.fromMap(event)).toList();

    return events;
  }
}
