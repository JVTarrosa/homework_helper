import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum EventStatus {
  skipped,
  onHold,
  inProgress,
  complete
}

Color statusColor(EventStatus? eventStatus) {
  // ignore: missing_enum_constant_in_switch
  switch (eventStatus) {
    case EventStatus.skipped:
      return Colors.black26;
    case EventStatus.onHold:
      return Colors.orangeAccent;
    case EventStatus.inProgress:
      return Color.fromARGB(255, 255, 112, 67);
    case EventStatus.complete:
      return Color.fromARGB(255, 67, 160, 71);
    case null:
      return Colors.white;
  }
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
  static final String week = 'eventWeek';
  static final String status = 'eventStatus';
  static final String icon = 'eventIcon';
  static final String isClose = 'eventIsClose';
  static final String isPast = 'eventIsPast';
}

int weekAssignment(DateTime date) {
  var now = DateTime.now();
  var lastDay = DateTime(now.year, now.month + 1, 0).day;
  if (date.isBefore(DateTime(now.year, now.month, 8))) {
    return 1;
  } else if (date.isAfter(DateTime(now.year, now.month, 7))
      && date.isBefore(DateTime(now.year, now.month, 15))) {
    return 2;
  } else if (date.isAfter(DateTime(now.year, now.month, 14))
      && date.isBefore(DateTime(now.year, now.month, 22))) {
    return 3;
  } else if (date.isAfter(DateTime(now.year, now.month, 21))
      && date.isBefore(DateTime(now.year, now.month, lastDay))) {
    return 4;
  }
  return 0;
}

class Event implements Comparable<Event>{
  int? id;
  late String title;
  late String description;
  DateTime date;
  late int week;
  EventStatus? status;
  int icon;
  late bool isClose;
  late bool isPast;

  DateTime now = DateTime.now();

  @override
  int compareTo(Event other) {
    var thisDifference = this.date.difference(now);
    var otherDifference = other.date.difference(now);
    return thisDifference.inDays.compareTo(otherDifference.inDays);
  }

  Event({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.icon
  }) {
   isClose = now.isAfter(date.subtract(Duration(days: 5))) && date.isAfter(now);
   isPast = date.isBefore(now);
   week = weekAssignment(date);
  }

  Event copy({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    EventStatus? status,
    int? icon,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      status: status ?? this.status,
      icon: icon ?? this.icon,
    );
}

  void refreshDateStatus() {
    isClose = (DateTime.now().isAfter(date.subtract(Duration(days: 5))) && date.isAfter(DateTime.now()));
    isPast = date.isBefore(DateTime.now());
  }

  static Event fromMap(Map<String, dynamic> obj) {
    return Event(
      id: obj[EventTableFields.id] as int?,
      title: obj[EventTableFields.title] as String,
      description: obj[EventTableFields.description] as String,
      date: DateFormat('yyyy.MM.dd').parse(obj[EventTableFields.date]),
      status: stringToStatus(obj[EventTableFields.status]),
      icon: obj[EventTableFields.icon] as int
    );

  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      EventTableFields.id: id,
      EventTableFields.title: title,
      EventTableFields.description: description,
      EventTableFields.date: DateFormat('yyyy.MM.dd').format(date),
      EventTableFields.week: week,
      EventTableFields.status: statusToString(status),
      EventTableFields.icon: icon,
      EventTableFields.isClose: isClose ? 1 : 0,
      EventTableFields.isPast: isPast ? 1 : 0
    };
  }

}

