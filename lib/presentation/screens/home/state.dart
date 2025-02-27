import 'package:book_heaven/models/authors_info_model.dart';
import 'package:book_heaven/models/book_info_model.dart';
import 'package:book_heaven/models/book_offer_model.dart';
import 'package:book_heaven/models/vendor_model.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus? status;
  final List<Book>? books;
  final List<BookInfo>? bookInfo;
  final List<Vendor>? vendors;
  final List<Author>? authors;

  const HomeState({
    this.status,
    this.books,
    this.bookInfo,
    this.vendors,
    this.authors
  });

  static HomeState initial() {
    return const HomeState(
      status: HomeStatus.initial,
      books: [],
      bookInfo: [],
      vendors: [],
      authors: []
    );
  }

  HomeState clone({
    HomeStatus? status,
    List<Book>? books,
    List<BookInfo>? bookInfo,
    List<Vendor>? vendors,
    List<Author>? authors
  }) {
    return HomeState(
      status: status ?? this.status,
      books: books ?? this.books,
      bookInfo: bookInfo ?? this.bookInfo,
      vendors: vendors ?? this.vendors,
      authors: authors ?? this.authors
    );
  }

  @override
  List<Object?> get props => [
        status,
        books,
        bookInfo,
        vendors,
        authors
        // Add counts to the props list for comparison
      ];
}
