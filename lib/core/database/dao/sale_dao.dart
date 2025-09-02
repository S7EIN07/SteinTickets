import 'package:stein_tickets/core/models/sale_model.dart';
import '../app_database.dart';

class SaleDao {
  static const String tableName = "Sales";

  Future<int> insert(Sale Sale) async {
    final db = await AppDatabase.instance.database;
    return await db.insert(tableName, Sale.toMap());
  }

  Future<List<Sale>> getAll() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tableName);
    return result.map((e) => Sale.fromMap(e)).toList();
  }
}
