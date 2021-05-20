import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project_testing/calendar_utils/event_object.dart';
import '../study_lock_utils/time_input_object.dart';


class DatabaseRepository {
  static final DatabaseRepository instance =
  DatabaseRepository.init();

  static Database? _database;

  DatabaseRepository.init();

  final _databaseName = 'database';
  final _databaseVersion = 1;

  Future<Database> get database async {
    if (_database != null) {
      print('A database exists');
      return _database!;
    }
    print('No database exists, starting _initDatabase()');
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documents = await getApplicationDocumentsDirectory();
    String path = join(documents.path + _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final intType = 'INTEGER NOT NULL';

    await db.execute('''
          CREATE TABLE $eventTableName (
            ${EventTableFields.id} $idType,
            ${EventTableFields.title} $textType,
            ${EventTableFields.description} $textType,
            ${EventTableFields.date} $textType,
            ${EventTableFields.status} $textType,
            ${EventTableFields.icon} $intType,
            ${EventTableFields.isClose} $intType
          )
          ''');

    await db.execute('''
          CREATE TABLE $timeTableName (
            ${TimeTableFields.id} $idType,
            ${TimeTableFields.name} $textType,
            ${TimeTableFields.studyTime} $intType,
            ${TimeTableFields.pauseTIme} $intType,
            ${TimeTableFields.cycle} $intType
          )
          ''');
  }

}
