import 'package:ct484_project/services/cart_items_service.dart';
import 'package:flutter/foundation.dart';

import '../../models/auth_token.dart';
import '../../models/cart_item.dart';
import '../../models/product.dart';

class CartManager with ChangeNotifier {
  Map<String, CartItem> _items = {};

  final CartItemsService _cartItemsService;

  CartManager([AuthToken? authToken])
      : _cartItemsService = CartItemsService(authToken);

  set authToken(AuthToken? authToken) {
    _cartItemsService.authToken = authToken;
  }

  Future<void> fetchCartItems() async {
    _items = await _cartItemsService.fetchItems();
    notifyListeners();
  }

  int get productCount {
    return _items.length;
  }

  List<CartItem> get products {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  Future<void> addItem(Product product) async {
    if (_items.containsKey(product.id)) {
      await _cartItemsService.updateItem(
        _items.update(
          product.id!,
          (existingCartItem) => existingCartItem.copyWith(
            quantity: existingCartItem.quantity + 1,
          ),
        ),
      );
    } else {
      CartItem newItem = _items.putIfAbsent(
        product.id!,
        () => CartItem(
            id: 'c${DateTime.now().toIso8601String()}',
            title: product.title,
            imageUrl: product.imageUrl,
            quantity: 1,
            price: product.price),
      );
      await _cartItemsService.addItem(product.id!, newItem);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity as num > 1) {
      _items.update(
        productId,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearAllItems() {
    _items = {};
    notifyListeners();
  }
}
