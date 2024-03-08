import 'package:flutter/material.dart';
import 'package:htg_smart_watch/models/home_product_tile.dart';
import 'package:htg_smart_watch/models/products.dart';
import 'package:htg_smart_watch/models/shop.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double containerHeight = 480;
  bool isDescriptionOn = false;
  Icon upArrowIcon = const Icon(Icons.keyboard_arrow_up_outlined);
  Icon downArrowIcon = const Icon(Icons.keyboard_arrow_down_outlined);
  late List<Product> products;

  @override
  Widget build(BuildContext context) {
    products = context.watch<Shop>().shop;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
        elevation: 2,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey.shade400,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  // This ensures the child is centered in the Container
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    // Centers the text vertically
                    decoration: InputDecoration(
                      hintText: "Search Here",
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                        padding: EdgeInsets.zero,
                        // Minimizes padding around the icon if necessary
                        constraints:
                            const BoxConstraints(), // Removes constraints if you want a smaller icon
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      // Adjusts padding to center the text
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(width: 1.5)),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 580,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return HomeProductTile(product: product);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
