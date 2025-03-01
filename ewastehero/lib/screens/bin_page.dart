import 'package:ewastehero/entites/bin.dart';
import 'package:ewastehero/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../entites/item.dart';


class BinScreen extends StatefulWidget {
  final int userId;
  final int binId;

  BinScreen({required this.userId, required this.binId});

  @override
  BinScreenState createState() {
    return BinScreenState();
  }
}

class BinScreenState extends State<BinScreen> {
  final supabase = Supabase.instance.client;
  List<Item> binItems = [];
  late Bin bin;

  Future<void> fetchBinItems() async {
    bin = Bin.fromMap(await supabase
        .from('bin')
        .select('bin_id, name')
        .eq('bin_id', widget.binId)
        .single());

    final response = await supabase
        .from('bin_line_items')
        .select('bin_line_item_id, bin_id, item_name, quantity')
        .eq('bin_id', bin.binId);

    if (response.isNotEmpty) {
      setState(() {
        binItems = response.map((item) => Item.fromMap(item)).toList();
      });
    }
  }

  Future<void> changeItemQuantity(Item lineItem, int increment) async {
    await supabase.from('bin_line_items').update({'quantity': lineItem.quantity + increment}).eq('bin_line_item_id', lineItem.itemId);
    fetchBinItems();
  }

  Future<void> deleteLineItem(Item lineItem) async {
    await supabase.from('bin_line_items').delete().eq('bin_line_item_id', lineItem.itemId);
    fetchBinItems();
  }

  @override
  void initState() {
    super.initState();
    fetchBinItems(); // Ensure items are fetched when screen loads
  }

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
                  itemQuantity =
                      int.tryParse(value) ?? 1; // Default to 1 if invalid input
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
              onPressed: () async {
                if (itemName.isNotEmpty) {
                  try {
                    await supabase.from('bin_line_items').insert({
                      'bin_id': bin.binId,
                      'item_name': itemName,
                      'quantity': itemQuantity
                    });

                    print("item inserted successfully");
                    fetchBinItems();
                  } catch (e) {
                    print("Error inserting item: $e");
                  }

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
                                binItems[index].itemName,
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  if (binItems[index].quantity > 1)
                                    IconButton(
                                      icon: Icon(Icons.remove,
                                          color: Colors.green),
                                      onPressed: () {
                                        changeItemQuantity(binItems[index], -1);
                                      },
                                    ),
                                  Text(
                                    "${binItems[index].quantity}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, color: Colors.green),
                                    onPressed: () {
                                      changeItemQuantity(binItems[index], 1);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              deleteLineItem(binItems[index]);
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
