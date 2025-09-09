import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:stein_tickets/core/database/dao/event_dao.dart';
import 'package:stein_tickets/core/database/dao/history_sale_dao.dart';
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

  final saleDao = SaleDao();
  final eventDao = EventDao();
  final historyDao = HistoryDao();

  final maskFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Comprar - ${widget.event.nome}"),
        iconTheme: IconThemeData(color: Colors.white, size: 32),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nomeController,
                    decoration: const InputDecoration(
                      labelText: "Nome",
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) =>
                        Validators.validateNotEmpty(value, "nome"),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    inputFormatters: [maskFormatter],
                    controller: dataNascController,
                    decoration: const InputDecoration(
                      labelText: "Data de Nascimento",
                      prefixIcon: Icon(Icons.calendar_month),
                    ),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      final minAge = widget.event.minimumAge;
                      return Validators.validateAge(value, minAge: minAge);
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    isExpanded: true,
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                    value: qtdIngressosComprados,
                    items: List.generate(
                      widget.event.qtdIngressos,
                      (i) => DropdownMenuItem(
                        value: i + 1,
                        child: Text("${i + 1}"),
                      ),
                    ),
                    onChanged: (val) =>
                        setState(() => qtdIngressosComprados = val!),
                    decoration: const InputDecoration(
                      labelText: "Quantidade de Ingressos",
                      prefixIcon: Icon(Icons.confirmation_number),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final venda = Sale(
                          nomeCliente: nomeController.text,
                          dataNascimento: dataNascController.text,
                          qtdIngressos: qtdIngressosComprados,
                          eventId: widget.event.id!,
                        );

                        await saleDao.postSale(venda, eventDao, historyDao);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Venda realizada!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                        Navigator.pop(context, true);
                      }
                    },
                    child: const Text(
                      "Finalizar Compra",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
