import '../study_lock_utils/time_input_object.dart';
import 'database.dart';

class TimeInputOperations {
  DatabaseRepository dbProvider = DatabaseRepository.instance;

  createTimeInput(TimeInput timeInput) async {
    final db = await dbProvider.database;
    final id = await db.insert(timeTableName, timeInput.toMap());

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

    return timeInputs;
  }
  
}