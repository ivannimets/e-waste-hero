import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load configuration before app starts
  await Config.loadConfig();

  // Initialize Supabase
  await Supabase.initialize(
    url: Config.supabaseUrl,
    anonKey: Config.supabaseKey,
  );

  runApp(EWasteHeroApp());
}

class Config {
  static String supabaseUrl = '';
  static String supabaseKey = '';

  static Future<void> loadConfig() async {
    // Load the config.json file from assets
    String configString = await rootBundle.loadString('assets/config.json');

    // Decode the JSON string into a map
    Map<String, dynamic> configMap = jsonDecode(configString);

    // Set the Supabase credentials from the config file
    supabaseUrl = configMap['supabaseUrl'];
    supabaseKey = configMap['supabaseKey'];
  }
}

class EWasteHeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Waste Hero',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInScreen(),
    );
  }
}
