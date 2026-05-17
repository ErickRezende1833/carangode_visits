import 'package:flutter/material.dart';

class HomeGerenteView extends StatelessWidget {
  const HomeGerenteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel da Gerente'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const SizedBox(height: 20),

            const Icon(
              Icons.admin_panel_settings,
              size: 80,
              color: Colors.blueGrey,
            ),

            const SizedBox(height: 16),

            const Text(
              'Área Administrativa',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Gerencie entrevistadores e consultas',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/cadastro-entrevistador',
                );
              },

              icon: const Icon(Icons.person_add),

              label: const Text(
                'Cadastrar Entrevistador',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/consulta-visitas',
                );
              },

              icon: const Icon(Icons.search),

              label: const Text(
                'Consultar Visitas',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/login',
                );
              },

              icon: const Icon(Icons.logout),

              label: const Text(
                'Sair',
              ),
            ),
          ],
        ),
      ),
    );
  }
}