import 'package:flutter/material.dart';
import 'package:stein_tickets/core/models/event_model.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(event.nome),
        subtitle: Text("Ingressos disponíveis: ${event.qtdIngressos}"),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
