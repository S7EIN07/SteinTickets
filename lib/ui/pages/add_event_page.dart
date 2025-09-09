import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController idadeMinimaController = TextEditingController();
  final eventoDao = EventDao();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Evento"),
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_selectedImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _selectedImage!,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: nomeController,
                    decoration: const InputDecoration(
                      labelText: "Nome do Evento",
                    ),
                    validator: (value) =>
                        Validators.validateNotEmpty(value, "nome"),
                  ),
                  SizedBox(height: 20),
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
                  TextFormField(
                    controller: idadeMinimaController,
                    decoration: const InputDecoration(
                      labelText: "Idade Mínima",
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validators.validateInt(value, "idade mínima"),
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image, color: Colors.white),
                    label: const Text(
                      "Selecionar Imagem",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final evento = Event(
                          nome: nomeController.text,
                          qtdMaxima: int.parse(qtdMaxController.text),
                          qtdIngressos: int.parse(qtdMaxController.text),
                          imagePath: _selectedImage?.path,
                          minimumAge: int.parse(idadeMinimaController.text),
                        );
                        await eventoDao.insert(evento);
                        Navigator.pop(
                          context,
                          true,
                        ); // Retorna sinal de atualização
                      }
                    },
                    child: const Text(
                      "Salvar Evento",
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
