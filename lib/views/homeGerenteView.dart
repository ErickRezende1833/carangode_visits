import 'package:flutter/material.dart';
import 'widgets.dart';

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

            CustomElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/cadastro-entrevistador',
                );
              },
              icon: Icons.person_add,
              label: 'Cadastrar Entrevistador',
            ),

            const SizedBox(height: 20),

            CustomElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/consulta-visitas',
                );
              },
              icon: Icons.search,
              label: 'Consultar Visitas',
            ),

            const SizedBox(height: 20),

            CustomElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/campo',
                );
              },
              icon: Icons.logout,
              label: 'Sair',
            ),

          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1),
    );
  }
}