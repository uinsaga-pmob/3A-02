import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._();
  DBHelper._();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mydiary.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE diary(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            judul TEXT NOT NULL,
            isi TEXT NOT NULL,
            tanggal TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertDiary(DiaryItem item) async {
    final database = await db;
    return database.insert('diary', item.toMap());
  }

  Future<List<DiaryItem>> getAllDiary() async {
    final database = await db;
    final result = await database.query('diary', orderBy: 'id DESC');
    return result.map((e) => DiaryItem.fromMap(e)).toList();
  }

  Future<int> updateDiary(DiaryItem item) async {
    final database = await db;
    return database.update(
      'diary',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteDiary(int id) async {
    final database = await db;
    return database.delete('diary', where: 'id = ?', whereArgs: [id]);
  }
}
