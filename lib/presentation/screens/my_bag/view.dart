import 'package:book_heaven/presentation/resources/color_manager.dart';
import 'package:book_heaven/presentation/screens/my_bag/bloc.dart';
import 'package:book_heaven/presentation/screens/my_bag/event.dart';
import 'package:book_heaven/presentation/screens/my_bag/state.dart';
import 'package:book_heaven/ui_components/appbar_com.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..add(InitEvent()),
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          return _buildPage(context, state);
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context, CartState state) {
    switch (state.status) {
      case CartStatus.initial:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case CartStatus.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case CartStatus.loaded:
        return Page(state: state);
      default:
        return const Scaffold(body: Center(child: Text("Cart Error")));
    }
  }
}

class Page extends StatefulWidget {
  final CartState state;
  const Page({super.key, required this.state});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;

    double subtotal = widget.state.items
        .fold(0, (sum, item) => sum + (item.bookPrice * item.quantity));
    double shipping = 2.00;
    double totalPayment = subtotal + shipping;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(scWidth, 60),
        child: const CustomAppBar(
          title: "My Bag",
        ),
      ),
      body: (widget.state.items.isEmpty)
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "There are no books in your cart",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Book List
                    ListView.separated(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable inner scrolling
                      itemCount: widget.state.items.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: ColorManager.signInBorder,
                      ),
                      itemBuilder: (context, index) {
                        final item = widget.state.items[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //  Book Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  item.imagePath,
                                  width: 65,
                                  height: 65,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),

                              //  Book Name & Price
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item.bookName,
                                      style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorManager
                                            .increaseDescreseContColor,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          _quantityButton(Icons.remove, () {
                                            context.read<CartBloc>().add(
                                                DecreaseQuantityEvent(
                                                    item.id ?? 0));
                                          }),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              item.quantity.toString(),
                                              style: GoogleFonts.openSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          _quantityButton(Icons.add, () {
                                            context.read<CartBloc>().add(
                                                IncreaseQuantityEvent(
                                                    item.id ?? 0));
                                          }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 16),

                              //  Price & Remove Button
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${(item.bookPrice * item.quantity).toStringAsFixed(2)}",
                                    style: TextStyle(
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<CartBloc>()
                                          .add(RemoveItemEvent(item.id ?? 0));
                                    },
                                    child: Text(
                                      "Remove",
                                      style: GoogleFonts.openSans(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    //  Summary Section
                    const SizedBox(height: 12),
                    Divider(height: 1, color: ColorManager.signInBorder),
                    const SizedBox(height: 20),

                    //  Book Name & Price List
                    Column(
                      children: widget.state.items.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.bookName,
                                style: GoogleFonts.openSans(fontSize: 14),
                              ),
                              Text(
                                "\$${(item.bookPrice * item.quantity).toStringAsFixed(2)}",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    Divider(height: 1, color: ColorManager.signInBorder),
                    const SizedBox(height: 20),
                    _summaryRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
                    const SizedBox(height: 20),
                    Divider(height: 1, color: ColorManager.signInBorder),
                    const SizedBox(height: 20),
                    _summaryRow("Shipping", "\$${shipping.toStringAsFixed(2)}"),
                    const SizedBox(height: 20),
                    Divider(height: 1, color: ColorManager.signInBorder),
                    const SizedBox(height: 20),
                    _summaryRow(
                        "Total Payment", "\$${totalPayment.toStringAsFixed(2)}",
                        isTotal: true),
                    const SizedBox(height: 40),

                    //  Pay Now Button
                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Book Ordered successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.greenAccent);
                        },
                        borderRadius:
                            BorderRadius.circular(48), // Ripple effect rounded
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: ColorManager.primary, // Button color
                            borderRadius: BorderRadius.circular(48),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Pay Now",
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget _summaryRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              fontSize: isTotal ? 16 : 14),
        ),
        Text(
          value,
          style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? ColorManager.primary : Colors.black),
        ),
      ],
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorManager.primary,
        ),
        child: Icon(icon, color: ColorManager.white, size: 20),
      ),
    );
  }
}
