import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './product_item.dart';
import '../providers/products_providers.dart';

class ProductGrid extends StatelessWidget {
  final bool _isShowFavorites;

  ProductGrid(@required this._isShowFavorites);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final loadedProducts =
        _isShowFavorites ? productData.getFavorites : productData.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index],
        child: ProductItem(),
      ),
      itemCount: loadedProducts.length,
      padding: const EdgeInsets.all(10),
    );
  }
}
