import 'package:ewastehero/screens/base_screen.dart';
import 'package:flutter/material.dart';

import '../entites/item.dart';

List<Item> binItems = [
  Item(name: "batteries", quantity: 5),
  Item(name: "phone"),
  Item(name: "wire", quantity: 2)
];

class BinScreen extends StatefulWidget {

  final int userId;
  BinScreen({required this.userId});

  @override
  BinScreenState createState() {
    return BinScreenState();
  }
}

class BinScreenState extends State<BinScreen> {
  // Function to show dialog to add new item
  void _showAddItemDialog() {
    String itemName = '';
    int itemQuantity = 1;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Item Name'),
                onChanged: (value) {
                  itemName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  itemQuantity = int.tryParse(value) ?? 1; // Default to 1 if invalid input
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without adding
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (itemName.isNotEmpty) {
                  setState(() {
                    binItems.add(Item(name: itemName, quantity: itemQuantity));
                  });
                  Navigator.pop(context); // Close the dialog
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      userId: widget.userId,
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
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${binItems[index].name}",
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          children: [
                            if (binItems[index].quantity > 1)
                              IconButton(
                                icon: Icon(Icons.remove,
                                    color: Colors.green),
                                onPressed: () {
                                  setState(() {
                                    binItems[index].ChanegeQuantity(-1);
                                  });
                                },
                              ),
                            Text(
                              "${binItems[index].quantity}",
                              style: TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.green),
                              onPressed: () {
                                setState(() {
                                  binItems[index].ChanegeQuantity(1);
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          binItems.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            // Button to Add Items
            ElevatedButton(
              onPressed: _showAddItemDialog, // Show the dialog to add an item
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
