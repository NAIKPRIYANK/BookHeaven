import 'package:book_heaven/database/sqflite_database_service.dart';
import 'package:book_heaven/gen/assets.gen.dart';
import 'package:book_heaven/models/bagbook_model.dart';
import 'package:book_heaven/presentation/resources/color_manager.dart';
import 'package:book_heaven/presentation/resources/font_manager.dart';
import 'package:book_heaven/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book_with_vendor_model.dart';

class BookBottomSheet extends StatefulWidget {
  final BookWithVendor bookWithVendor;
  final ScrollController scrollController; // Add this

  const BookBottomSheet({
    super.key,
    required this.bookWithVendor,
    required this.scrollController,
  });

  @override
  State<BookBottomSheet> createState() => _BookBottomSheetState();
}

class _BookBottomSheetState extends State<BookBottomSheet> {
  int quantity = 1;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.bookWithVendor.book.price;
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
      totalPrice = widget.bookWithVendor.book.price * quantity;
    });
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        totalPrice = widget.bookWithVendor.book.price * quantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController, // Enables smooth scrolling
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Book Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 300,
                  child: Image.asset(
                    widget.bookWithVendor.book.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            // Book Title & Like Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.bookWithVendor.book.title,
                  style: const TextStyle(
                    fontSize: FontSize.s20,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                SvgPicture.asset(
                  Assets.images.bottomNavigation.likeIcon,
                  width: 24,
                  height: 24,
                ),
              ],
            ),

            // Vendor Image
            Image.asset(
              widget.bookWithVendor.vendor.image,
              // Adjust height
              fit: BoxFit.cover, // Ensures the image fills the space properly
            ),

            // Book Description
            Text(
              widget.bookWithVendor.book.description,
              style: TextStyle(
                color: ColorManager.lightGrey,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
              ),
            ),

            const SizedBox(height: 10),
            // Review Section
            const Text(
              "Review",
              style: TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                for (int i = 0; i < 4; i++)
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                const Icon(Icons.star_half, color: Colors.amber, size: 20),
                const SizedBox(width: 5),
                const Text(
                  "(4.0)",
                  style: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Text(
              widget.bookWithVendor.book.availabilityStatus
                  ? "In Stock"
                  : "Out of stock",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.bookWithVendor.book.availabilityStatus
                    ? Colors.green
                    : Colors.red, // Change to ColorManager if needed
              ),
            ),

            const SizedBox(height: 10),

            // Quantity & Total Price
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // height: 40,
                  // width: 106,
                  // padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: ColorManager.backgroundBottomNavigation,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _decreaseQuantity,
                        icon: const Icon(Icons.remove_circle_outline, size: 24),
                      ),
                      Text(
                        "$quantity",
                        style: const TextStyle(
                          fontSize: FontSize.s18,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: _increaseQuantity,
                        icon: const Icon(Icons.add_circle_outline, size: 24),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Total Price Display
                Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.bottomNavigationSelectionColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(48),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final userId = prefs.getInt("userId");
                      if (widget.bookWithVendor.book.availabilityStatus) {
                        BagBookModel bagBookModel = BagBookModel(
                            userId: userId ?? 0,
                            bookName: widget.bookWithVendor.book.title,
                            bookPrice: widget.bookWithVendor.book.price,
                            quantity: quantity,
                            description: widget.bookWithVendor.book.description,
                            imagePath: widget.bookWithVendor.book.imagePath);

                        int result = await DatabaseHelper.instance
                            .addBookToBag(bagBookModel);

                        if (result > 0) {
                          // ✅ Show Flutter toast message
                          Fluttertoast.showToast(
                            msg: "Book added successfully!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          // ✅ Show error toast if not added
                          Fluttertoast.showToast(
                            msg: "Failed to add book. Try again!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Once book in stock we will notify you..",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }

                      // Add to Bag Action
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        color: ColorManager.bottomNavigationSelectionColor,
                      ),
                      child: Text(
                        widget.bookWithVendor.book.availabilityStatus
                            ? "Add to bag"
                            : "Notify me",
                        style: TextStyle(
                          fontSize: FontSize.s18,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(48),
                    onTap: () {
                      Fluttertoast.showToast(
                        msg: AppStrings.commingSoon,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.orange,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    },
                    child:widget.bookWithVendor.book.availabilityStatus? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        color: ColorManager.white,
                        border: Border.all(
                          color: ColorManager.bottomNavigationSelectionColor,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "Buy Now",
                        style: TextStyle(
                          fontSize: FontSize.s18,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.bottomNavigationSelectionColor,
                        ),
                      ),
                    ):Container(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
