class OptionModel {
  final int id;
  final String name;
  final String image;

  OptionModel({required this.name, required this.id, required this.image});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      name: json["name"],
      image: json["image"],
      id: json["id"],
    );
  }
}
