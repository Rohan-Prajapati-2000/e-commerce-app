import 'package:flutter/cupertino.dart';
import 'package:htg_smart_watch/models/products.dart';

class Shop extends ChangeNotifier{
  // Product for sale
  final List<Product> _shop = [
    Product(
        name: "Product 1",
        description: "Item Description",
        price: 199),

    Product(
        name: "Product 2",
        description: "Item Description",
        price: 299),

    Product(
        name: "Product 3",
        description: "Item Description",
        price: 399),

    Product(
        name: "Product 4",
        description: "Item Description",
        price: 499),
  ];

  // User Cart
  List<Product> _cart = [];

  // Get Products List
  List<Product> get shop => _shop;

  // Get User Cart
  List<Product> get cart => _cart;

  // Add item to cart
  void addToCart(Product product){

    final existingProductIndex = _cart.indexWhere((item) => item.name==product.name);

    if (existingProductIndex != -1){
      //If the product is already exist, increase its quantity
      _cart[existingProductIndex].quantity++;
    }else{
      _cart.add(product);
    }
    // Notify listeners that the cart has been updated
    notifyListeners();
  }

  // Remove to cart
  void removeToCart(Product item){
    _cart.remove(item);
    notifyListeners();
  }

}
