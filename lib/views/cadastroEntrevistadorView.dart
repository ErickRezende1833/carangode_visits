import 'package:flutter/material.dart';
import '../services/usuario_service.dart';

class CadastroEntrevistadorView extends StatefulWidget {
  const CadastroEntrevistadorView({super.key});

  @override
  State<CadastroEntrevistadorView> createState() =>
      _CadastroEntrevistadorViewState();
}

class _CadastroEntrevistadorViewState
    extends State<CadastroEntrevistadorView> {

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  final usuarioService = UsuarioService();

  bool loading = false;

  Future<void> salvar() async {

    if (nomeController.text.isEmpty ||
        emailController.text.isEmpty ||
        senhaController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos'),
        ),
      );

      return;
    }

    try {
      setState(() {
        loading = true;
      });

      await usuarioService.cadastrarEntrevistador(
        nome: nomeController.text.trim(),
        email: emailController.text.trim(),
        senha: senhaController.text.trim(),
      );

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Entrevistador cadastrado com sucesso!',
          ),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: $e'),
        ),
      );
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Entrevistador'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: loading ? null : salvar,

              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}