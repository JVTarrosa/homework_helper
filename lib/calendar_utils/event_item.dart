import 'package:intl/intl.dart';

enum EventStatus {
  skipped,
  onHold,
  inProgress,
  complete
}

String statusToString(EventStatus? eventStatus) {
  switch (eventStatus) {
    case EventStatus.skipped:
      return 'skipped';
    case EventStatus.onHold:
      return 'onHold';
    case EventStatus.inProgress:
      return 'inProgress';
    default:
      return 'complete';
  }
}

EventStatus stringToStatus(String string) {
  switch (string) {
    case 'skipped':
      return EventStatus.skipped;
    case 'onHold':
      return EventStatus.onHold;
    case 'inProgress':
      return EventStatus.inProgress;
    default:
      return EventStatus.complete;
  }
}

final String eventTableName = 'eventTable';

class EventTableFields {
  static final String id = 'eventID';
  static final String title = 'eventTitle';
  static final String description = 'eventDesc';
  static final String date = 'eventDate';
  static final String status = 'eventStatus';
}

class Event {
  int? id;
  late String title;
  late String description;
  DateTime date;
  EventStatus? status;

  Event({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status
  });

  Event copy({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    EventStatus? status
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      status: status ?? this.status
    );
}



  static Event fromMap(Map<String, dynamic> obj) {
    return Event(
      id: obj[EventTableFields.id] as int?,
      title: obj[EventTableFields.title] as String,
      description: obj[EventTableFields.description] as String,
      date: DateFormat('yyyy.MM.dd').parse(obj[EventTableFields.date]),
      status: stringToStatus(obj[EventTableFields.status])
    );

  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      EventTableFields.id: id,
      EventTableFields.title: title,
      EventTableFields.description: description,
      EventTableFields.date: DateFormat('yyyy.MM.dd').format(date),
      EventTableFields.status: statusToString(status)
    };
  }

}

