class Product {
  int id;
  String name;
  String category;
  int quantity;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
  });

  // Convert Product to Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'price': price,
    };
  }

  // Create Product from SQLite Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      quantity: map['quantity'],
      price: (map['price'] as num).toDouble(),
    );
  }
}