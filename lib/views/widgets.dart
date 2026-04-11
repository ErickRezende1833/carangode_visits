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