class Vendor {
  final int id;
  final String image;

  Vendor({
    required this.id,
    required this.image,
  });

  /// Factory constructor to create a Vendor instance from JSON
  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] as int,
      image: json['image'] as String,
    );
  }

  /// Convert Vendor object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }
}
