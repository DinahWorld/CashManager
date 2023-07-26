class Order {
  final int id;
  final int price;

  Order({required this.id, required this.price});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      price: json['price'] as int,
    );
  }
}
