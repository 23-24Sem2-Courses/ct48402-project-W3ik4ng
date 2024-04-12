import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Container(
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  const Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Your name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Đơn hàng của tôi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/orders');
                        },
                        child: const Text('Xem tất cả đơn hàng >'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 30,
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                child: const Text(
                  'Gian hàng của tôi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/user-products');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
