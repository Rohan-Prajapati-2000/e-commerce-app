import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:htg_smart_watch/models/products.dart';

class MyProductTile extends StatelessWidget{
  final Product product;
  MyProductTile({super.key, required this.product});


  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            // Product image
            Icon(Icons.favorite),
            // Product name
            Text(product.name),

            // Product Description
            Text(product.description),

            // product price + add to cart button
            Text(product.price.toStringAsFixed(2)),
          ],
        );
  }
}