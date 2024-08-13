import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/program.dart';
import 'database_helper.dart';

class ProgramDatabaseHelper {
  // Singleton pattern
  DatabaseHelper _databaseService = DatabaseHelper();

  // Public constructor
  ProgramDatabaseHelper();

  Future<void> insertProgram(Program program) async {
    final db = await _databaseService.database;

    await db.insert(
      'image',
      program.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<Program>> programs() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('PROGRAM');
    return List.generate(
        maps.length, (index) => Program.fromMap(maps[index]));
  }

  Future<Program> program(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
    await db.query('PROGRAM', where: 'programId = ?', whereArgs: [id]);
    return Program.fromMap(maps[0]);
  }

  Future<void> updateProgram(Program program) async {
    final db = await _databaseService.database;
    await db.update(
      'PROGRAM',
      program.toMap(),
      where: 'programId = ?',
      whereArgs: [program.id],
    );
  }
}