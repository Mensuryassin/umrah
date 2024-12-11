import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Import DashboardScreen

class LoginScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleDarkMode;

  const LoginScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleDarkMode,
  });

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = ''; // To display error message

  // Hardcoded credentials for validation
  final String correctUsername = "user";
  final String correctPassword = "password";

  // Function to handle login
  void _handleLogin() {
    // Get the username and password from the controllers
    String username = _usernameController.text.trim(); // Remove any leading/trailing spaces
    String password = _passwordController.text.trim(); // Remove any leading/trailing spaces

    // Debugging: Print entered credentials
    print('Entered username: $username');
    print('Entered password: $password');

    // Check if the entered username and password are correct
    if (username == correctUsername && password == correctPassword) {
      // Debugging: Print successful login
      print('Login successful');

      // Navigate to Dashboard if login is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(
            isDarkMode: widget.isDarkMode,
            toggleDarkMode: widget.toggleDarkMode,
          ),
        ),
      );
    } else {
      // Debugging: Print invalid login
      print('Invalid username or password');
      
      // Show error message if login is invalid
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username TextField
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  errorText: _errorMessage.isEmpty ? null : _errorMessage,
                ),
              ),
              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: true, // Hide password input
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  errorText: _errorMessage.isEmpty ? null : _errorMessage,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleLogin, // Trigger the login action
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
