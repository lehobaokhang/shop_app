import 'package:flutter/foundation.dart';

import '../models/cart.dart';

class CartsProvider with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  int get cartItems {
    return _items == null ? 0 : _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existsingCartItem) => Cart(
          id: existsingCartItem.id,
          title: existsingCartItem.title,
          price: existsingCartItem.price,
          quantity: existsingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => Cart(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
}
