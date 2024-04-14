import 'dart:convert';

import 'package:ct484_project/models/order_item.dart';

import '../models/product.dart';
import '../models/auth_token.dart';

import 'firebase_sevice.dart';

class OrderItemsService extends FirebaseService {
  OrderItemsService([AuthToken? authToken]) : super(authToken);

  Future<List<OrderItem>> fetchProducts({bool filteredByUser = false}) async {
    List<OrderItem> orderItems = [];

    try {
      final orderMap = await httpFetch(
        '$databaseUrl/orderItems.json?auth=$token',
      ) as Map<String, dynamic>?;

      orderMap?.forEach((orderItemId, orderItem) {
        orderItems.add(
          OrderItem.fromJson({
            'id': orderItemId,
            ...orderItem,
          }),
        );
      });
      return orderItems;
    } catch (error) {
      print(error);
      return orderItems;
    }
  }

  Future<OrderItem?> addOrder(OrderItem orderItem) async {
    try {
      final dateTimeString = orderItem.dateTime.toIso8601String();

      final newProduct = await httpFetch(
        '$databaseUrl/orderItems.json?auth=$token',
        method: HttpMethod.post,
        body: jsonEncode(orderItem.toJson()
          ..addAll({'creatorId': userId, 'dateTime': dateTimeString})),
      ) as Map<String, dynamic>?;

      return orderItem.copyWith(
        id: newProduct!['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      await httpFetch(
        '$databaseUrl/products/${product.id}.json?auth=$token',
        method: HttpMethod.patch,
        body: jsonEncode(product.toJson()),
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
