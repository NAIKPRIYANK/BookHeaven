
import 'package:book_heaven/presentation/resources/color_manager.dart';
import 'package:book_heaven/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';


class AppBar2 extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? sub2title;
  final Icon? icon;
  final List<Widget>? action;
  final VoidCallback? onBackPressed;

  const AppBar2({
    super.key,
    this.title,
    this.subTitle,
    this.sub2title,
    this.icon,
    this.action,
    this.onBackPressed,
  });

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title!,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s14,
                        color: ColorManager.homeTextColor1)),
                // Image.asset(Assets.home.homeSun.path)
              ],
            ),
            Text(subTitle!,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s20 + 2.0,
                    color: ColorManager.homeTextColor2)),
            // SizedBox(height: 5,),
            Text(sub2title!,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s12,
                    color: ColorManager.homeTextColor2)),
          ],
        ),
      ),
      actions: action,
    
    );
  }
}
