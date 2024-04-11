import '../../models/cart_item.dart';
import '../../models/order_item.dart';

class OrdersManager  {
  final List<OrderItem> _orders = [
    OrderItem(
      id: 'o1',
      amount: 59.98 + 29.99,
      title: 'Red Shirt',
      image: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      products: [
        CartItem(
          id: 'c1',
          title: 'Red Shirt',
          image: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          price: 29.99,
          quantity: 3,
        )
      ],
      dateTime: DateTime.now(),
    )
  ];

  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders{
    return [..._orders];
  }


}