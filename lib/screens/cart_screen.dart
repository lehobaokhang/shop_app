import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/carts_providers.dart';
import '../widgets/cart_item.dart';
import '../providers/orders_providers.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                    child: Text('ORDER NOW'),
                    onPressed: () {
                      Provider.of<OrdersProviders>(context, listen: false)
                          .addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                id: cart.items.values.toList()[i].id,
                productId: cart.items.keys.toList()[i],
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity,
                title: cart.items.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
