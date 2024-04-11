class Product {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product(
      {this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl});

  Product copyWith({
    String? id,
    String? title,
    String? desciption,
    double? price,
    String? imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: desciption ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }
}
