import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stein_tickets/core/models/event_model.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onDelete;

  const EventCard({super.key, required this.event, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Excluir Evento?"),
              content: Text(
                "Tem certeza de que deseja excluir o evento '${event.nome}'?",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    onDelete();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Excluir",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: event.imagePath != null
                ? Image.file(
                    File(event.imagePath!),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.image, size: 40, color: Colors.grey),
          ),
          title: Text(
            event.nome,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            "Ingressos disponíveis: ${event.qtdIngressos}",
            style: const TextStyle(color: Colors.black54),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
