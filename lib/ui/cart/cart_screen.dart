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
          Container(
          height: 120,
            child: CartItemList(cart),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(0),
        height: 60,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black12),

                  ),
                ),
                child: CartSummary(
                  cart: cart,
                  onOrderNowPressed: (){
                    print('An order has been added');
                  },

                ),


              ),
            ),

            Expanded(
              flex: 1,
              child: Container(
                height: 60,
                child: TextButton(
                  onPressed: (){},
                  style: TextButton.styleFrom(
                    fixedSize: Size(10, 25),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    backgroundColor: Colors.red,
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child:  Text('MUA NGAY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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

class CartSummary extends StatefulWidget {
  const CartSummary({
    super.key,
    required this.cart,
    this.onOrderNowPressed,
  });

  final CartManager cart;
  final void Function()? onOrderNowPressed;

  @override
  _CartSummaryState createState() => _CartSummaryState();
}

class _CartSummaryState extends State<CartSummary> {
  bool isAllSelected = false; // Declare a variable to store the checkbox state

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Checkbox(
                  value: isAllSelected, // Set the value of the checkbox
                  onChanged: (value) {
                    setState(() {
                      isAllSelected = value!; // Update the checkbox state when the user taps on it
                    });
                  },

                ),
                const Text('Tất cả', style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            const Spacer(),

        Text('Tổng: ', style: TextStyle(fontSize: 15),),

        Text('${widget.cart.totalAmount}\ VND',style: TextStyle(fontSize: 20, color: Colors.red),),



          ],
        ),
      ),
    );
  }
}