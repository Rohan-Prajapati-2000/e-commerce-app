import 'package:flutter/material.dart';
import 'package:htg_smart_watch/models/products.dart';
import 'package:htg_smart_watch/models/shop.dart';
import 'package:htg_smart_watch/product_image_array.dart';
import 'package:provider/provider.dart';

class HomeProductTile extends StatefulWidget {
  final Product product;

  HomeProductTile({Key? key, required this.product}) : super(key: key);

  @override
  State<HomeProductTile> createState() => _HomeProductTileState();
}

class _HomeProductTileState extends State<HomeProductTile> {
  double containerHeight = 520;
  bool isDescriptionOn = false;

  void addToCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Add this item to your cart"),
        actions: [
          MaterialButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            child: Text("Add"),
            onPressed: () {
              Navigator.pop(context);
              context.read<Shop>().addToCart(widget.product);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: containerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ImageListViewArray(),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
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
                              Text("MRP: ₹${widget.product.mrp}", style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("Price: ₹${widget.product.price.toString()}"),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => addToCart(context),
                      child: const Text("Add to Cart", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {},
                      child: const Text("Buy Now", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Description:- ", style: TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: isDescriptionOn
                            ? const Icon(Icons.keyboard_arrow_up_outlined)
                            : const Icon(Icons.keyboard_arrow_down_outlined),
                        onPressed: () {
                          setState(() {
                            isDescriptionOn = !isDescriptionOn;
                            containerHeight = isDescriptionOn ? 600 : 520;
                          });
                        },
                      ),
                    ],
                  ),
                  if (isDescriptionOn)
                    Text(widget.product.description)
                  else
                    Text(
                      widget.product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
