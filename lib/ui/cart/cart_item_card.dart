import 'package:flutter/material.dart';

import '../../models/cart.dart';
import '../shared/dialog_utils.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final CartItem cartItem;

  const CartItemCard({
    required this.productId,
    required this.cartItem,
    super.key,
  });

  @override
  Widget build(BuildContext context){
    return Dismissible(
        key: ValueKey(cartItem.id),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
          return showConfirmDialog(context, 'Do you want to remove the item from the cart?',
          );
      },
      onDismissed: (direction){
          print('Cart item dismissed');
      },
      child: ItemInfoCard(cartItem),
    );
  }
}

class ItemInfoCard extends StatelessWidget {
  const ItemInfoCard(this.cartItem,{super.key});
  final CartItem cartItem;
  @override
  Widget build(BuildContext context){
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ) ,
      child: Padding (
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              cartItem.image,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
          title: Text(cartItem.title,
                      style: TextStyle(fontSize: 25,),),
          subtitle: Text('Giá: ${(cartItem.price )} \ VND',
                        ),
          trailing: Column(
            children: <Widget>[
              Text(
                'Số lượng: ${ cartItem.quantity}',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              Text(
                'Tổng: ${cartItem.price * cartItem.quantity}\ VND',
                  style: TextStyle(color: Colors.redAccent, fontSize: 16,)

              ),
            ],
          ),
        ),
      ),
    );
  }
}