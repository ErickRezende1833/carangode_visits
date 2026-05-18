import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'loginView.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  Future<void> _acessarBase(BuildContext context) async {
    final authService = AuthService();

    final ehGerente = await authService.usuarioAtualEhGerente();

    if (ehGerente) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(
          context,
          '/gerente',
        );
      }
      return;
    }

    if (!context.mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginView(
          apenasGerente: true,
          onSucesso: () async {
            Navigator.pushReplacementNamed(
              context,
              '/gerente',
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      unselectedItemColor:
          Theme.of(context).colorScheme.onPrimary.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 14,

      onTap: (index) async {
        if (index == currentIndex) return;

        if (index == 0) {
          Navigator.pushReplacementNamed(
            context,
            '/campo',
          );
        }

        if (index == 1) {
          await _acessarBase(context);
        }
      },

      items: const [
        BottomNavigationBarItem(
          label: 'Campo',
          icon: Icon(Icons.flag),
        ),
        BottomNavigationBarItem(
          label: 'Base',
          icon: Icon(Icons.home),
        ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 18,
      ),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(48),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.validator,
  });

  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}

class CustomIconTextField extends StatelessWidget {
  const CustomIconTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.validator,
    this.prefixIcon,
  });

  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: const OutlineInputBorder(),

        errorStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),

        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
      ),
    );
  }
}