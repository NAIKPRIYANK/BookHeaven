class BagBookModel {
  int? id;
  int userId;
  String bookName;
  double bookPrice;
  int quantity;
  String description;
  String imagePath;

  BagBookModel({
    this.id,
    required this.userId,
    required this.bookName,
    required this.bookPrice,
    required this.quantity,
    required this.description,
    required this.imagePath
  });

  /// ✅ Convert JSON (DB Data) to Model
  factory BagBookModel.fromMap(Map<String, dynamic> map) {
    return BagBookModel(
      id: map['id'],
      userId: map['user_id'],
      bookName: map['book_name'],
      bookPrice: map['book_price'],
      quantity: map['quantity'],
      description: map['description'],
      imagePath: map['imagePath']
    );
  }

  /// ✅ Convert Model to Map for DB Storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'book_name': bookName,
      'book_price': bookPrice,
      'quantity': quantity,
      'description': description,
      'imagePath':imagePath
    };
  }
}
