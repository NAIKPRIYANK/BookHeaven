class Book {
  final int id;
  final int discount;
  final String imagePath;

  Book({
    required this.id,
    required this.discount,
    required this.imagePath,
  });

  // Convert JSON to Book object
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      discount: json['discount'],
      imagePath: json['image_path'],
    );
  }

  // Convert Book object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'discount': discount,
      'image_path': imagePath,
    };
  }
}
