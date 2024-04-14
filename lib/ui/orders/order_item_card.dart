import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/order_item.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem order;
  const OrderItemCard(this.order, {super.key});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          OrderItemList(widget.order),
        ],
      ),
    );
  }
}

// The rest of the code remains the same

class OrderItemList extends StatelessWidget {
  const OrderItemList(this.order, {super.key});

  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      height: 120,
      child: ListView(
        children: order.products
            .map(
              (prod) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(right: 0),
                    child: Image.network(
                      prod.imageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${prod.title}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text('${prod.price}\ VND',
                          style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime),
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Số lượng: ${prod.quantity}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${order.amount.toStringAsFixed(2)}\ VND',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

// class OrderSummary extends StatelessWidget {
//   const OrderSummary(
//     this.order, {
//     super.key,
//   });

//   final OrderItem order;

//   @override
//   Widget build(BuildContext context) {
//     final totalQuantity = order.products.fold(
//       0,
//       (previousValue, element) => previousValue + element.quantity,
//     );

//     final priceProduct = order.amount / totalQuantity;

//     return ListTile(
//       titleTextStyle: Theme.of(context).textTheme.titleLarge,
//       title: 
//       subtitle: 
//       trailing: 
//     );
//   }
// }
