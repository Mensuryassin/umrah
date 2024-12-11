import 'dart:async';

class AuthService {
  // Simulate a user database (for demonstration purposes)
  final List<Map<String, String>> _userDatabase = [];

  /// Login method
  Future<bool> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Check if the email and password match an existing user
    final user = _userDatabase.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );

    return user.isNotEmpty;
  }

  /// Register method
  Future<bool> register(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Check if the email is already registered
    if (_userDatabase.any((user) => user['email'] == email)) {
      return false; // Email already exists
    }

    // Add new user to the "database"
    _userDatabase.add({'email': email, 'password': password});
    return true;
  }

  /// Logout method
  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // Clear session or token logic can go here
  }
}
