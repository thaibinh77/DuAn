import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/image.dart';
import 'database_helper.dart';

class ImageDatabaseHelper {
  // Singleton pattern
  DatabaseHelper _databaseService = DatabaseHelper();

  // Public constructor
  ImageDatabaseHelper();

  Future<void> insertImage(ImageModel image) async {
    final db = await _databaseService.database;

    await db.insert(
      'image',
      image.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<ImageModel>> images() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('IMAGE');
    return List.generate(
        maps.length, (index) => ImageModel.fromMap(maps[index]));
  }

  Future<ImageModel> image(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
    await db.query('IMAGE', where: 'imageId = ?', whereArgs: [id]);
    return ImageModel.fromMap(maps[0]);
  }

  Future<void> updateImage(ImageModel img) async {
    final db = await _databaseService.database;
    await db.update(
      'IMAGE',
      img.toMap(),
      where: 'imageId = ?',
      whereArgs: [img.id],
    );
  }
}