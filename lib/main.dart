import 'package:ct484_project/ui/app_theme.dart';
import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:ct484_project/ui/auth/auth_screen.dart';
import 'package:ct484_project/ui/home.dart';
import 'package:ct484_project/ui/products/products_manager.dart';
import 'package:ct484_project/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.light();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
          create: (ctx) => ProductsManager(),
          update: (ctx, authManager, productsManager) {
            productsManager!.authToken = authManager.authToken;
            return productsManager;
          },
        ),
        // ChangeNotifierProxyProvider<AuthManager, CartManager>(
        //   create: (ctx) => CartManager(),
        //   update: (ctx, authManager, cartManager) {
        //     cartManager!.authToken = authManager.authToken;
        //     return cartManager;
        //   },
        // ),
        // ChangeNotifierProvider(
        //   create: (ctx) => OrderManager(),
        // ),
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            title: 'MyShop',
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: authManager.isAuth
                ? const SafeArea(child: Home())
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SafeArea(child: SplashScreen())
                          : const SafeArea(child: AuthScreen());
                    },
                  ),
          );
        },
      ),
    );
  }
}
