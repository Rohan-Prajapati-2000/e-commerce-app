class Product{
  final String name;
  final String description;
  // final String imagePath;
  final double price;
  int quantity;

  Product({
    required this.name,
    required this.description,
    // required this.imagePath,
    required this.price,
    this.quantity=1
  });

  // Convert a Product instance to a Map
  Map<String, dynamic> toJson() => {
    'name' : name,
    'description' : description,
    // 'imagePath' : imagePath,
    'price' : price,
    'quantity' : quantity,
  };

  // Create a product instance from a Map
  factory Product.fromJson(Map<String, dynamic> map){
    return Product(
      name: map['name'],
      description : map['description'],
      // imagePath: map['imagePath']
      price: map['price'],
      quantity: map['quantity']?? 1
    );
  }

}