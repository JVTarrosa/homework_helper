import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_testing/pages/work_status_page.dart';

enum EventStatus {
  skipped,
  onHold,
  inProgress,
  complete
}

String eventStatusToString(EventStatus eventStatus) {
  switch (eventStatus) {
    case EventStatus.skipped:
      return 'skipped';
    case EventStatus.onHold:
      return 'onHold';
      break;
    case EventStatus.inProgress:
      return 'inProgress';
    default:
      return 'complete';
  }
}

EventStatus stringToEventStatus(String string) {
  switch (string) {
    case 'skipped':
      return EventStatus.skipped;
    case 'onHold':
      return EventStatus.onHold;
      break;
    case 'inProgress':
      return EventStatus.inProgress;
    default:
      return EventStatus.complete;
  }
}


class Event {
  int id;
  String title;
  String description;
  DateTime date;
  EventStatus eventStatus;
  final DateFormat dateFormat = DateFormat('yyyy.MM.dd');

  Event({
    @required this.title,
    @required this.description,
    @required this.date,
    @required this.eventStatus
  });

  Event.fromMap(dynamic obj) {
    this.id = obj['eventId'];
    this.title = obj['eventTitle'];
    this.description = obj['eventDesc'];
    this.date = dateFormat.parse(obj['eventDate']);
    this.eventStatus = stringToEventStatus(obj['eventStatus']);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'eventTitle': title,
      'eventDesc': description,
      'eventDate' : dateFormat.format(date),
      'eventStatus' : eventStatusToString(eventStatus)
    };
    return map;
  }

}

