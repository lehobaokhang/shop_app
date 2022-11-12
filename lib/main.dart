import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_overview_screen.dart';
import './screens/product_details_screen.dart';
import './providers/products_providers.dart';
import 'providers/carts_providers.dart';
import './screens/cart_screen.dart';
import './providers/orders_providers.dart';
import './screens/order_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return ProductsProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return CartsProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return OrdersProviders();
          },
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
        },
      ),
    );
  }
}
