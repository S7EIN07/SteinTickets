import 'package:flutter/material.dart';
import 'package:stein_tickets/core/database/dao/event_dao.dart';
import 'package:stein_tickets/core/database/dao/sale_dao.dart';
import 'package:stein_tickets/core/models/event_model.dart';
import 'package:stein_tickets/core/models/sale_model.dart';
import '../../../utils/validators.dart';

class BuyPage extends StatefulWidget {
  final Event event;

  const BuyPage({super.key, required this.event});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final dataNascController = TextEditingController();
  int qtdIngressosComprados = 1;

  final vendaDao = SaleDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comprar - ${widget.event.nome}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: "Nome"),
                validator: (value) =>
                    Validators.validateNotEmpty(value, "nome"),
              ),
              TextFormField(
                controller: dataNascController,
                decoration: const InputDecoration(
                  labelText: "Data de Nascimento",
                ),
                validator: (value) => Validators.validateDate(value),
              ),
              DropdownButtonFormField<int>(
                value: qtdIngressosComprados,
                items: List.generate(
                  widget.event.qtdMaxima,
                  (i) =>
                      DropdownMenuItem(value: i + 1, child: Text("${i + 1}")),
                ),
                onChanged: (val) =>
                    setState(() => qtdIngressosComprados = val!),
                decoration: const InputDecoration(
                  labelText: "Quantidade de Ingressos",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final venda = Sale(
                      nomeCliente: nomeController.text,
                      dataNascimento: dataNascController.text,
                      qtdIngressos: qtdIngressosComprados,
                      eventId: widget.event.id!,
                    );
                    await vendaDao.insert(venda);
                    await EventDao().decreaseTicketCount(
                      widget.event.id!,
                      qtdIngressosComprados,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Venda realizada!")),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("Finalizar Compra"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
