import 'package:book_heaven/models/book_info_model.dart';
import 'package:book_heaven/models/vendor_model.dart';

class BookWithVendor {
  final BookInfo book;
  final Vendor vendor;

  BookWithVendor({
    required this.book,
    required this.vendor,
  });

  /// Factory constructor to create a BookWithVendor instance from a book and vendor.
  factory BookWithVendor.fromJson(BookInfo book, Vendor vendor) {
    return BookWithVendor(
      book: book,
      vendor: vendor,
    );
  }
}
