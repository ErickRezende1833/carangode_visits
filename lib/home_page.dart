import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'database/familia_dao.dart';
import 'models/familiaModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FamiliaDao dao = FamiliaDao();
  final TextEditingController nomeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 🔹 SALVAR NO SQLITE (LOCAL)
  Future<void> salvarSQLite() async {
    if (_formKey.currentState!.validate()) {
      final id = await dao.inserir(
  Familia(
    nomeTitular: nomeController.text,
    cpf: '',
    rg: '',
    dataNascimento: DateTime.now(),
    sexo: '',
    estadoCivil: '',
    nomeMae: '',
    nis: '',
    comunidade: '',
    pontoReferencia: '',
    telefone: '',
    tipoAcesso: '',
    membros: [],
    rendaMensalBruta: 0,
    atividadePrincipal: '',
    dapOuCaf: '',
    tipoConstrucao: '',
    situacaoCobertura: '',
    abastecimentoAgua: '',
    esgotamentoSanitario: '',
    possuiEnergiaEletrica: false,
  ),
);
      print("Salvou no SQLite com ID: $id");
    }
  }

  // 🔹 LISTAR SQLITE
  Future<void> listarSQLite() async {
    final lista = await dao.listarFamilias();

    for (var v in lista) {
      print("${v.id} - ${v.nomeTitular}");
    }
  }

  // 🔹 SALVAR NO FIREBASE (CLOUD)
  Future<void> salvarFirebase() async {
    if (nomeController.text.isEmpty) return;

    await FirebaseFirestore.instance.collection('visitas').add({
      'nome': nomeController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    print("Salvou no Firebase: ${nomeController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite + Firebase Teste"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite um nome";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: salvarSQLite,
                child: const Text("Salvar no SQLite"),
              ),

              ElevatedButton(
                onPressed: salvarFirebase,
                child: const Text("Salvar no Firebase"),
              ),

              ElevatedButton(
                onPressed: listarSQLite,
                child: const Text("Listar SQLite"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}