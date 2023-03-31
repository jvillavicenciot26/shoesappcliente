class BrandModel {
  String? id;
  String name;
  String image;
  bool status;

  BrandModel({
    this.id,
    required this.name,
    required this.image,
    required this.status,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        name: json["name"] ?? "",
        image: json["image"] ?? "",
        status: json["status"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
      };
}
