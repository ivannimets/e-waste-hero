import 'package:ewastehero/screens/base_screen.dart';
import 'package:flutter/material.dart';// Import the ProfileScreen

void main() {
  runApp(EWasteHeroApp());
}

class EWasteHeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Waste Hero',
      theme: ThemeData(
        primarySwatch: Colors.green, // App's main color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(), // Set HomeScreen as the first screen
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to E-Waste Hero!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to ProfileScreen or any other screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to HomeScreen
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
