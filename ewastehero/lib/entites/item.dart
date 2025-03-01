class Item {
  final int itemId;
  final int binId;
  final String itemName;
  int quantity;

  Item({required this.itemId, required this.binId, required this.itemName, this.quantity = 1});

  // Convert Supabase row to Item object
  factory Item.fromMap(Map<String, dynamic> data) {
    return Item(
      itemId: data['bin_line_item_id'],
      binId: data['bin_id'],
      itemName: data['item_name'],
      quantity: data['quantity'] ?? 1,
    );
  }
}