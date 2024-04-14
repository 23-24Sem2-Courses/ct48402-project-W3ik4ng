import 'cart_item.dart';

class OrderItem {
  final String? id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  int get productCount {
    return products.length;
  }

  OrderItem({
    this.id,
    required this.amount,
    required this.products,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderItem copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    DateTime? dateTime,
  }) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'products': products,
      'dateTime': dateTime,
    };
  }

  static OrderItem fromJson(Map<String, dynamic> json) {
    List<CartItem> cartItems = [];
    int index = 0;

    (json['products'] as List<dynamic>).forEach((product) {
      String productId = 'product_${index++}';

      cartItems.add(CartItem.fromOrderJson(productId, product));
    });

    DateTime dateTime = DateTime.parse(json['dateTime']);

    return OrderItem(
      id: json['id'],
      amount: json['amount'],
      products: cartItems,
      dateTime: dateTime,
    );
  }
}
