import 'package:mobile_be/pages/announcement/ann_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'announcements.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE announcements(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, image TEXT, description TEXT, date TEXT)',
        );
      },
    );
  }

  Future<void> insertAnnouncement(Announcement announcement) async {
    final db = await database;
    try {
      await db.insert(
        'announcements',
        announcement.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting announcement: $e');
    }
  }

  Future<List<Announcement>> getAnnouncements() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('announcements');

    return List.generate(maps.length, (i) {
      return Announcement.fromMap(maps[i]);
    });
  }

  Future<void> updateAnnouncement(Announcement announcement) async {
    final db = await database;
    try {
      await db.update(
        'announcements',
        announcement.toMap(),
        where: 'id = ?',
        whereArgs: [announcement.id],
      );
    } catch (e) {
      print('Error updating announcement: $e');
    }
  }

  Future<void> deleteAnnouncement(int id) async {
    final db = await database;
    try {
      await db.delete(
        'announcements',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting announcement: $e');
    }
  }
}
