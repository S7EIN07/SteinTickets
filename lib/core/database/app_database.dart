import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("ingressos.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Events(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        qtdMaxima INTEGER NOT NULL,
        qtdIngressos INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE Sales(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomeCliente TEXT NOT NULL,
        dataNascimento TEXT NOT NULL,
        qtdIngressos INTEGER NOT NULL,
        eventId INTEGER,
        FOREIGN KEY(eventId) REFERENCES Events(id)
      )
    ''');
  }
}
