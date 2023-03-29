class BrandModel {
  String? id;
  String name;
  bool status;

  BrandModel({
    this.id,
    required this.name,
    required this.status,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        name: json["name"] ?? "",
        status: json["status"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
      };
}
