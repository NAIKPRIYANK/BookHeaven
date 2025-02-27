import 'package:book_heaven/presentation/resources/color_manager.dart';
import 'package:book_heaven/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:const TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold
          )
        ),
        Text(
          "See all",
          style: TextStyle(
            fontSize: FontSize.s14,
            color: ColorManager.bottomNavigationSelectionColor
          )
        ),
      ],
    );
  }
}
