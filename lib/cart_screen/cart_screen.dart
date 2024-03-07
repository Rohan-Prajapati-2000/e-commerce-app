import 'package:flutter/material.dart';
import 'package:htg_smart_watch/cart_screen/cart_content.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: Text("Cart"),
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: CartContent()
    );
  }
}
