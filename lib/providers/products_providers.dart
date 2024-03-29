import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imgURL:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imgURL:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imgURL: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imgURL:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  bool _isShowFavorites = false;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get getFavorites {
    return _items.where((item) => item.isFavorite).toList();
  }

  Future<void> fetchProducts() async {
    const url =
        'https://shopapp-c2551-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((key, value) {
        loadedProducts.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imgURL: value['imgUrl'],
          isFavorite: value['isFavorite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://shopapp-c2551-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imgUrl': product.imgURL,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imgURL: product.imgURL,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://shopapp-c2551-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json';
      await http.patch(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imgUrl': product.imgURL,
          },
        ),
      );
      _items[prodIndex] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final url =
        'https://shopapp-c2551-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json';
    final existsIndex = _items.indexWhere((prod) => prod.id == id);
    var existsProduct = _items[existsIndex];
    http.delete(url).then((_) {
      existsProduct = null;
    }).catchError((_) {
      _items.insert(existsIndex, existsProduct);
      notifyListeners();
    });
    _items.removeAt(existsIndex);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
