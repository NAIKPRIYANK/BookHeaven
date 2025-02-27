import 'dart:convert';

import 'package:book_heaven/gen/assets.gen.dart';
import 'package:book_heaven/models/book_offer_model.dart';
import 'package:flutter/services.dart';

class BookService {
  static Future<List<Book>> loadBooks() async {
    try {
      String jsonString = await rootBundle.loadString(Assets.data.bookPriceOffer);
      List<dynamic> jsonResponse = json.decode(jsonString);
      return jsonResponse.map((book) => Book.fromJson(book)).toList();
    } catch (e) {
      return [];
    }
  }
}