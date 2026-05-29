import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/user_provider.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/assignments_screen.dart';
import 'screens/timetable_screen.dart';
import 'screens/result_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Student Management App',

      theme: ThemeData(
        primaryColor: const Color(0xFF284B18),

        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF284B18),
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8FCA75),
        ),
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),

        '/login': (context) => const LoginScreen(),

        '/signup': (context) => const SignUpPage(),

        '/home': (context) => const HomeScreen(),

        '/profile': (context) => const ProfileScreen(),

        '/attendance': (context) => const AttendanceScreen(),

        '/assignments': (context) => const AssignmentScreen(),

        '/timetable': (context) => const TimetableScreen(),

        '/result': (context) => const ResultScreen(),
      },
    );
  }
}