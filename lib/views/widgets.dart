import 'package:flutter/material.dart';

// Custom Bottom Navigation Bar Widget

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      unselectedItemColor: Theme.of(
        context,
      ).colorScheme.onPrimary.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      onTap: (index) {
        if (index == currentIndex) return;
        
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/campo');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/');
        }
      },
      items: [
        BottomNavigationBarItem(label: 'Campo', icon: Icon(Icons.flag)),
        BottomNavigationBarItem(label: 'Base', icon: Icon(Icons.home)),
      ],
    );
  }
}

//botão com icon e label

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
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(fixedSize: const Size.fromHeight(48)),
    );
  }
}

//campo de texto

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
      decoration: InputDecoration(labelText: labelText, hintText: hintText),
    );
  }
}

//campo de texto com ícone

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
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}
