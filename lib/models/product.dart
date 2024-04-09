import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String title;
  final String desc;
  final String image;
  final double price;

  Product(
    {
      this.id,
      required this.title,
      required this.desc,
      required this.image,
      required this.price,
    }
  );

  Product copyWith({
      String? id,
      String? title,
      String? desc,
      String? image,
      double? price,
      }) {
    return Product(
    id: id ?? this.id,
    title: title ?? this.title,
    desc: desc ?? this.desc,
    image: image ?? this.image,
    price: price ?? this.price
    );
    }
}