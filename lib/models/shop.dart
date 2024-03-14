import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:htg_smart_watch/Utils/utils.dart';
import 'package:htg_smart_watch/models/products.dart';

class Shop extends ChangeNotifier {
  // Product for sale
  List<Product> _shop = [];

  // User Cart
  List<Product> _cart = [];

  // Get Products List
  List<Product> get shop => _shop;

  // Get User Cart
  List<Product> get cart => _cart;

  // Firestore collection reference for user
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  // Firestore collection reference for product
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('productsDetail');

//Constructor
  Shop(){
    loadProductFromFirestore();
  }

  // Fetch and load product from Firestore
  Future<void> loadProductFromFirestore() async{
    try{
      QuerySnapshot querySnapshot = await _productsCollection.get();
      _shop = querySnapshot.docs.map((doc){
        var data = doc.data() as Map<String, dynamic>;
        return Product(
            name: data['name'],
            description: data['description'],
            images: data['images'],
            price: data['price'],
            mrp: data['mrp']);
      }).toList();
      notifyListeners();
    } catch (e){
      Utils().toastMessage(e.toString());
    }
  }


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

  // Convert cart to list of map for Firestore
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
