import 'package:ewastehero/screens/base_screen.dart';
import 'package:ewastehero/screens/recycler_detail_screen.dart';
import 'package:flutter/material.dart'; // Import the new screen

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
    {
      "name": "RecycleIt Waterloo",
      "address": "102 Recycle Dr, Waterloo, ON",
      "phone": "234-567-8901",
      "distance": "5.2 km",
      "acceptedWaste": "Phones, Cables, Laptops",
      "isVerified": "true"
    },
    {
      "name": "GreenCycle Kitchener",
      "address": "400 Greenway Blvd, Kitchener, ON",
      "phone": "876-543-2109",
      "distance": "8.9 km",
      "acceptedWaste": "Computers, TVs, Printers",
      "isVerified": "false"
    },
    {
      "name": "EcoWaste Solutions",
      "address": "789 Recycle Rd, Toronto, ON",
      "phone": "555-987-6543",
      "distance": "30.1 km",
      "acceptedWaste": "Batteries, Phones, TVs, Wires",
      "isVerified": "true"
    },
    {
      "name": "TechRecycle Hub",
      "address": "101 Tech Blvd, Cambridge, ON",
      "phone": "321-654-9870",
      "distance": "12.7 km",
      "acceptedWaste": "Monitors, Computers, Phones",
      "isVerified": "false"
    },
    {
      "name": "Toronto E-Waste Recycling",
      "address": "55 Queen St E, Toronto, ON",
      "phone": "567-890-1234",
      "distance": "35.4 km",
      "acceptedWaste": "Computers, Phones, Cables",
      "isVerified": "true"
    },
    {
      "name": "Kitchener Green Waste",
      "address": "210 King St W, Kitchener, ON",
      "phone": "412-876-3095",
      "distance": "6.1 km",
      "acceptedWaste": "Batteries, Phones, Wires",
      "isVerified": "false"
    },
    {
      "name": "The Green Bin",
      "address": "333 Green Rd, Toronto, ON",
      "phone": "343-909-8765",
      "distance": "40.3 km",
      "acceptedWaste": "Computers, Batteries, Laptops",
      "isVerified": "true"
    },
    {
      "name": "Green E-Waste Solutions",
      "address": "11 Tech Ave, Toronto, ON",
      "phone": "555-888-2233",
      "distance": "25.4 km",
      "acceptedWaste": "Computers, Phones, Monitors",
      "isVerified": "true"
    },
    {
      "name": "Sustainable Tech Recycling",
      "address": "72 Ontario St, Guelph, ON",
      "phone": "433-222-7789",
      "distance": "15.8 km",
      "acceptedWaste": "Phones, Batteries, Laptops",
      "isVerified": "true"
    },
    {
      "name": "E-Waste Recovery Centre",
      "address": "100 E-Waste Rd, Toronto, ON",
      "phone": "555-332-2345",
      "distance": "50.0 km",
      "acceptedWaste": "Laptops, Phones, Monitors",
      "isVerified": "false"
    },
    {
      "name": "WasteNot Recycling",
      "address": "123 Recycle Dr, Burlington, ON",
      "phone": "567-432-1098",
      "distance": "42.3 km",
      "acceptedWaste": "Computers, Phones, Batteries",
      "isVerified": "true"
    },
    {
      "name": "Tech Waste Solutions",
      "address": "111 Tech Blvd, Mississauga, ON",
      "phone": "678-109-2345",
      "distance": "60.2 km",
      "acceptedWaste": "Phones, Wires, Batteries",
      "isVerified": "false"
    },
    {
      "name": "FutureCycle Recyclers",
      "address": "800 Recycling St, Vaughan, ON",
      "phone": "234-567-8912",
      "distance": "55.6 km",
      "acceptedWaste": "Monitors, Batteries, Phones",
      "isVerified": "true"
    },
    {
      "name": "EcoTech Recycling",
      "address": "430 Recycle Blvd, Toronto, ON",
      "phone": "643-222-7789",
      "distance": "18.3 km",
      "acceptedWaste": "Computers, Phones, Cables, Batteries",
      "isVerified": "true"
    },
    {
      "name": "Smart Waste Solutions",
      "address": "20 Park Dr, Brampton, ON",
      "phone": "433-555-0912",
      "distance": "67.8 km",
      "acceptedWaste": "Computers, Phones, Wires",
      "isVerified": "false"
    },
    {
      "name": "EcoRecycle Toronto",
      "address": "70 E-Waste Rd, Toronto, ON",
      "phone": "444-555-6789",
      "distance": "37.5 km",
      "acceptedWaste": "Phones, Batteries, Laptops",
      "isVerified": "true"
    },
    {
      "name": "WasteWorks Recyclers",
      "address": "200 Bay St, Toronto, ON",
      "phone": "300-999-7777",
      "distance": "24.2 km",
      "acceptedWaste": "Computers, Phones, Monitors",
      "isVerified": "true"
    },
    {
      "name": "Tech Renewables",
      "address": "300 Tech Rd, Guelph, ON",
      "phone": "430-234-1234",
      "distance": "20.7 km",
      "acceptedWaste": "Laptops, Phones, Batteries",
      "isVerified": "true"
    },
    {
      "name": "EnviroTech Recyclers",
      "address": "128 Queen St N, Waterloo, ON",
      "phone": "987-123-4567",
      "distance": "3.4 km",
      "acceptedWaste": "Computers, Phones, Batteries",
      "isVerified": "true"
    },
    {
      "name": "GreenWaste Disposal",
      "address": "150 Recycle Dr, Toronto, ON",
      "phone": "612-233-8901",
      "distance": "22.6 km",
      "acceptedWaste": "Computers, Phones, Laptops",
      "isVerified": "true"
    },
    {
      "name": "E-Waste Recyclers Toronto",
      "address": "44 Recycle Blvd, Toronto, ON",
      "phone": "541-230-3495",
      "distance": "19.4 km",
      "acceptedWaste": "Batteries, Phones, Wires",
      "isVerified": "false"
    },
    {
      "name": "GreenPlanet Recycling",
      "address": "17 Main St, Oakville, ON",
      "phone": "421-987-6543",
      "distance": "47.8 km",
      "acceptedWaste": "Monitors, Phones, Batteries",
      "isVerified": "true"
    },
    {
      "name": "Green World Recyclers",
      "address": "82 York Blvd, Richmond Hill, ON",
      "phone": "555-910-2002",
      "distance": "54.1 km",
      "acceptedWaste": "Computers, Phones, Laptops",
      "isVerified": "false"
    },
    {
      "name": "Tech Waste Disposal",
      "address": "1129 Steeles Ave, Toronto, ON",
      "phone": "344-120-4357",
      "distance": "25.8 km",
      "acceptedWaste": "Phones, Laptops, Batteries",
      "isVerified": "true"
    },
    {
      "name": "SmartCycle Recycling",
      "address": "2348 Danforth Ave, Toronto, ON",
      "phone": "555-989-1234",
      "distance": "23.5 km",
      "acceptedWaste": "Computers, Phones, Cables",
      "isVerified": "true"
    },
    {
      "name": "EcoRenew Recycling",
      "address": "209 Queens St, Mississauga, ON",
      "phone": "899-321-4567",
      "distance": "58.3 km",
      "acceptedWaste": "Monitors, Phones, Wires",
      "isVerified": "true"
    },
  ];

  void searchRecyclingCenters() {
    // For now, just show the sample data
    String location = _locationController.text.toLowerCase();

    setState(() {
      recyclingCenters = sampleCenters.where((center) {
        // Filter based on location (e.g., address or distance)
        bool matchesLocation = center["address"]!.toLowerCase().contains(location);
        return matchesLocation;
      }).toList();
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
                labelText: "Enter your city",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Search Button
            ElevatedButton(
              onPressed: searchRecyclingCenters,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Search'),
            ),
            SizedBox(height: 20),

            // Show the list of recycling centers
            Expanded(
              child: ListView.builder(
                itemCount: recyclingCenters.length,
                itemBuilder: (context, index) {
                  final center = recyclingCenters[index];
                  return ListTile(
                    title: Text(center["name"]!),
                    subtitle: Text(center["address"]!),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecyclingCenterDetailScreen(
                              centerData: center,
                              userId: widget.userId,
                            ),
                          ),
                        );
                      },
                    ),
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
