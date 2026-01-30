class UserModel {
  final String name;
  final String email;
  final String? image;
  final String? token;
  final String? visa;
  final String? adress;

  UserModel({
    required this.name,
    required this.email,
    this.image,
    this.token,
    this.visa,
    this.adress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      token: json["token"] ?? "",
      image: json["image"] ?? "",
      visa: json["Visa"] ?? "",
      adress: json["address"] ?? "",
    );
  }
}
