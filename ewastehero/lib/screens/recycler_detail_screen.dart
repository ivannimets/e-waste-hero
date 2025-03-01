import 'package:flutter/material.dart';

class RecyclingCenterDetailScreen extends StatelessWidget {
  final Map<String, String> centerData;

  RecyclingCenterDetailScreen({required this.centerData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(centerData["name"]!),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            Text(
              centerData["name"]!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Address
            Text(
              centerData["address"]!,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),

            // Phone Number
            Text(
              'Phone: ${centerData["phone"]}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),

            // Distance
            Text(
              'Distance: ${centerData["distance"]}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),

            // Accepted E-Waste Types
            Text(
              'Accepted E-Waste Types: ${centerData["acceptedWaste"]}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),

            // Verified Status
            Row(
              children: [
                Icon(
                  centerData["isVerified"] == "true" ? Icons.check_circle : Icons.cancel,
                  color: centerData["isVerified"] == "true" ? Colors.green : Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  centerData["isVerified"] == "true" ? "Verified E-Waste Sidekick" : "Not Verified",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Action Button (e.g., Call, Directions, etc.)
            ElevatedButton(
              onPressed: () {
                // You can add functionality here to call, get directions, etc.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Contacting ${centerData["name"]}...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Contact or Get Directions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
