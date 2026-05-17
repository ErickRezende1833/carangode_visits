import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/usuarioModel.dart';
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

  final usuarioService = UsuarioService();

  bool loading = false;

  Future<void> salvar() async {

    if (nomeController.text.isEmpty ||
        emailController.text.isEmpty) {

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

      final usuario = UsuarioModel(
        id: const Uuid().v4(),
        nome: nomeController.text.trim(),
        email: emailController.text.trim(),
        tipo: 'entrevistador',
      );

      await usuarioService.cadastrarUsuario(usuario);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Entrevistador cadastrado com sucesso!'),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao cadastrar: $e'),
        ),
      );

    } finally {

      setState(() {
        loading = false;
      });

    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
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
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : salvar,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}