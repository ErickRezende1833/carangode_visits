import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultaVisitasView extends StatefulWidget {
  const ConsultaVisitasView({super.key});

  @override
  State<ConsultaVisitasView> createState() =>
      _ConsultaVisitasViewState();
}

class _ConsultaVisitasViewState
    extends State<ConsultaVisitasView> {

  List<QueryDocumentSnapshot> familias = [];
  List<QueryDocumentSnapshot> familiasFiltradas = [];

  bool loading = true;

  final buscaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarFamilias();
  }

  Future<void> carregarFamilias() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('familias')
          .get();

      setState(() {
        familias = snapshot.docs;
        familiasFiltradas = snapshot.docs;
        loading = false;
      });

    } catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar visitas: $e'),
        ),
      );
    }
  }

  void filtrar(String texto) {
    setState(() {
      familiasFiltradas = familias.where((doc) {
        final nome =
            doc['nomeTitular']
                .toString()
                .toLowerCase();

        return nome.contains(
          texto.toLowerCase(),
        );
      }).toList();
    });
  }

  @override
  void dispose() {
    buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Visitas'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: buscaController,
              onChanged: filtrar,

              decoration: const InputDecoration(
                labelText: 'Buscar por nome',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : familiasFiltradas.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhuma visita encontrada',
                          ),
                        )
                      : ListView.builder(
                          itemCount: familiasFiltradas.length,

                          itemBuilder: (context, index) {
                            final familia =
                                familiasFiltradas[index];

                            return Card(
                              child: ListTile(
                                leading: const Icon(
                                  Icons.home,
                                ),

                                title: Text(
                                  familia['nomeTitular'] ?? '',
                                ),

                                subtitle: Text(
                                  familia['comunidade'] ?? '',
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}