import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_providers.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrdersProviders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]),
      ),
    );
  }
}
