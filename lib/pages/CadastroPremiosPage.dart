import 'package:ballet_championship/campeonato.dart';
import 'package:flutter/material.dart';

class CadastroPremiosPage extends StatefulWidget {
  final Campeonato campeonato;

  CadastroPremiosPage({required this.campeonato});

  @override
  _CadastroPremiosPageState createState() => _CadastroPremiosPageState();
}

class _CadastroPremiosPageState extends State<CadastroPremiosPage> {
  final _formKey = GlobalKey<FormState>();
  final _primeiroLugarController = TextEditingController();
  final _segundoLugarController = TextEditingController();
  final _terceiroLugarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Prêmios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _primeiroLugarController,
                decoration: InputDecoration(labelText: 'Prêmio para 1º Lugar'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o prêmio para o 1º lugar';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _segundoLugarController,
                decoration: InputDecoration(labelText: 'Prêmio para 2º Lugar'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o prêmio para o 2º lugar';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _terceiroLugarController,
                decoration: InputDecoration(labelText: 'Prêmio para 3º Lugar'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o prêmio para o 3º lugar';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.campeonato.definirPremios(
                      _primeiroLugarController.text,
                      _segundoLugarController.text,
                      _terceiroLugarController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Prêmios cadastrados com sucesso!')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Salvar Prêmios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
