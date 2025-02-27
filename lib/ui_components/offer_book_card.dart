
import 'package:book_heaven/models/book_offer_model.dart';
import 'package:book_heaven/presentation/resources/color_manager.dart';
import 'package:book_heaven/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BookOfferSlider extends StatefulWidget {
  final List<Book> books;

  const BookOfferSlider({super.key, required this.books});

  @override
  State<BookOfferSlider> createState() => _BookOfferSliderState();
}

class _BookOfferSliderState extends State<BookOfferSlider> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180, // Keeps the original height
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.books.length,
            itemBuilder: (context, index) {
              final book = widget.books[index];
              return _buildOfferCard(context, book);
            },
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.books.length,
          effect: ScrollingDotsEffect(
            activeDotColor: ColorManager.bottomNavigationSelectionColor,
            dotColor: Colors.grey.shade300,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildOfferCard(BuildContext context, Book book) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.9, // Prevents overflow
      height: 140, // Fixed height for consistency
      decoration: BoxDecoration(
        color: ColorManager.homeContainerBookOfferBackgorund,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          /// 📌 Text Section (Left Side)
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Special Offer",
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSize.s20,
                    ),
                  ),
                  Text(
                    "Discount ${book.discount}%",
                    style: const TextStyle(
                      fontWeight: FontWeightManager.regular,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 36,
                      width: 118,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorManager.bottomNavigationSelectionColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        "Order Now",
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 📌 Image Section (Right Side, Covers Full Height)
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: Image.asset(
                book.imagePath,
                height: double.infinity, // Ensures full height
                width: double.infinity, // Stretches to right
                fit: BoxFit.cover, // Covers the entire available space
              ),
            ),
          ),
        ],
      ),
    );
  }
}
