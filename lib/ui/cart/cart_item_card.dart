import 'package:flutter/material.dart';

import '../../models/cart_item.dart';
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

class ItemInfoCard extends StatefulWidget {
  const ItemInfoCard(this.cartItem,{super.key});
  final CartItem cartItem;

  @override
  _ItemInfoCardState createState() => _ItemInfoCardState();
}

class _ItemInfoCardState extends State<ItemInfoCard> {
  bool isSelected = false;

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
          leading: Checkbox(
            value: isSelected, // Set the value of the checkbox
            onChanged: (value) {
              setState(() {
                isSelected = value!; // Update the checkbox state when the user taps on it
              });
            },
          ),
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  widget.cartItem.image,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.cartItem.title,
                    style: TextStyle(fontSize: 25,),),
                  SizedBox(height: 8),
                  Text('Giá: ${(widget.cartItem.price )} \ VND',
                    style: TextStyle(fontSize: 16),),
                ],
              ),
            ],
          ),
          trailing: Column(
            children: <Widget>[
              Text(
                'Số lượng: ${ widget.cartItem.quantity}',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              Text(
                  'Tổng: ${widget.cartItem.price * widget.cartItem.quantity}\ VND',
                  style: TextStyle(color: Colors.redAccent, fontSize: 16,)

              ),
            ],
          ),
        ),
      ),
    );
  }
}