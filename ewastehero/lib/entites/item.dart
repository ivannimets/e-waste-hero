class Item {
  String name = "";
  int quantity;

  Item({required this.name, this.quantity = 1});

  void ChangeQuantity(int increment) {
    quantity += increment;
  }
}