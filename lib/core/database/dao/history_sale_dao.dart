import 'package:stein_tickets/core/models/history_sales_model.dart';

import '../app_database.dart';

class HistoryDao {
  static const String tableName = "history";

  Future<int> insert(History history) async {
    final db = await AppDatabase.instance.database;
    return await db.insert(tableName, history.toMap());
  }

  Future<List<History>> getAll() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tableName);
    return result.map((e) => History.fromMap(e)).toList();
  }
}
