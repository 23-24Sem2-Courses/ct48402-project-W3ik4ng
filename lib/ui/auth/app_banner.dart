import 'dart:math';


import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 25.0,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black26,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            child: Center(
              child: FlutterLogo(
                size: 50,
              ),
            ),
          ),
          Text(
            'MyShop',
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge?.color,
              fontSize: 50,
              fontFamily: 'Anton',
              fontWeight: FontWeight.normal,
            ),
          ),
          Container(
            width: 100,
            height: 100,
            child: Center(
              child: FlutterLogo(
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
