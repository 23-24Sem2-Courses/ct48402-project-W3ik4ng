import 'package:ct484_project/ui/cart/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail-screen';

  const ProductDetailScreen(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        actions: <Widget>[
          HomeButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            // ),
            // ShoppingCartButton(
            //   onPressed: () {
            //     Navigator.of(context).pushNamed(CartScreen.routeName);
            //   },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(widget.product.imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  child: Image.network(widget.product.imageUrl),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 80,
                  child: Image.network(widget.product.imageUrl),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 80,
                  child: Image.network(widget.product.imageUrl),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                ' ${widget.product.price} \ VND',
                textAlign: TextAlign.start,
                softWrap: true,
                style: const TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                ' ${widget.product.description}',
                textAlign: TextAlign.start,
                softWrap: true,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Row(children: [
                Text('  4.7 '),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Text(' | Đã bán: 2,2k')
              ]),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: 80,
                        child: ClipOval(
                          child: Image.network(widget.product.imageUrl),
                        )),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Text('Quần áo Cần Thơ', style: TextStyle(fontSize: 17)),
                        Text('Online 55 phút trước',
                            style: TextStyle(color: Colors.grey)),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            Text(
                              'Cần Thơ',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          side: BorderSide(color: Colors.redAccent),
                          foregroundColor: Colors.redAccent,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Xem Shop >',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          '103 ',
                          style: TextStyle(color: Colors.red),
                        ),
                        Text('Sản phẩm'),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          '500 ',
                          style: TextStyle(color: Colors.red),
                        ),
                        Text('Đánh giá'),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          '90% ',
                          style: TextStyle(color: Colors.red),
                        ),
                        Text('Phản hồi'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 50,
        destinations: [
          Container(
            color: Colors.green,
            height: 50,
            child: IconButton(
              icon: Icon(Icons.add_shopping_cart, size: 40),
              color: Colors.white,
              onPressed: _onAddToCartPressed,
            ),
          ),
          Container(
            color: Colors.redAccent,
            height: 50,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {},
              child: const Text(
                'Mua ngay',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onAddToCartPressed() {
    final cart = context.read<CartManager>();
    cart.addItem(widget.product);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text(
            'Item added to cart',
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              cart.removeItem(widget.product.id!);
            },
          ),
        ),
      );
  }

  TextFormField _buildAmountField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Input amount'),
      controller: _amountController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an amount.';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (int.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
    );
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.home),
      onPressed: onPressed,
    );
  }
}
