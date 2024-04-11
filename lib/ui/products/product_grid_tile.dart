import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/ui/products/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product),
          ));
        },
        child: GridTile(
          footer: Container(
            height: 100,
            color: Colors.white,
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text(product.title),
                Text(
                  product.price.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
