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
        
      },
      items: [
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