import 'package:ct484_project/ui/cart/cart_screen.dart';
import 'package:ct484_project/ui/products/products_grid.dart';
import 'package:ct484_project/ui/users/user_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const ProductsGrid(),
    const CartScreen(),
    const UserScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Trang Chủ'),
          NavigationDestination(
              icon: Icon(Icons.shopping_cart), label: 'Giỏ Hàng'),
          NavigationDestination(
              icon: Icon(Icons.supervised_user_circle), label: 'Tài Khoản'),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
}
