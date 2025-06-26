class Product {
  final String? id;
  final String name;
  final double price;
  final int quantity;

  Product({this.id, required this.name, required this.price, required this.quantity});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'quantity': quantity,
      };
}