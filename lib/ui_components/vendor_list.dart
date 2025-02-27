import 'package:book_heaven/models/vendor_model.dart';
import 'package:flutter/material.dart';

class VendorHorizontalList extends StatelessWidget {
  final List<Vendor> vendors;

  const VendorHorizontalList({super.key, required this.vendors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, // Set height for uniform vendor card size
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          return _buildVendorCard(vendors[index]);
        },
      ),
    );
  }

  Widget _buildVendorCard(Vendor vendor) {
    return Container(
      width: 80, // Uniform width for each vendor
      height: 80, // Uniform height for each vendor
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Change to ColorManager if required
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          vendor.image,
          fit: BoxFit.contain, // Ensures image fits inside without distortion
        ),
      ),
    );
  }
}
