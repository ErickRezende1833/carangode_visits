import 'package:flutter/material.dart';
import 'database/visita_dao.dart';
import 'models/visita.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final VisitaDao dao = VisitaDao();
  final TextEditingController nomeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Lista local para exibir os dados do SQLite na tela
  List<Visita> _visitasLocal = [];

  @override
  void initState() {
    super.initState();
    _atualizarLista(); // Carrega os dados assim que a tela abre
  }

  // 🔹 FUNÇÃO PARA RECARREGAR A LISTA DO SQLITE
  Future<void> _atualizarLista() async {
    final lista = await dao.listarVisitas();
    setState(() {
      _visitasLocal = lista;
    });
  }

  // 🔹 SALVAR NO SQLITE (LOCAL)
  Future<void> salvarSQLite() async {
    if (_formKey.currentState!.validate()) {
      final novaVisita = Visita(nome: nomeController.text);
      await dao.inserirVisita(novaVisita);
      
      nomeController.clear(); // Limpa o campo após salvar
      _atualizarLista(); // Atualiza a lista na tela
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Salvo no SQLite com sucesso!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teste SQLite Local"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _atualizarLista,
          )
        ],
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
                  labelText: "Nome da Visita",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty) ? "Digite um nome" : null,
              ),
              const SizedBox(height: 10),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: salvarSQLite,
                    icon: const Icon(Icons.save),
                    label: const Text("Salvar Local"),
                  ),
                ],
              ),
              
              const Divider(height: 30),
              const Text("Dados no SQLite:", style: TextStyle(fontWeight: FontWeight.bold)),
              
              // 🔹 LISTA EM TEMPO REAL
              Expanded(
                child: _visitasLocal.isEmpty
                    ? const Center(child: Text("Nenhum dado local encontrado."))
                    : ListView.builder(
                        itemCount: _visitasLocal.length,
                        itemBuilder: (context, index) {
                          final visita = _visitasLocal[index];
                          return ListTile(
                            leading: Icon(
                              visita.synced ? Icons.cloud_done : Icons.cloud_off,
                              color: visita.synced ? Colors.green : Colors.orange,
                            ),
                            title: Text(visita.nome),
                            subtitle: Text("ID: ${visita.id} | Sincronizado: ${visita.synced ? 'Sim' : 'Não'}"),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}