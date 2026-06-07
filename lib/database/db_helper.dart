import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper instance = DBHelper._();

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
      version: 3,

      onCreate: (database, version) async {
        // TABEL DIARY
        await database.execute('''
          CREATE TABLE diary(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            judul TEXT NOT NULL,
            isi TEXT NOT NULL,
            tanggal TEXT NOT NULL,
            isFavorite INTEGER NOT NULL DEFAULT 0
          )
        ''');

        // TABEL USERS
        await database.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL
          )
        ''');
      },

      onUpgrade: (database, oldVersion, newVersion) async {
        // UNTUK VERSION 2
        if (oldVersion < 2) {
          await database.execute(
            'ALTER TABLE diary ADD COLUMN isFavorite INTEGER NOT NULL DEFAULT 0',
          );
        }

        // UNTUK VERSION 3
        if (oldVersion < 3) {
          await database.execute('''
            CREATE TABLE users(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              email TEXT NOT NULL UNIQUE,
              password TEXT NOT NULL
            )
          ''');
        }
      },
    );
  }

  // =========================
  // DIARY
  // =========================

  Future<int> insertDiary(DiaryItem item) async {
    final database = await db;

    return database.insert('diary', item.toMap());
  }

  Future<List<DiaryItem>> getAllDiary() async {
    final database = await db;

    final result = await database.query('diary', orderBy: 'id DESC');

    return result.map((e) => DiaryItem.fromMap(e)).toList();
  }

  Future<List<DiaryItem>> getFavoriteDiary() async {
    final database = await db;

    final result = await database.query(
      'diary',
      where: 'isFavorite = ?',
      whereArgs: [1],
      orderBy: 'id DESC',
    );

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

  Future<int> toggleFavorite(int id, int value) async {
    final database = await db;

    return database.update(
      'diary',
      {'isFavorite': value},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // =========================
  // USERS
  // =========================

  // REGISTER USER
  Future<int> registerUser(String email, String password) async {
    final database = await db;

    return await database.insert('users', {
      'email': email,
      'password': password,
    });
  }

  // LOGIN USER
  Future<bool> loginUser(String email, String password) async {
    final database = await db;

    final result = await database.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }

  // CEK EMAIL
  Future<bool> checkEmailExists(String email) async {
    final database = await db;

    final result = await database.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    return result.isNotEmpty;
  }

  // UPDATE PASSWORD
  Future<int> updatePassword(String email, String newPassword) async {
    final database = await db;

    return database.update(
      'users',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
