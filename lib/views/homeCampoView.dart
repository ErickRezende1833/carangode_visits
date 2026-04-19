import 'package:flutter/material.dart';
import 'widgets.dart';
import '../viewModels/homeCampoViewModel.dart'; // Importe sua ViewModel
import '../models/visita.dart';

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
    _viewModel.carregarVisitas(); // Busca os dados ao iniciar a tela
    
    // Opcional: Escuta mudanças na ViewModel para atualizar a UI
    _viewModel.addListener(() {
      if (mounted) setState(() {});
    });
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
                const Text("Cadastros:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                
                // LISTA DE VISITAS
                Expanded(
                  child: _viewModel.isLoading 
                    ? const Center(child: CircularProgressIndicator())
                    : _viewModel.visitas.isEmpty
                      ? const Center(child: Text("Nenhuma visita encontrada."))
                      : RefreshIndicator(
                          onRefresh: () => _viewModel.carregarVisitas(),
                          child: ListView.builder(
                            itemCount: _viewModel.visitas.length,
                            itemBuilder: (context, index) {
                              final visita = _viewModel.visitas[index];
                              return Card(
                                child: ListTile(
                                  leading: Icon(
                                    visita.synced ? Icons.cloud_done : Icons.cloud_off,
                                    color: visita.synced ? Colors.green : Colors.orange,
                                  ),
                                  title: Text(visita.nome),
                                  subtitle: Text(visita.synced ? "Sincronizado" : "Pendente"),
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
                      onPressed: () => _viewModel.carregarVisitas(), // Botão de atualizar manual
                      icon: Icons.sync,
                      label: "Sincronizar",
                    ),
                    CustomElevatedButton(
                      onPressed: () async {
                        // Ao voltar do formulário, recarrega a lista
                        await Navigator.pushNamed(context, '/formulario');
                        _viewModel.carregarVisitas();
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
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}