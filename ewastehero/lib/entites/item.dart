class Item {
  String name = "";
  int quantity;

  Item({required this.name, this.quantity = 1});

  void ChanegeQuantity(int increment) {
    quantity += increment;
  }
}