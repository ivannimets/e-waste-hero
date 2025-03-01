class Bin {
  int binId;
  String name;

  Bin({required this.binId, required this.name});

  factory Bin.fromMap(Map<String, dynamic> data) {
    return Bin(
      binId: data['bin_id'],
      name: data['name']
    );
  }
}