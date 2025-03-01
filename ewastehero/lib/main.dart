import 'dart:convert';

import 'package:ewastehero/screens/bin_page.dart';
import 'package:ewastehero/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart'; // Import your HomeScreen

class Config {
  static String databaseKey = '';

  static Future<void> loadConfig() async {
    // Load the config.json file from assets
    String configString = await rootBundle.loadString('assets/config.json');

    // Decode the JSON string into a map
    Map<String, dynamic> configMap = jsonDecode(configString);

    // Set the database key from the config file
    databaseKey = configMap['databaseKey'];
  }
}

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
