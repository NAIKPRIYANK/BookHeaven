import 'package:book_heaven/gen/assets.gen.dart';
import 'package:book_heaven/presentation/resources/color_manager.dart';
import 'package:book_heaven/presentation/resources/router/route_manager.dart';
import 'package:book_heaven/presentation/screens/onboarding/bloc.dart';
import 'package:book_heaven/presentation/screens/onboarding/event.dart';
import 'package:book_heaven/presentation/screens/onboarding/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc()..add(InitEvent()),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          switch (state.status) {
            case OnboardingStatus.initial:
              break;
            case OnboardingStatus.loading:
              break;
            case OnboardingStatus.loaded:
              break;
            case OnboardingStatus.error:
              break;
            // ignore: constant_pattern_never_matches_value_type
            case null:
          
          }
        },
        builder: (context, state) {
          return _buildPage(context, state);
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context, OnboardingState state) {
    switch (state.status) {
      case OnboardingStatus.initial:
        return const Scaffold(
          body: Center(child: Text("Initial__")),
        );
      case OnboardingStatus.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case OnboardingStatus.loaded:
        return Page(
          state: state,
        );
      default:
        return const Scaffold(
          body: Center(child: Text("Home default")),
        );
    }
  }
}

class Page extends StatefulWidget {
  final OnboardingState state;

  const Page({super.key, required this.state});

  @override
  // ignore: library_private_types_in_public_api
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        
          

            // SVG Image
            SvgPicture.asset(
              Assets.images.onboardingImages
                  .onboarding, // Replace with actual asset name
              height: 250, // Adjust size as needed
            ),

            // Title & Description
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Text(
                    "Your Bookish Soulmate Awaits",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      color: ColorManager.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
  children: [
    // Register Button
    SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.registerPage);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 327,
            height: 56,
            decoration: BoxDecoration(
              color: ColorManager.primary, // Button Color
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              "Register",
              style: GoogleFonts.openSans(
                color: ColorManager.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),

    const SizedBox(height: 10),

    // Login Button
    SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.loginPage);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 327,
            height: 56,
            decoration: BoxDecoration(
              color: ColorManager.loginButton, // Button Color
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              "Login",
              style: GoogleFonts.openSans(
                color: ColorManager.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  ],
)
,

            const SizedBox(height: 20),

            // Page Indicator
          ],
        ),
      ),
    );
  }

}
