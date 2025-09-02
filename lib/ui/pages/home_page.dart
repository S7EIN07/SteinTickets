import 'package:flutter/material.dart';
import 'package:stein_tickets/core/database/dao/event_dao.dart';
import 'package:stein_tickets/core/models/event_model.dart';
import 'package:stein_tickets/ui/pages/add_event_page.dart';
import 'package:stein_tickets/ui/pages/buy_page.dart';
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
    _loadEventos();
  }

  Future<void> _loadEventos() async {
    final data = await eventoDao.getAll();
    setState(() => eventos = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Eventos disponíveis")),
      body: ListView.builder(
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BuyPage(event: evento)),
              );
            },
            child: EventCard(event: evento),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEventPage()),
          );
          if (result == true) _loadEventos(); // atualiza lista
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
