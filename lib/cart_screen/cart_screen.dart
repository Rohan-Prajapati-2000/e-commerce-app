import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:htg_smart_watch/models/products.dart';
import 'package:htg_smart_watch/models/shop.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Product> cart;
  @override
  Widget build(BuildContext context) {
    cart = context.watch<Shop>().cart;
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: Text("Cart"),
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
          child: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final item = cart[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/watch.jpg", height: 90, width: 90)
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name),
                                Text(item.description)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(onPressed: (){
                                    setState(() {
                                      if(item.quantity>1){
                                        item.quantity--;
                                      }
                                    });
                                  }, icon: Icon(Icons.remove, size: 15, color: Colors.black,)),
                                  Text("${item.quantity}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                  IconButton(onPressed: (){
                                    setState(() {
                                      item.quantity++;
                                    });
                                  }, icon: Icon(Icons.add, size: 15,color: Colors.black,)),

                                ],
                              )
                            ],
                          ),

                          Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: CupertinoColors.systemYellow,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              onPressed: (){}, child: Text("Remove"))
                            ],
                          ),

                          Column(
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: CupertinoColors.systemYellow,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                  onPressed: (){}, child: Text("Pay"))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
