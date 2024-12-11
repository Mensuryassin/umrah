import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_placeholder.png'), // Placeholder
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement image picker logic
              },
              child: const Text('Upload Profile Picture'),
            ),
          ],
        ),
      ),
    );
  }
}
