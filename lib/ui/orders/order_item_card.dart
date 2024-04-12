import 'dart:math';
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
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(right: 0),
            child: Image.network(
              widget.order.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                OrderSummary(
                  expanded: _expanded,
                  order: widget.order,
                  onExpandPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),
                if (_expanded) OrderItemList(widget.order),
              ],
            ),
          ),
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
      height: min(order.productCount * 20.0 + 10, 100),
      child: ListView(
        children: order.products
            .map(
              (prod) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    prod.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${prod.quantity}x \$${prod.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.order,
    required this.expanded,
    this.onExpandPressed,
  });

  final bool expanded;
  final OrderItem order;
  final void Function()? onExpandPressed;

  @override
  Widget build(BuildContext context) {
    final totalQuantity = order.products.fold(
      0,
      (previousValue, element) => previousValue + element.quantity,
    );

    final priceProduct = order.amount / totalQuantity;

    return ListTile(
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      title: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${order.title}',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Text('${priceProduct}\ VND', style: TextStyle(fontSize: 18)),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      subtitle: Text(
        DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime),
        style: TextStyle(color: Colors.blue),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Số lượng: ${totalQuantity}',
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
    );
  }
}
