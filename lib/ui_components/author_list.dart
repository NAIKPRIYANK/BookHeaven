import 'package:book_heaven/models/authors_info_model.dart';
import 'package:flutter/material.dart';

class AuthorList extends StatelessWidget {
  final List<Author> authors;

  const AuthorList({super.key, required this.authors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: authors.length,
        itemBuilder: (context, index) {
          return _buildAuthorCard(authors[index]);
        },
      ),
    );
  }

  Widget _buildAuthorCard(Author author) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              author.image,
              height: 102,
              width: 102,
              fit: BoxFit.cover, // Ensures image fills the space properly
            ),
          ),
          const SizedBox(height: 8),
          Text(
            author.name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Text(
            author.work, // Assuming `work` field exists in Author model
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
