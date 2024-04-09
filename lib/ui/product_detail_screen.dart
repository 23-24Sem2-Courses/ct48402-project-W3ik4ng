
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen(this.product,{super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){

          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(product.image, fit: BoxFit.cover),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                height: 20,

              ),
              ],
            ),
            Row(

              children: <Widget>[
                SizedBox(

                  height: 100,
                  child: Image.network(product.image),
                ),
                SizedBox(
                  height: 100,
                  child: Image.network(product.image),
                ),
                SizedBox(
                  height: 100,
                  child: Image.network(product.image),
                ),
                SizedBox(
                  height: 100,
                  child: Image.network(product.image),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                style: const TextStyle(fontSize: 35, color: Colors.red),
                '${product.price} VND',
                textAlign: TextAlign.left,
                softWrap: true,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                style: const TextStyle(fontSize: 25),
                product.desc,
                textAlign: TextAlign.left,
                softWrap: true,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),


                ],
              )
            ),

          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        destinations: [
          Container(
            color: Colors.green,
            height: 80,
              child: IconButton(
                icon: Icon(Icons.message, size: 50),
                color: Colors.white,
                onPressed: (){},
                ),
              ),
          Container(
            color: Colors.green,
            height: 80,
            child: IconButton(
              icon: Icon(Icons.add_shopping_cart, size: 50),
              color: Colors.white,
              onPressed: (){},
            ),
          ),
          Container(
            color: Colors.redAccent,
            height: 80,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {},
              child: const Text('Mua ngay',),
            ),
          ),
        ],
      ),

    );
  }
}
