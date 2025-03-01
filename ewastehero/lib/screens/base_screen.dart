import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget body;

  BaseScreen({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Waste Hero'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: body),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              iconSize: 40.0,
              onPressed: () {
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 40.0,
              onPressed: () {
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 40.0,
              onPressed: () {
              },
            ),
            IconButton(
              icon: Icon(Icons.local_offer),
              iconSize: 40.0,
              onPressed: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}