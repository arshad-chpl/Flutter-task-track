import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_assets.dart';
import '../provider/user_provider.dart';

import '../widgets/dashboard_card.dart';
import '../widgets/profile_card.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<UserProvider>().loadUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 101, 100),

        title: const Text(
          'Student Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        actions: [
          IconButton(
            onPressed: () {
              userProvider.logout(context);
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        padding: Responsive.paddingAll(12),

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [Color(0xFFE8F0FF), Color(0xFFD6E4FF)],
          ),
        ),

        child: RefreshIndicator(
          onRefresh: userProvider.loadUserData,

          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 20),

                ProfileCard(
                  username: userProvider.username,
                  email: userProvider.email,
                ),

                const SizedBox(height: 30),

                Text(
                  'Student Services',
                  style: TextStyle(
                    fontSize: Responsive.px(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                GridView.count(
                  crossAxisCount: Responsive.isTablet() ? 4 : 2,

                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,

                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  children: [
                    DashboardCard(
                      title: 'Profile',
                      imagePath: AppAssets.profile,
                      color: Colors.green,
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),

                    DashboardCard(
                      title: 'Attendance',
                      imagePath: AppAssets.attendance,
                      color: Colors.green,
                      onTap: () {
                        Navigator.pushNamed(context, '/attendance');
                      },
                    ),

                    DashboardCard(
                      title: 'Assignments',
                      imagePath: AppAssets.assignment,
                      color: Colors.green,
                      onTap: () {
                        Navigator.pushNamed(context, '/assignments');
                      },
                    ),

                    DashboardCard(
                      title: 'Timetable',
                      imagePath: AppAssets.timetable,
                      color: Colors.green,
                      onTap: () {
                        Navigator.pushNamed(context, '/timetable');
                      },
                    ),

                    DashboardCard(
                      title: 'Result',
                      imagePath: AppAssets.result,
                      color: Colors.green,
                      onTap: () {
                        Navigator.pushNamed(context, '/result');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
