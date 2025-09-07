import 'package:flutter/material.dart';
import 'package:stein_tickets/core/database/dao/event_dao.dart';
import 'package:stein_tickets/core/database/dao/history_sale_dao.dart';
import 'package:stein_tickets/core/database/dao/sale_dao.dart';
import 'package:stein_tickets/core/models/event_model.dart';
import 'package:stein_tickets/core/models/history_sales_model.dart';
import 'package:stein_tickets/core/models/sale_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final historyDao = HistoryDao();
  final saleDao = SaleDao();
  final eventDao = EventDao();
  bool _isLoading = true;
  List<Map<String, dynamic>> _historyItems = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<History> historyRecords = await historyDao.getAll();
      List<Map<String, dynamic>> items = [];

      for (var history in historyRecords) {
        final Sale? sale = await saleDao.getById(history.saleId);
        if (sale != null) {
          final Event? event = await eventDao.getById(sale.eventId);
          items.add({'history': history, 'sale': sale, 'event': event});
        }
      }

      setState(() {
        _historyItems = items;
        _isLoading = false;
      });
    } catch (e) {
      // Tratar erros, por exemplo, mostrando uma mensagem na tela
      debugPrint('Erro ao carregar o histórico: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico de Vendas"),
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _historyItems.isEmpty
          ? const Center(child: Text("Nenhuma venda registrada ainda."))
          : ListView.builder(
              itemCount: _historyItems.length,
              itemBuilder: (context, index) {
                final item = _historyItems[index];
                final event = item['event'] as Event?;
                final sale = item['sale'] as Sale;

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: const Icon(Icons.receipt, color: Colors.white),
                    ),
                    title: Text(
                      event?.nome ?? 'Evento Desconhecido',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        "Cliente: ${sale.nomeCliente}\n"
                        "Ingressos: ${sale.qtdIngressos}\n"
                        "Data: ${sale.dataNascimento}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
