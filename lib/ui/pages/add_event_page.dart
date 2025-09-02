import 'package:flutter/material.dart';
import 'package:stein_tickets/core/database/dao/event_dao.dart';
import 'package:stein_tickets/core/models/event_model.dart';
import '../../../utils/validators.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController qtdMaxController = TextEditingController();
  final eventoDao = EventDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar Evento")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: "Nome do Evento"),
                validator: (value) =>
                    Validators.validateNotEmpty(value, "nome"),
              ),
              TextFormField(
                controller: qtdMaxController,
                decoration: const InputDecoration(
                  labelText: "Quantidade Máxima de Ingressos",
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    Validators.validateInt(value, "quantidade"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final evento = Event(
                      nome: nomeController.text,
                      qtdMaxima: int.parse(qtdMaxController.text),
                      qtdIngressos: int.parse(qtdMaxController.text),
                    );
                    await eventoDao.insert(evento);
                    Navigator.pop(
                      context,
                      true,
                    ); // Retorna sinal de atualização
                  }
                },
                child: const Text("Salvar Evento"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
