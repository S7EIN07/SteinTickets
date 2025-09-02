import 'package:stein_tickets/core/models/event_model.dart';
import '../app_database.dart';

class EventDao {
  static const String tableName = "Events";

  Future<int> insert(Event event) async {
    final db = await AppDatabase.instance.database;
    return await db.insert(tableName, event.toMap());
  }

  Future<List<Event>> getAll() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tableName);
    return result.map((e) => Event.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    final db = await AppDatabase.instance.database;
    return await db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<int> update(Event event) async {
    final db = await AppDatabase.instance.database;
    return await db.update(
      tableName,
      event.toMap(),
      where: "id = ?",
      whereArgs: [event.id],
    );
  }

  Future<int> decreaseTicketCount(int id, int qtdIngressos) async {
    final db = await AppDatabase.instance.database;
    return await db.rawUpdate(
      'UPDATE $tableName SET qtdIngressos = qtdIngressos - ? WHERE id = ?',
      [qtdIngressos, id],
    );
  }
}
