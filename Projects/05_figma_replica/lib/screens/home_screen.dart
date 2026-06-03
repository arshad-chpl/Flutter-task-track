import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_assets.dart';
import '../provider/user_provider.dart';

import '../widgets/custom_bottom_navbar.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/profile_card.dart';
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
      context.read<UserProvider>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    final userProvider = context.watch<UserProvider>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              userProvider.logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: Responsive.paddingAll(12),

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [Color(0xFF1A1A1A), Color(0xFF2A2A2A)]
                : const [Color(0xFFE8F0FF), Color(0xFFD6E4FF)],
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
                  username: userProvider.user == null
                      ? ''
                      : '${userProvider.user!.firstName} ${userProvider.user!.lastName}',
                  email: userProvider.user?.email ?? '',
                ),

                const SizedBox(height: 30),

                Text(
                  'Student Services',
                  style: theme.textTheme.titleLarge?.copyWith(
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
                      color: theme.colorScheme.primary,
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),

                    DashboardCard(
                      title: 'Attendance',
                      imagePath: AppAssets.attendance,
                      color: theme.colorScheme.primary,
                      onTap: () {
                        Navigator.pushNamed(context, '/attendance');
                      },
                    ),

                    DashboardCard(
                      title: 'Assignments',
                      imagePath: AppAssets.assignment,
                      color: theme.colorScheme.primary,
                      onTap: () {
                        Navigator.pushNamed(context, '/assignments');
                      },
                    ),

                    DashboardCard(
                      title: 'Timetable',
                      imagePath: AppAssets.timetable,
                      color: theme.colorScheme.primary,
                      onTap: () {
                        Navigator.pushNamed(context, '/timetable');
                      },
                    ),

                    DashboardCard(
                      title: 'Notes',
                      imagePath: AppAssets.notes,
                      color: theme.colorScheme.primary,
                      onTap: () {
                        Navigator.pushNamed(context, '/notes_list');
                      },
                    ),

                    DashboardCard(
                      title: 'Results',
                      imagePath: AppAssets.result,
                      color: theme.colorScheme.primary,
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