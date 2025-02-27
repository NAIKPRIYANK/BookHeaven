import 'dart:convert';
import 'package:book_heaven/gen/assets.gen.dart';
import 'package:book_heaven/models/authors_info_model.dart';
import 'package:flutter/services.dart' show rootBundle;


class AuthorService {
  /// Load authors from the JSON file
  Future<List<Author>> loadAuthors() async {
    final String jsonString = await rootBundle.loadString(Assets.data.authors);
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => Author.fromJson(item)).toList();
  }
}
