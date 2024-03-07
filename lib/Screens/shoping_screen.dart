import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Your Purchase"),
        elevation: 2,
        backgroundColor: Colors.transparent,
      ),
      body: Center(child: Text("This is Shoping Screen")),
    );
  }

}