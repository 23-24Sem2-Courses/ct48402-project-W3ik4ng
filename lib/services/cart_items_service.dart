import 'dart:convert';

import 'package:ct484_project/models/cart_item.dart';
import '../models/auth_token.dart';

import 'firebase_sevice.dart';

class CartItemsService extends FirebaseService {
  CartItemsService([AuthToken? authToken]) : super(authToken);

  Future<Map<String, CartItem>> fetchItems() async {
    final Map<String, CartItem> items = {};

    try {
      final productMap = await httpFetch(
        '$databaseUrl/cartItems.json?auth=$token&orderBy="creatorId"&equalTo="$userId"',
      ) as Map<String, dynamic>?;

      productMap?.forEach((cartItemId, item) {
        items.addAll(
          CartItem.fromJson({
            'id': cartItemId,
            ...item,
          }),
        );
      });

      return items;
    } catch (error) {
      print(error);
      return items;
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

  Future<bool> removeItem(String id) async {
    try {
      await httpFetch(
        '$databaseUrl/cartItems/$id.json?auth=$token',
        method: HttpMethod.delete,
      );

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> removeAllItems() async {
    try {
      final productMap = await httpFetch(
        '$databaseUrl/cartItems.json?auth=$token&orderBy="creatorId"&equalTo="$userId"',
      ) as Map<String, dynamic>?;

      if (productMap != null) {
        Future.forEach(productMap.keys, (id) async {
          await httpFetch(
            '$databaseUrl/cartItems/$id.json?auth=$token',
            method: HttpMethod.delete,
          );
        });
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
