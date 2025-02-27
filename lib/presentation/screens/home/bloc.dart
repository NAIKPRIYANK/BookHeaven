import 'package:book_heaven/models/authors_info_model.dart';
import 'package:book_heaven/models/book_info_model.dart';
import 'package:book_heaven/models/book_offer_model.dart';
import 'package:book_heaven/models/book_with_vendor_model.dart';
import 'package:book_heaven/models/vendor_model.dart';
import 'package:book_heaven/presentation/screens/home/event.dart';
import 'package:book_heaven/presentation/screens/home/state.dart';
import 'package:book_heaven/services/json_data_services/author_service.dart';
import 'package:book_heaven/services/json_data_services/book_service.dart';
import 'package:book_heaven/services/json_data_services/book_vendor_service.dart' as bvs;
import 'package:book_heaven/ui_components/book_info_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<InitEvent>(_init);
    on<BookInfoEvent>(_bookInfo);

  }

  Future<void> _init(HomeEvent event, Emitter<HomeState> emit) async {

    emit(state.clone(status: HomeStatus.loading));
    List<Book> books = await BookService.loadBooks();
    List<BookInfo> bookInfo = await bvs.BookVendorService().loadBooks();
    List<Vendor> vendors = await bvs.BookVendorService().loadVendors();
    List<Author> authors = await AuthorService().loadAuthors();

    emit(state.clone(books: books, bookInfo: bookInfo,vendors: vendors, authors: authors,status: HomeStatus.loaded));
    
  }

  Future<void> _bookInfo(BookInfoEvent event, Emitter<HomeState> emit) async {
    BookWithVendor? booksInfo = await bvs.BookVendorService().getBookWithVendorById(event.vendorId);

    if (booksInfo != null) {
    await showModalBottomSheet(
  // ignore: use_build_context_synchronously
  context: event.context,
  isScrollControlled: true, // Allows full-screen-like behavior
  backgroundColor: Colors.white,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  ),
  builder: (context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8, // 80% of screen height
      minChildSize: 0.6, // Min height when dragged down
      maxChildSize: 0.95, // Max height when dragged up
      builder: (_, scrollController) {
        return BookBottomSheet(
          bookWithVendor: booksInfo, 
          scrollController: scrollController, // Pass scroll controller
        );
      },
    );
  },
);

    }
  }

}
