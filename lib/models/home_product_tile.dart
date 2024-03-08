import 'package:flutter/material.dart';
import 'package:htg_smart_watch/models/products.dart';
import 'package:htg_smart_watch/models/shop.dart';
import 'package:provider/provider.dart';

class HomeProductTile extends StatefulWidget {
  final Product product;

  HomeProductTile({super.key, required this.product});

  @override
  State<HomeProductTile> createState() => _HomeProductTileState();
}

class _HomeProductTileState extends State<HomeProductTile> {
  double containerHeight = 520;
  bool isDescriptionOn = false;

  void addToCart(BuildContext context){
    showDialog(context: context,
        builder: (context) => AlertDialog(
          content: Text("Add this item to your cart"),
          actions: [
            // Cancel button
            MaterialButton(
                child: Text("Cancel"),
                onPressed: (){
              Navigator.pop(context);
            }),

            // Add button
            MaterialButton(
                child: Text("Add"),
                onPressed: (){
                  Navigator.pop(context);
                  // add to cart
                  context.read<Shop>().addToCart(widget.product);
                }),
          ],
        ),);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [

          Container(
            height: containerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),

            // This is inside container
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Image.network(widget.product.image, height: 250, width: 250),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.product.name),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("MRP: ₹ ${widget.product.mrp}"),
                              Text("Price: ₹ ${widget.product.price.toString()}"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffffe914),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          addToCart(context);
                        },
                        child: const Text("Add to Cart",
                            style: TextStyle(color: Colors.black))),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffffe914),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {},
                        child: const Text("Buy Now",
                            style: TextStyle(color: Colors.black))),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Description:- ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                          icon: isDescriptionOn
                              ? Icon(Icons.keyboard_arrow_up_outlined)
                              : Icon(Icons.keyboard_arrow_down_outlined),
                          onPressed: () {
                            setState(() {
                              isDescriptionOn = !isDescriptionOn;
                              isDescriptionOn
                                  ? containerHeight = 600
                                  : containerHeight = 520;
                            });
                          }),
                    ],
                  ),
                  SizedBox(height: 5),
                  // Text(widget.product.description),
                 if (isDescriptionOn)
                   Text(widget.product.description)// Show full description
                 else
                   Text(
                     widget.product.description,
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                   )
                ],
              ),
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
    );

  }
}

