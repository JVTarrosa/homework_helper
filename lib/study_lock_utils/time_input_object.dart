import 'package:flutter/material.dart';

final String timeTableName = 'timeInputTable';

class TimeTableFields {
  static final String id = 'inputID';
  static final String name = 'inputName';
  static final String studyTime = 'inputStudyTime';
  static final String pauseTIme = 'inputPauseTime';
  static final String cycle = 'inputCycles';
}

class TimeInput {
  int? id;
  String? name;
  int studyTime;
  int pauseTime;
  int cycle;

  TimeInput(
      {this.id, this.name, required this.studyTime, required this.pauseTime, required this.cycle});

  TimeInput copy({
    int? id,
    String? name,
    int? studyTime,
    int? pauseTime,
    int? cycle
}) {
    return TimeInput(
      id: id ?? this.id,
      name: name ?? this.name,
      studyTime: studyTime ?? this.studyTime,
      pauseTime: pauseTime ?? this.pauseTime,
      cycle: cycle ?? this.cycle
    );
  }

  static TimeInput fromMap(Map<String, dynamic> json) {
    return TimeInput(
        id: json[TimeTableFields.id],
        name: json[TimeTableFields.name],
        studyTime: json[TimeTableFields.studyTime],
        pauseTime: json[TimeTableFields.pauseTIme],
        cycle: json[TimeTableFields.cycle]
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TimeTableFields.id: id,
      TimeTableFields.name: name,
      TimeTableFields.studyTime: studyTime,
      TimeTableFields.pauseTIme: pauseTime,
      TimeTableFields.cycle : cycle
    };
  }
}
