import 'package:carangode_visits_app/services/sync_service.dart';
import 'package:flutter/material.dart';

import '../viewModels/homeCampoViewModel.dart';
import 'loginView.dart';
import 'widgets.dart';

class HomeCampoView extends StatefulWidget {
  const HomeCampoView({Key? key}) : super(key: key);

  @override
  State<HomeCampoView> createState() => _HomeCampoViewState();
}

class _HomeCampoViewState extends State<HomeCampoView> {
  final HomeCampoViewModel _viewModel = HomeCampoViewModel();

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

  Future<void> _sincronizar() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginView(
          fecharAoSucesso: true,
          onSucesso: () async {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Sincronizando dados com o servidor...',
                ),
              ),
            );

            await SyncService().syncFamilias();

            await _viewModel.carregarFamilias();

            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Sincronização concluída!',
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGO'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cadastros:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: _viewModel.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _viewModel.familias.isEmpty
                          ? const Center(
                              child: Text(
                                "Nenhuma família encontrada.",
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () => _viewModel.carregarFamilias(),
                              child: ListView.builder(
                                itemCount: _viewModel.familias.length,
                                itemBuilder: (context, index) {
                                  final familia = _viewModel.familias[index];

                                  return Card(
                                    child: ListTile(
                                      leading: Icon(
                                        familia.synced
                                            ? Icons.cloud_done
                                            : Icons.cloud_off,
                                        color: familia.synced
                                            ? Colors.green
                                            : Colors.orange,
                                      ),
                                      title: Text(
                                        familia.nomeTitular,
                                      ),
                                      subtitle: Text(
                                        "Comunidade: ${familia.comunidade}",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedButton(
                      onPressed: _sincronizar,
                      icon: Icons.sync,
                      label: "Sincronizar",
                    ),
                    CustomElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(
                          context,
                          '/formulario',
                        );

                        _viewModel.carregarFamilias();
                      },
                      icon: Icons.add,
                      label: "Adicionar",
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar: const CustomBottomNavigationBar(
        currentIndex: 0,
      ),
    );
  }
}