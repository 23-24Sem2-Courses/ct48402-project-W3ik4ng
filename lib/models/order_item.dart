import 'cart_item.dart';

class OrderItem {
  final String? id;
  final String title;
  final double amount;
  final String image;
  final List<CartItem> products;
  final DateTime dateTime;

  int get productCount {
    return products.length;
  }

  OrderItem({
    this.id,
    required this.title,
    required this.amount,
    required this.image,
    required this.products,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderItem copyWith({
    String? id,
    String? title,
    double? amount,
    String? image,
    List<CartItem>? products,
    DateTime? dateTime,
  }) {
    return OrderItem(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      image: image ?? this.image,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
