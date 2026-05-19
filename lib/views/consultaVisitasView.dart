import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../viewModels/consultaVisitasViewModel.dart';
import 'detalheVisitaView.dart';

class ConsultaVisitasView extends StatefulWidget {
  const ConsultaVisitasView({super.key});

  @override
  State<ConsultaVisitasView> createState() =>
      _ConsultaVisitasViewState();
}

class _ConsultaVisitasViewState
    extends State<ConsultaVisitasView> {

  final ConsultaVisitasViewModel _viewModel =
      ConsultaVisitasViewModel();

  final buscaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _viewModel.carregarFamilias();

    _viewModel.addListener(() {
      if (mounted) {
        setState(() {});
      }
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
              onChanged: _viewModel.filtrar,

              decoration: const InputDecoration(
                labelText: 'Buscar por nome',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: _viewModel.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _viewModel.familiasFiltradas.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhuma visita encontrada',
                          ),
                        )
                      : ListView.builder(
                          itemCount:
                              _viewModel.familiasFiltradas.length,

                          itemBuilder: (context, index) {
                            final familia =
                                _viewModel.familiasFiltradas[index];

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

                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                ),

                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          DetalheVisitaView(
                                        familia: familia,
                                      ),
                                    ),
                                  );
                                },
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