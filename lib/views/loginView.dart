import 'package:flutter/material.dart';
import 'package:carangode_visits_app/views/widgets.dart';

import '../viewModels/loginViewModel.dart';

class LoginView extends StatefulWidget {
  final bool apenasGerente;
  final Future<void> Function()? onSucesso;

  const LoginView({
    super.key,
    this.apenasGerente = false,
    this.onSucesso,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final LoginViewModel _viewModel = LoginViewModel();

  bool _obscureSenha = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _fazerLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final tipo = await _viewModel.autenticar(
        email: _emailController.text.trim(),
        senha: _senhaController.text.trim(),
      );

      if (widget.apenasGerente && tipo != 'gerente') {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Acesso permitido apenas para gerente.',
            ),
          ),
        );

        return;
      }

      if (widget.onSucesso != null) {
        await widget.onSucesso!();
      } else {
        if (!mounted) return;
        Navigator.pop(context);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro no login: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.apenasGerente
              ? 'Acesso Gerente'
              : 'Autenticação',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              const Icon(
                Icons.directions_car_rounded,
                size: 80,
                color: Colors.blueGrey,
              ),

              const SizedBox(height: 8),

              const Text(
                'Carangode Visits',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                widget.apenasGerente
                    ? 'Login do gerente'
                    : 'Autentique para continuar',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              CustomIconTextField(
                controller: _emailController,
                labelText: 'E-mail',
                hintText: 'seu@email.com',
                prefixIcon: Icons.email_outlined,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Obrigatório';
                  }

                  if (!v.contains('@')) {
                    return 'E-mail inválido';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _senhaController,
                obscureText: _obscureSenha,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureSenha
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureSenha = !_obscureSenha;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Obrigatório';
                  }

                  if (v.length < 6) {
                    return 'Mínimo 6 caracteres';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              _isLoading
                  ? const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                        ),
                      ),
                    )
                  : CustomElevatedButton(
                      onPressed: _fazerLogin,
                      icon: Icons.login_rounded,
                      label: 'Entrar',
                    ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}