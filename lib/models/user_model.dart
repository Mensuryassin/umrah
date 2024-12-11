class UserModel {
  final String id;
  final String email;
  final String name;
  final String profilePicture;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.profilePicture = '',
  });

  // Convert a UserModel instance to a Map (useful for JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profilePicture': profilePicture,
    };
  }

  // Create a UserModel instance from a Map (useful for JSON deserialization)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
    );
  }
}
