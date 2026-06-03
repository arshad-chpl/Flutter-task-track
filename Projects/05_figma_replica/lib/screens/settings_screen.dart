import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),

      body: RadioGroup<ThemeMode>(
        groupValue: provider.themeMode,
        onChanged: (ThemeMode? value) {
          if (value != null) {
            provider.setTheme(value);
          }
        },
        child: Column(
          children: const [
            RadioListTile<ThemeMode>(
              title: Text('System Theme'),
              value: ThemeMode.system,
            ),

            RadioListTile<ThemeMode>(
              title: Text('Light Theme'),
              value: ThemeMode.light,
            ),

            RadioListTile<ThemeMode>(
              title: Text('Dark Theme'),
              value: ThemeMode.dark,
            ),
          ],
        ),
      ),
    );
  }
}
