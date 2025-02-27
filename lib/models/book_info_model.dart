// book_model.dart
class BookInfo {
  final int id;
  final String title;
  final double price;
  final String description;
  final String imagePath;
  final int vendorId;
  final bool availabilityStatus;

  BookInfo({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imagePath,
    required this.vendorId,
    required this.availabilityStatus
  });

  /// Factory constructor to create a Book instance from a JSON map.
  factory BookInfo.fromJson(Map<String, dynamic> json) {
    return BookInfo(

      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String, // Ensure double type
      imagePath: json['image_path'] as String,
      vendorId: json['vendor_id'] as int,
      availabilityStatus:json['availabilityStatus'] as bool
    );
  }
}
