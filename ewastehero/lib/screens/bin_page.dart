import 'package:ewastehero/screens/base_screen.dart';
import 'package:flutter/material.dart';

class BinScreen extends StatelessWidget {
  final List<String> binItems; // List of bin items

  BinScreen({this.binItems = const ["Battery", "Testing"]}); // Default to an empty bin

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Text(
              'Your Bin',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),

            // Display bin contents or empty message
            Expanded(
              child: binItems.isEmpty
                  ? Center(
                child: Text(
                  'You have nothing in your bin',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              )
                  : ListView.separated(
                itemCount: binItems.length,
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.grey[300]),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.recycling, color: Colors.green),
                    title: Text(
                      binItems[index],
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // TODO: Implement delete functionality
                      },
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            // Button to Add Items (For Future Implementation)
            ElevatedButton(
              onPressed: () {
                // TODO: Add functionality to add items to the bin
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Add to Bin',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
