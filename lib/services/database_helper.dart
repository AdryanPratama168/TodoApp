import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:login_sqflite_getx/models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todo_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('Database upgrading from version $oldVersion to $newVersion');

    if (oldVersion < 2) {
      // Menambahkan tabel 'users' jika versi database kurang dari 2
      print('Creating users table in upgrade...');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          password TEXT
        )
      ''');
    }

    if (oldVersion < 3) {
      // Menambahkan kolom 'date' dan 'category' jika versi database kurang dari 3
      print('Adding date and category columns to tasks table...');
      try {
        await db.execute("ALTER TABLE tasks ADD COLUMN date TEXT DEFAULT ''");
        await db
            .execute("ALTER TABLE tasks ADD COLUMN category TEXT DEFAULT ''");
      } catch (e) {
        print('Error during migration: $e');
      }
    }
  }

  Future _createDB(Database db, int version) async {
    print('Creating database from scratch with version $version');

    // Membuat tabel tasks
    await db.execute('''
    CREATE TABLE tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      date TEXT,
      category TEXT
    )
    ''');

    // Membuat tabel users
    print('Creating users table...');
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      password TEXT
    )
    ''');
  }

  // Metode untuk memeriksa apakah tabel ada
  Future<bool> isTableExists(String tableName) async {
    final db = await instance.database;
    var result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return result.isNotEmpty;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('tasks', row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db
        .update('tasks', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Task>> fetchTasks() async {
    final db = await instance.database;
    final res = await db.query('tasks');
    return res.isNotEmpty ? res.map((task) => Task.fromMap(task)).toList() : [];
  }

  Future<Map<String, dynamic>?> login(String username, String password) async {
    final db = await instance.database;

    // Cek apakah tabel users ada
    bool tableExists = await isTableExists('users');
    if (!tableExists) {
      print('Table users does not exist, creating it now...');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          password TEXT
        )
      ''');
    }

    final res = await db.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);
    return res.isNotEmpty ? res.first : null;
  }

  Future<Map<String, dynamic>?> register(
      String username, String password) async {
    final db = await instance.database;

    // Cek apakah tabel users ada
    bool tableExists = await isTableExists('users');
    if (!tableExists) {
      print('Table users does not exist, creating it now...');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          password TEXT
        )
      ''');
    }

    int id =
        await db.insert('users', {'username': username, 'password': password});
    return id != 0 ? {'username': username, 'password': password} : null;
  }
}
