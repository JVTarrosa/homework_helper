import '../study_lock_utils/time_input_object.dart';
import 'database.dart';
import 'package:intl/intl.dart';

class TimeInputOperations {
  DatabaseRepository dbProvider = DatabaseRepository.instance;

  createTimeInput(TimeInput timeInput) async {
    final db = await dbProvider.database;
    final id = await db.insert(timeTableName, timeInput.toMap());

    // DEBUGGING PRINT STATEMENT
    print(
        'CREATING INSTANCE OF TIMEINPUT: \n'
            'ID: ${timeInput.copy(id: id).id}\n'
            'STUDY TIME: ${timeInput.copy(id: id).studyTime}\n'
            'PAUSE TIME: ${timeInput.copy(id: id).pauseTime}\n'
            'CYCLES: ${timeInput.copy(id: id).cycle}'
    );
    // DEBUGGING PRINT STATEMENT
    return timeInput.copy(id: id);
  }

  updateTimeInput(TimeInput timeInput) async {
    final db = await dbProvider.database;
    return await db.update(timeTableName, timeInput.toMap(),
        where: '${TimeTableFields.id}=?', whereArgs: [timeInput.id]);
  }

  deleteTimeInput(TimeInput timeInput) async {
    final db = await dbProvider.database;
    return await db.delete(timeTableName,
        where: '${TimeTableFields.id}=?', whereArgs: [timeInput.id]);
  }

  Future<List<TimeInput>> getAllTimeInputs() async {
    final db = await dbProvider.database;
    var allRows = await db.query(timeTableName);
    List<TimeInput> timeInputs = allRows.map((timeInput) => TimeInput.fromMap(timeInput)).toList();

    // DEBUGGING PRINT STATEMENT
    print('RUNNING METHOD getAllEvents()');
    timeInputs.forEach((timeInput) => print(
        'ADDING THIS TIMEINPUT: \n'
            'ID: ${timeInput.id}\n'
            'STUDY TIME: ${timeInput.studyTime}\n'
            'PAUSE TIME: ${timeInput.pauseTime}\n'
            'CYCLE: ${timeInput.cycle} '
    ));
    // DEBUGGING PRINT STATEMENT

    return timeInputs;
  }
  
}