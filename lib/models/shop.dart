import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:htg_smart_watch/models/products.dart';

class Shop extends ChangeNotifier {
  // Product for sale
  final List<Product> _shop = [
    Product(name: "Product 1", description: "Item Description", price: 199),
    Product(name: "Product 2", description: "Item Description", price: 299),
    Product(name: "Product 3", description: "Item Description", price: 399),
    Product(name: "Product 4", description: "Item Description", price: 499),
    Product(name: "Product 5", description: "Item Description", price: 599),
    Product(name: "Product 6", description: "Item Description", price: 699),
    Product(name: "Product 7", description: "Item Description", price: 799),
    Product(name: "Product 8", description: "Item Description", price: 899),
    Product(name: "Product 9", description: "Item Description", price: 999),
  ];

  // User Cart
  List<Product> _cart = [];

  // Get Products List
  List<Product> get shop => _shop;

  // Get User Cart
  List<Product> get cart => _cart;

  // Firestore collection reference
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  // Add item to cart
  void addToCart(Product product) {
    final existingProductIndex =
        _cart.indexWhere((item) => item.name == product.name);

    if (existingProductIndex != -1) {
      //If the product is already exist, increase its quantity
      _cart[existingProductIndex].quantity++;
    } else {
      _cart.add(product);
    }

    // Saving and Updating cart on firestore
    updateCartOnFirestore();

    // Notify listeners that the cart has been updated
    notifyListeners();
  }

  // Remove to cart
  void removeToCart(Product item) {
    _cart.remove(item);
    updateCartOnFirestore();
    notifyListeners();
  }

  //Convart cart to list of map for Firestore
  List<Map<String, dynamic>> cartToMap() {
    return _cart.map((product) => product.toJson()).toList();
  }

  void updateCartOnFirestore() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await _userCollection
        .doc(userId)
        .set({'cart': cartToMap()}, SetOptions(merge: true));
  }

  // Load from cart
  Future<void> loadCartFromFirestore() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot documentSnapshot = await _userCollection.doc(userId).get();

    if (documentSnapshot.exists) {
      List<dynamic> cartData = documentSnapshot['cart'];
      _cart = cartData.map((data) => Product.fromJson(data)).toList();
      notifyListeners();
    }
  }
}
