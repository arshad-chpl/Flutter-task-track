import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'provider/user_provider.dart';
import 'provider/theme_provider.dart';
import 'provider/notes_provider.dart';
import 'provider/auth_provider.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/assignments_screen.dart';
import 'screens/timetable_screen.dart';
import 'screens/result_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/notes_screen.dart';
import 'screens/note_editor_screen.dart';

import 'constants/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'Student Management App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,

          localizationsDelegates: const [
    FlutterQuillLocalizations.delegate,

    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],

  supportedLocales: const [
    Locale('en'),
  ],


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
            '/settings': (context) => const SettingsScreen(),
            '/notes_list': (context) => const NotesScreen(),
            '/notes_editor': (context) => const NoteEditorScreen(),
          },
        );
      },
    );
  }
}

