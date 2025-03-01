import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget body;

  // Constructor accepts the body widget to customize content
  BaseScreen({required this.body});

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
        backgroundColor: Colors.green, // The background color of the AppBarCenters the title in the AppBar
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
                // Navigate to home screen
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 40,
              onPressed: () {
                // Navigate to search screen
              },
            ),
            IconButton(
              icon: Icon(Icons.recycling_outlined),
              iconSize: 40,
              onPressed: () {
                // Navigate to rewards screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
