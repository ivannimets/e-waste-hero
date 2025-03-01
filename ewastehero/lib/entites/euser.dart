class EUser {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final int experience;

  EUser({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.experience,
  });

  // Factory method to create a User object from a Map
  factory EUser.fromMap(Map<String, dynamic> map) {
    return EUser(
      username: map['username'] ?? 'N/A',
      firstName: map['first_name'] ?? 'N/A',
      lastName: map['last_name'] ?? 'N/A',
      email: map['email'] ?? 'N/A',
      experience: map['experience'] ?? 0,
    );
  }

  // Method to convert the User object to a Map (if needed)
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'experience': experience,
    };
  }
}
