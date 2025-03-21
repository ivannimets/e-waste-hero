import 'package:ewastehero/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart';

final supabase = Supabase.instance.client;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  /// Hash the password using SHA-256
  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  /// Create a bin for the user
  Future<int?> createBin(int userId) async {
    try {
      final response = await supabase
          .from('bin')
          .insert({'user_id': userId})
          .single();

      return response['bin_id'];
    } catch (e) {
      print('Error creating bin: $e');
      return null;
    }
  }

  /// Sign up the user
  Future<void> _signUp() async {
    setState(() => _isLoading = true);

    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    final String firstName = _firstNameController.text.trim();
    final String lastName = _lastNameController.text.trim();
    final String email = _emailController.text.trim();
    final String hashedPassword = hashPassword(password);

    // Check for empty fields
    if (username.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
      _showError('Please fill in all fields');
      setState(() => _isLoading = false);
      return;
    }

    try {
      // Insert user into Supabase
      final response = await supabase
          .from('users')
          .insert({
        'username': username,
        'hashed_password': hashedPassword,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'experience': 0
      }).select('user_id').single();

      final int userId = response['user_id'];

      // Create a bin for the user
      final int? binId = await createBin(userId);

      // Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(userId: userId,)),
      );

    } catch (e) {
      _showError('Error signing up: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'E-Waste Hero',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),

            // Username Field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person, color: Colors.green),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 15),

            // First Name Field
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                prefixIcon: Icon(Icons.account_circle, color: Colors.green),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 15),

            // Last Name Field
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                prefixIcon: Icon(Icons.account_circle_outlined, color: Colors.green),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 15),

            // Email Field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email, color: Colors.green),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 15),

            // Password Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock, color: Colors.green),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 20),

            // Sign Up Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 15),

            // Sign In Redirect Button
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()), // Navigate to Sign In screen
                );
              },
              child: Text("Already have an account? Sign In", style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}
