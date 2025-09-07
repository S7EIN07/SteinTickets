import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stein_tickets/core/models/event_model.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
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
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
      ),
    );
  }
}
