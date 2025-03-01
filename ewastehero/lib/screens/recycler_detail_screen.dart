import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../entites/bin.dart';
import 'home_screen.dart';

class BinId {
  int binId;

  BinId({required this.binId});

  factory BinId.fromMap(Map<String, dynamic> data) {
    return BinId(binId: data['bin_id']);
  }
}

class RecyclingCenterDetailScreen extends StatefulWidget {
  final int userId;
  final Map<String, String> centerData;

  RecyclingCenterDetailScreen({required this.centerData, required this.userId});

  @override
  _RecyclingCenterDetailScreenState createState() =>
      _RecyclingCenterDetailScreenState();
}

class _RecyclingCenterDetailScreenState extends State<RecyclingCenterDetailScreen> {
  List<Bin> bins = [];
  bool isLoading = true; // For showing a loading spinner

  @override
  void initState() {
    super.initState();
    getUserBins();
  }

  void getUserBins() async {
    final results = await supabase
        .from('joining_bin_user')
        .select('bin_id')
        .eq('user_id', widget.userId);

    List<BinId> binIds = results.map((binId) => BinId.fromMap(binId)).toList();

    List<Bin> fetchedBins = [];

    for (var binId in binIds) {
      final _bin = await supabase
          .from('bin')
          .select('bin_id, name')
          .eq('bin_id', binId.binId)
          .single();
      fetchedBins.add(Bin.fromMap(_bin));
    }

    setState(() {
      bins = fetchedBins;
      isLoading = false;
    });
  }

  String randomPrice() {
    return (50 + Random().nextInt(30) + Random().nextDouble()).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.centerData["name"]!),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title (Recycling Center Name)
            Text(
              widget.centerData["name"]!,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Address
            Text(
              widget.centerData["address"]!,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Phone Number
            Text(
              'Phone: ${widget.centerData["phone"]}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Distance
            Text(
              'Distance: ${widget.centerData["distance"]}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Accepted E-Waste Types
            Text(
              'Accepted E-Waste Types: ${widget.centerData["acceptedWaste"]}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Verified Status
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.centerData["isVerified"] == "true" ? Icons.check_circle : Icons.cancel,
                  color: widget.centerData["isVerified"] == "true" ? Colors.green : Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  widget.centerData["isVerified"] == "true" ? "Verified E-Waste Sidekick" : "Not Verified",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Estimated Bin Prices Header
            Text(
              'Estimated Bin Prices:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 10),

            // Bin List (Loading Indicator, ListView, or Empty Message)
            isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.green))
                : bins.isEmpty
                ? Center(child: Text("No bins available", style: TextStyle(fontSize: 18, color: Colors.grey)))
                : Expanded(
              child: ListView.builder(
                itemCount: bins.length,
                itemBuilder: (context, index) {
                  Bin bin = bins[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.delete_outline, color: Colors.green, size: 30), // Bin icon
                      title: Text(
                        bin.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "\$${randomPrice()}",
                        style: TextStyle(fontSize: 16, color: Colors.green[700], fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),

            // Contact Button
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Contacting ${widget.centerData["name"]}...')),
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
