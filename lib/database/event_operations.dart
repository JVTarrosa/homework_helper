import 'package:project_testing/database/database.dart';
import 'package:project_testing/calendar_utils/event_item.dart';
import 'package:intl/intl.dart';

class EventOperations {
  DatabaseRepository dbProvider = DatabaseRepository.instance;

  createEvent(Event event) async {
    final db = await dbProvider.database;
    final id = await db.insert(eventTableName, event.toMap());

    // DEBUGGING PRINT STATEMENT
    print(
      'CREATING THIS EVENT: \n'
      'ID: ${event.copy(id: id).id}\n'
      'TITLE: ${event.copy(id: id).title}\n'
      'DESCRIPTION: ${event.copy(id: id).description}\n'
      'DATE: ${event.copy(id: id).date} \n'
      'EVENT STATUS: ${event.copy(id: id).status} \n'

      'EVENT ICON: ${event.copy(id: id).icon}'
    );
    // DEBUGGING PRINT STATEMENT

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

    // DEBUGGING PRINT STATEMENT
    print('RUNNING METHOD getAllEvents()');
    events.forEach((event) => print(
        'ADDING THIS EVENT: \n'
            'ID: ${event.id}\n'
            'TITLE: ${event.title}\n'
            'DESCRIPTION: ${event.description}\n'
            'DATE: ${event.date} \n'
            'EVENT STATUS: ${event.status}\n'
            'EVENT ICON: ${event.icon}'
    ));
    // DEBUGGING PRINT STATEMENT

    return events;
  }

  Future<List<Event>> getEventsForDay(DateTime date) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> eventList = await db.query(eventTableName,
        where: '${EventTableFields.date}=?',
        whereArgs: [DateFormat('yyyy.MM.dd').format(date)]);
    List<Event> events =
    eventList.map((event) => Event.fromMap(event)).toList();

    // DEBUGGING PRINT STATEMENT
    print('RUNNING METHOD getEventsForDay($date)');
    events.forEach((event) => print(
        'LISTED EVENT: \n'
            'ID: ${event.id}\n'
            'TITLE: ${event.title}\n'
            'DESCRIPTION: ${event.description}\n'
            'DATE: ${event.date} \n'
            'EVENT STATUS: ${event.status}\n'
            'EVENT ICON: ${event.icon}'
    ));
    // DEBUGGING PRINT STATEMENT

    return events;
  }

  Future<List<Event>> getCloseEvents() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> eventList = await db.query(eventTableName,
        where: '${EventTableFields.isClose}=?',
        whereArgs: [1]);
    List<Event> events =
        eventList.map((event) => Event.fromMap(event)).toList();

    // DEBUGGING PRINT STATEMENT
    print('RUNNING METHOD getCloseEvents()');
    events.forEach((event) => print(
        'LISTED EVENT: \n'
            'ID: ${event.id}\n'
            'TITLE: ${event.title}\n'
            'DESCRIPTION: ${event.description}\n'
            'DATE: ${event.date} \n'
            'EVENT STATUS: ${event.status}\n'
            'EVENT ICON: ${event.icon}'
    ));
    // DEBUGGING PRINT STATEMENT

    return events;
  }
}
