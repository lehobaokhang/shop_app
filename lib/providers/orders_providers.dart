import 'package:flutter/foundation.dart';

import '../models/order.dart';
import '../models/cart.dart';

class OrdersProviders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<Cart> cartProducts, double total) {
    _orders.add(Order(
      id: DateTime.now().toString(),
      amount: total,
      dateTime: DateTime.now(),
      products: cartProducts,
    ));
    notifyListeners();
  }
}
