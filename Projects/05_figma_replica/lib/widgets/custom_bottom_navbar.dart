import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      currentIndex: currentIndex,

      selectedItemColor: const Color(0xFF4A90E2),
      unselectedItemColor: isDark ? Colors.white : Colors.black,

      type: BottomNavigationBarType.fixed,

      onTap: (index) {
        onTap(index);

        if (index == 4) {
          Navigator.pushNamed(context, '/settings');
        }
      },

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Academics'),

        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),

        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),

        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
