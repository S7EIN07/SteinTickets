import 'package:stein_tickets/core/database/dao/event_dao.dart';
import 'package:stein_tickets/core/database/dao/history_sale_dao.dart';
import 'package:stein_tickets/core/models/history_sales_model.dart';
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

  Future<Sale?> getById(int saleId) async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [saleId],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return Sale.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<void> postSale(
    Sale sale,
    EventDao eventDao,
    HistoryDao historyDao,
  ) async {
    final saleId = await insert(sale);

    await eventDao.decreaseTicketCount(sale.eventId, sale.qtdIngressos);

    final history = History(
      saleId: saleId,
      timestamp: DateTime.now().toIso8601String(),
    );

    await historyDao.insert(history);
  }
}
