import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_item_card.dart';
import 'orders_manager.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<void> _fetchOrders;

  @override
  void initState() {
    super.initState();
    _fetchOrders = context.read<OrderManager>().fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    final ordersManager = OrderManager();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: _fetchOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: ordersManager.orderCount,
              itemBuilder: (ctx, i) => OrderItemCard(ordersManager.orders[i]),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
