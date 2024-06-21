class Product{
  final String name;
  final String description;
  final List<dynamic> images;
  final int price;
  int quantity;
  int mrp;

  Product({
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    this.quantity=1,
    this.mrp=0
  });

  // Convert a Product instance to a Map
  Map<String, dynamic> toJson() => {
    'name' : name,
    'description' : description,
    'images' : images,
    'price' : price,
    'quantity' : quantity,
    'mrp' : mrp
  };

  // Create a product instance from a Map
  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      name: json['name'],
      description: json['description'],
      images: (json['images'] as List).map((e) => e.toString()).toList(),
      price: json['price'],
      quantity: json['quantity'] ?? 1, // Providing a default value if it's null
      mrp: json['mrp'],
    );
  }

}