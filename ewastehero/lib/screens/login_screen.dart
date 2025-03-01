import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final supabase = Supabase.instance.client; // Access Supabase

  Future<void> _signIn() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }

    // Hash password using SHA-256
    final hashedPassword = sha256.convert(utf8.encode(password)).toString();

    try {
      // Query user from the database
      final response = await supabase
          .from('users')
          .select('user_id, username, hashed_password')
          .eq('username', username)
          .maybeSingle();

      if (response == null) {
        _showError('User not found');
        return;
      }

      final dbPassword = response['hashed_password'];

      // Compare hashed passwords
      if (dbPassword == hashedPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        _showError('Incorrect password');
      }
    } catch (e) {
      _showError('Error signing in: $e');
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
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 40),

            // Username Field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person, color: Colors.green),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 20),

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

            // Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Sign In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 15),

            // Forgot Password & Sign Up Links
            TextButton(
              onPressed: () {},
              child: Text('Forgot Password?', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}
