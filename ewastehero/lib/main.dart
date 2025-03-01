import 'package:ewastehero/screens/bin_page.dart';
import 'package:ewastehero/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart'; // Import your HomeScreen

void main() {
  runApp(EWasteHeroApp()); // Run the app
}

class EWasteHeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Waste Hero', // Title of the app
      theme: ThemeData(
        primarySwatch: Colors.green, // Main color of the app
        fontFamily: 'Roboto', // Default font family for the app
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInScreen(),
    );
  }
}
