import 'package:book_heaven/models/book_info_model.dart';
import 'package:book_heaven/presentation/screens/home/bloc.dart';
import 'package:book_heaven/presentation/screens/home/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookHorizontalList extends StatelessWidget {
  final List<BookInfo> books;

  const BookHorizontalList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Ensures uniform height for all book cards
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          return _buildBookCard(books[index], context);
        },
      ),
    );
  }

  Widget _buildBookCard(BookInfo book, BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<HomeBloc>()
            .add(BookInfoEvent(vendorId: book.vendorId, context: context));
      },
      child: Container(
        width: 120, // Ensures uniform width for all book cards
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                book.imagePath,
                width: 100, // Ensures all images have the same width
                height: 120, // Ensures all images have the same height
                fit: BoxFit.cover, // Maintains aspect ratio without distortion
              ),
            ),
            const SizedBox(height: 5),
            Text(
              book.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // Prevents text overflow issues
            ),
            Text(
              book.availabilityStatus ? "In Stock" : "Out of stock",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: book.availabilityStatus
                    ? Colors.green
                    : Colors.red, // Change to ColorManager if needed
              ),
            ),
            Text(
              "\$${book.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Change to ColorManager if needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
