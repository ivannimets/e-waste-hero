import 'package:ewastehero/screens/notification_screen.dart';
import 'package:ewastehero/screens/search_screen.dart';
import 'package:flutter/material.dart';

import 'bin_page.dart';
import 'home_screen.dart';

class BaseScreen extends StatelessWidget {
  final Widget body;
  final int userId;

  // Constructor accepts the body widget to customize content
  BaseScreen({required this.userId, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'e-waste hero', // The app title
          style: TextStyle(
            fontSize: 45,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold, // Makes the text bold
            color: Colors.white, // Sets text color to white
          ),
        ),
        backgroundColor: Colors.green, // The background color of the AppBar
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: body), // Accepts the dynamic body for each screen
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              iconSize: 40,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(userId: userId)),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 40,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen(userId: userId)),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.recycling_outlined),
              iconSize: 40,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BinScreen(userId: userId)),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              iconSize: 40,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsScreen(userId: userId)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
