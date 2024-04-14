import 'package:ct484_project/models/auth_token.dart';
import 'package:ct484_project/services/order_items_service.dart';
import 'package:flutter/foundation.dart';

import '../../models/cart_item.dart';
import '../../models/order_item.dart';

class OrderManager with ChangeNotifier {
  List<OrderItem> _orders = [];

  final OrderItemsService _orderItemsService;

  OrderManager([AuthToken? authToken])
      : _orderItemsService = OrderItemsService(authToken);

  set authToken(AuthToken? authToken) {
    _orderItemsService.authToken = authToken;
  }

  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    _orders = await _orderItemsService.fetchProducts();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final newOrder = await _orderItemsService.addOrder(
      OrderItem(
        id: 'o${DateTime.now().toIso8601String()}',
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    _orders.insert(0, newOrder!);
    notifyListeners();
  }
}
