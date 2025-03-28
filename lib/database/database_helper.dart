import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'diagnoses.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE diagnoses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        disease TEXT NOT NULL,
        date TEXT NOT NULL,
        imagePath TEXT NOT NULL
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getDiagnoses() async {
    final db = await database;
    return await db.query('diagnoses', orderBy: 'date DESC');
  }

  Future<void> insertDiagnosis(String disease, String imagePath) async {
    final db = await database;
    await db.insert('diagnoses', {
      'disease': disease,
      'date': DateTime.now().toIso8601String(),
      'imagePath': imagePath,
    });
  }

  Future<String> saveImage(File image) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    String path = join(documentsDirectory.path, fileName);
    await image.copy(path);
    return path;
  }
}
