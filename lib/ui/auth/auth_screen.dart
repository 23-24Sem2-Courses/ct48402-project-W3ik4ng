import 'package:flutter/material.dart';

import 'auth_card.dart';
import 'app_banner.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    var _authMode;
    return Scaffold(

      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            child:Column(
              children: [
                  Flexible(
                  child: AppBanner(),
                ),
                Container(
                  width: double.infinity,

                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
                  child: Text('Sản phầm chất lượng, tư vấn nhiệt tình',
                    style: TextStyle(fontSize: 18,  color: Colors.black,),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(

              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
