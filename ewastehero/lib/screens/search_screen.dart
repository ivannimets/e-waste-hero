import 'package:ewastehero/screens/base_screen.dart';
import 'package:ewastehero/screens/recycler_detail_screen.dart';
import 'package:flutter/material.dart';// Import the new screen

class SearchScreen extends StatefulWidget {
  final int userId;
  SearchScreen({required this.userId});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _locationController = TextEditingController();
  List<Map<String, String>> recyclingCenters = [];

  // Sample data for demonstration
  final List<Map<String, String>> sampleCenters = [
    {
      "name": "Green Tech Recycling",
      "address": "123 Green St, Waterloo, ON",
      "phone": "123-456-7890",
      "distance": "2.5 km",
      "acceptedWaste": "Computers, Batteries, Phones, Cables",
      "isVerified": "true"
    },
    {
      "name": "E-Waste Solutions",
      "address": "456 Tech Ave, Kitchener, ON",
      "phone": "987-654-3210",
      "distance": "10.3 km",
      "acceptedWaste": "Phones, Batteries, Wires",
      "isVerified": "false"
    },
    {
      "name": "EcoRecycle Depot",
      "address": "789 Sustainability Rd, Toronto, ON",
      "phone": "555-123-9876",
      "distance": "50.1 km",
      "acceptedWaste": "Computers, Batteries, Phones, Monitors",
      "isVerified": "true"
    },
  ];

  void searchRecyclingCenters() {
    // For now, just show the sample data
    setState(() {
      recyclingCenters = List.from(sampleCenters);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      userId: widget.userId,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Find Recycling Centers',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),

            // Location Input Field
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: "Enter your location",
                prefixIcon: Icon(Icons.location_on, color: Colors.green),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 20),

            // Search Button
            ElevatedButton(
              onPressed: searchRecyclingCenters,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Display Search Results
            Expanded(
              child: recyclingCenters.isEmpty
                  ? Center(
                child: Text(
                  "Enter a location and search for recycling centers.",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              )
                  : ListView.separated(
                itemCount: recyclingCenters.length,
                separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.recycling, color: Colors.green),
                    title: Text(
                      recyclingCenters[index]["name"]!,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      recyclingCenters[index]["address"]!,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    trailing: Icon(Icons.arrow_forward, color: Colors.green),
                    onTap: () {
                      // Navigate to the details page with data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecyclingCenterDetailScreen(
                            centerData: recyclingCenters[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
