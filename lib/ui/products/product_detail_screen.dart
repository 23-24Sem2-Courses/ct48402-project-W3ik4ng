import 'package:flutter/material.dart';

import '../../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
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
            Text(
              '\$${widget.product.price}',
              style: const TextStyle(color: Colors.red, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                widget.product.description,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children: [
                  SizedBox(
                    width: 100,
                    child: _buildAmountField(),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed: _onAddToCartPressed,
                    color: Theme.of(context).colorScheme.secondary,
                  )
                ])
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onAddToCartPressed() {
    //   final cart = context.read<CartManager>();
    //   int amount = int.tryParse(_amountController.text) ?? 1;
    //   cart.addMultiple(widget.product, amount);
    //   ScaffoldMessenger.of(context)
    //     ..hideCurrentSnackBar()
    //     ..showSnackBar(
    //       SnackBar(
    //         content: const Text(
    //           'Item added to cart',
    //         ),
    //         duration: const Duration(seconds: 2),
    //         action: SnackBarAction(
    //           label: 'UNDO',
    //           onPressed: () {
    //             cart.removeItem(widget.product.id!);
    //           },
    //         ),
    //       ),
    //     );
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
