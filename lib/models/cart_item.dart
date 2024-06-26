class CartItem {
  final String id;
  final String title;
  final String imageUrl;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  CartItem copyWith({
    String? id,
    String? title,
    String? imageUrl,
    int? quantity,
    double? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  static Map<String, CartItem> fromJson(Map<String, dynamic> json) {
    return {
      json['productId']: CartItem(
        id: json['id'],
        title: json['title'],
        quantity: json['quantity'],
        price: json['price'],
        imageUrl: json['imageUrl'],
      )
    };
  }

  static CartItem fromOrderJson(String cartItemId, Map<String, dynamic> json) {
    return CartItem(
      id: cartItemId,
      title: json['title'],
      quantity: json['quantity'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }
}
