import 'dart:convert';

import 'package:ct484_project/models/cart_item.dart';
import 'package:ct484_project/ui/cart/cart_manager.dart';

import '../models/product.dart';
import '../models/auth_token.dart';

import 'firebase_sevice.dart';

class CartItemsService extends FirebaseService {
  CartItemsService([AuthToken? authToken]) : super(authToken);

  Future<Map<String, CartItem>> fetchItems() async {
    final Map<String, CartItem> itemsMap = {};
    // final Map<String, CartItem> items = {};

    try {
      // final filters = 'orderBy="creatorId"&equalTo="$userId"';

      final productMap = await httpFetch(
        '$databaseUrl/cartItems.json?auth=$token',
      ) as Map<String, dynamic>?;

      productMap?.forEach((productId, item) {
        print(item);
        CartItem cartItem = CartItem.fromJson(item);
        print(cartItem);
        itemsMap[productId] = cartItem;
      });

      return itemsMap;
    } catch (error) {
      print(error);
      return itemsMap;
    }
  }

  Future<bool> addItem(String productId, CartItem cartItem) async {
    try {
      await httpFetch(
        '$databaseUrl/cartItems.json?auth=$token',
        method: HttpMethod.post,
        body: jsonEncode(
          cartItem.toJson()
            ..addAll({'creatorId': userId, 'productId': productId}),
        ),
      ) as Map<String, dynamic>?;

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> updateItem(CartItem item) async {
    try {
      await httpFetch(
        '$databaseUrl/cartItems/${item.id}.json?auth=$token',
        method: HttpMethod.patch,
        body: jsonEncode(item.toJson()),
      );

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      await httpFetch(
        '$databaseUrl/products/$id.json?auth=$token',
        method: HttpMethod.delete,
      );

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
