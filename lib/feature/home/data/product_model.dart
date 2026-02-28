class ProductModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final String rating;
  final String price;

  ProductModel({
    required this.name, required this.id, required this.description, required this.rating, required this.price, required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json["name"] ,
      description: json["description"],
      rating: json["rating"],
      image: json["image"],
      price: json["price"],
      id: json["id"],
    );
  }
}