import 'package:flutter/material.dart';
import 'package:stein_tickets/core/database/dao/event_dao.dart';
import 'package:stein_tickets/core/models/event_model.dart';
import 'package:stein_tickets/ui/pages/add_event_page.dart';
import 'package:stein_tickets/ui/pages/buy_page.dart';
import 'package:stein_tickets/ui/pages/history_page.dart';
import 'package:stein_tickets/ui/widgets/event_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final eventoDao = EventDao();
  List<Event> eventos = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final data = await eventoDao.getAll();
    setState(() => eventos = data);
  }

  Future<void> _deleteEvent(Event event) async {
    await eventoDao.delete(event.id!);
    setState(() {
      eventos.remove(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eventos disponíveis"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HistoryPage()),
              );
            },
            icon: Icon(Icons.history, size: 32, color: Colors.white),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: eventos.isEmpty
          ? const Center(
              child: Text(
                "Nenhum evento cadastrado ainda.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: eventos.length,
              itemBuilder: (context, index) {
                final evento = eventos[index];
                return GestureDetector(
                  onTap: () async {
                    final shouldRefresh = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BuyPage(event: evento)),
                    );
                    if (shouldRefresh == true) _loadEvents();
                  },
                  child: EventCard(
                    onDelete: () {
                      _deleteEvent(evento);
                    },
                    event: evento,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEventPage()),
          );
          if (result == true) _loadEvents();
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Novo Evento", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
