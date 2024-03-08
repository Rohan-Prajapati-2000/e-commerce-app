class Product{
  final String name;
  final String description;
  final String image;
  final int price;
  int quantity;
  int mrp;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    this.quantity=1,
    this.mrp=0
  });

  // Convert a Product instance to a Map
  Map<String, dynamic> toJson() => {
    'name' : name,
    'description' : description,
    'image' : image,
    'price' : price,
    'quantity' : quantity,
    'mrp' : mrp
  };

  // Create a product instance from a Map
  factory Product.fromJson(Map<String, dynamic> map){
    return Product(
      name: map['name'],
      description : map['description'],
      image: map['image'],
      price: map['price'],
      quantity: map['quantity']?? 1,
      mrp: map['mrp']
    );
  }

}