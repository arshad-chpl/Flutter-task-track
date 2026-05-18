import 'package:flutter/material.dart';

import '../screens/profile_screen.dart';
import '../screens/counter_screen.dart';
import '../screens/contact_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF5C6BC0),
        centerTitle: true,
        title: const Text(
          "Flutter Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Container(
        color: const Color(0xFFF6F8FF),
      
      child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Welcome !!!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C2C54),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Choose an app to explore",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [

                    _dashboardCard(
                      context,
                      icon: Icons.person,
                      title: "Profile",
                      color: const Color.fromARGB(255, 75, 181, 230),
                      page: const Profile(),
                    ),

                    _dashboardCard(
                      context,
                      icon: Icons.add,
                      title: "Counter",
                      color: const Color(0xFF81C784),
                      page: const CounterScreen(),
                    ),

                    

                    _dashboardCard(
                      context,
                      icon: Icons.contact_phone,
                      title: "Contacts",
                      color: const Color(0xFFFFB74D),
                      page: const ContactListScreen(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.9),
              color.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white.withOpacity(0.25),
              child: Icon(icon, size: 30, color: Colors.white),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 6),

            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}