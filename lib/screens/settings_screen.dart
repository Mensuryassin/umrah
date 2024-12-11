import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) toggleDarkMode;

  const SettingsScreen({super.key, required this.isDarkMode, required this.toggleDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: isDarkMode ? Colors.black : Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Appearance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: isDarkMode,
              onChanged: (value) {
                toggleDarkMode(value);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
