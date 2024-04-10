import 'package:flutter/material.dart';

import 'cart_manager.dart';
import 'cart_item_card.dart';

class CartScreen extends StatelessWidget{
  const CartScreen({
    super.key,

  });

  @override
  Widget build(BuildContext context){
    final cart = CartManager();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){

          },
        ),
        title: const Text('You cart'),
        shadowColor: Colors.black,
          actions: <Widget>[
            IconButton(
            icon: const Icon(Icons.message_outlined),
            tooltip: 'Show message',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a message')));
            },
          ),

        ],


      ),
      body: Column(
        children: <Widget>[

          const SizedBox(height: 10,),
          Expanded(child: CartItemList(cart),
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          CartSummary(
            cart: cart,
            onOrderNowPressed: (){
              print('An order has been added');
            },
          ),

          Container(
            color: Colors.red,
            height: 80,
            child: TextButton(
              onPressed: (){},
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child:  Text('MUA NGAY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  )
              ),
            ),
          ),
      ],
      ),
    );
  }
}

class CartItemList extends StatelessWidget {
  const CartItemList(this.cart,{super.key});
  final CartManager cart;

  @override
  Widget build(BuildContext context){
    return Column(
      children: cart.productEntries.map(
          (entry) => CartItemCard(
              productId: entry.key,
              cartItem: entry.value,

          ),

      ).toList(),
    );
  }
}

class CartSummary extends StatelessWidget {
  const CartSummary({
    super.key,
    required this.cart,
    this.onOrderNowPressed,
  });

  final CartManager cart;
  final void Function()? onOrderNowPressed;

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Thanh toán', style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Chip(label: Text('${cart.totalAmount.toStringAsFixed(2)}\ VND',
            style: Theme.of(context).primaryTextTheme.titleLarge,
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),

          ],
        ),
      ),
    );
  }
}