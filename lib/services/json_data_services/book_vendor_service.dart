import 'dart:convert';
import 'package:book_heaven/gen/assets.gen.dart';
import 'package:book_heaven/models/book_info_model.dart';
import 'package:book_heaven/models/book_with_vendor_model.dart';
import 'package:book_heaven/models/vendor_model.dart';
import 'package:flutter/services.dart' show rootBundle;


class BookVendorService {
  /// Loads the books from the JSON asset
  Future<List<BookInfo>> loadBooks() async {
    final String jsonString = await rootBundle.loadString(Assets.data.bookList);
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => BookInfo.fromJson(item)).toList();
  }

  /// Loads the vendors from the JSON asset
  Future<List<Vendor>> loadVendors() async {
    final String jsonString = await rootBundle.loadString(Assets.data.vendor);
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => Vendor.fromJson(item)).toList();
  }

  /// Fetches books and their associated vendors, merging them into BookWithVendor
  Future<List<BookWithVendor>> getBooksWithVendors() async {
    List<BookInfo> books = await loadBooks();
    List<Vendor> vendors = await loadVendors();

    // Creating a map of vendors for quick lookup
    Map<int, Vendor> vendorMap = { for (var vendor in vendors) vendor.id : vendor };

    // Merging book and vendor data based on vendor_id
    List<BookWithVendor> booksWithVendors = books.map((book) {
      Vendor? vendor = vendorMap[book.vendorId]; // Find vendor by vendorId
      return vendor != null ? BookWithVendor(book: book, vendor: vendor) : null;
    }).whereType<BookWithVendor>().toList();

    return booksWithVendors;
  }

  /// Fetch a single book with its vendor details using `bookId`
  Future<BookWithVendor?> getBookWithVendorById(int vendorId) async {
    List<BookWithVendor> booksWithVendors = await getBooksWithVendors();
    return booksWithVendors.firstWhere(
      (b) => b.book.id == vendorId,
      orElse: () => throw Exception("Book with ID $vendorId not found"), // Returns `null` if the book is not found
    );
  }

}
