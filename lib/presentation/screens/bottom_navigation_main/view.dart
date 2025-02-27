import 'package:book_heaven/gen/assets.gen.dart';
import 'package:book_heaven/presentation/resources/color_manager.dart';
import 'package:book_heaven/presentation/screens/bottom_navigation_main/bloc.dart';
import 'package:book_heaven/presentation/screens/bottom_navigation_main/event.dart';
import 'package:book_heaven/presentation/screens/bottom_navigation_main/state.dart';
import 'package:book_heaven/presentation/screens/home/view.dart';
import 'package:book_heaven/presentation/screens/my_bag/view.dart';
import 'package:book_heaven/presentation/screens/profile/view.dart';
import 'package:book_heaven/ui_components/commingSoon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainBottomNavigationPage extends StatelessWidget {
  const MainBottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBottomNavigationBloc()..add(InitEvent()),
      child: BlocConsumer<MainBottomNavigationBloc, MainBottomNavigationState>(
        listener: (context, state) {
          switch (state.status) {
            case MainBottomNavigationStatus.initial:
              break;
            case MainBottomNavigationStatus.loading:
              break;
            case MainBottomNavigationStatus.loaded:
              break;
            case MainBottomNavigationStatus.error:
              break;
            case null:
          }
        },
        builder: (context, state) {
          return _buildPage(context, state);
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context, MainBottomNavigationState state) {
    switch (state.status) {
      case MainBottomNavigationStatus.initial:
        return const Scaffold(
          body:  Center(child: CircularProgressIndicator()),
        );
      case MainBottomNavigationStatus.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case MainBottomNavigationStatus.loaded:
        return Page(
          state: state,
        );
      default:
        return const Scaffold(
          body: Center(child: Text("MainBottomNavigation default")),
        );
    }
  }
}

class Page extends StatefulWidget {
  final MainBottomNavigationState state;

  const Page({super.key, required this.state});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  // Define pages
  final List<Widget> _pages = const [
    HomePage(),
    ComingSoonWidget(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.state.selectedIndex ?? 0],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorManager.backgroundBottomNavigation,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.state.selectedIndex ?? 0,
          onTap: (index) {
            context.read<MainBottomNavigationBloc>().add(SelectTabEvent(index));
          },
          selectedItemColor: ColorManager.bottomNavigationSelectionColor,
          unselectedItemColor: ColorManager.grey,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.images.bottomNvIcons.home,
                colorFilter: ColorFilter.mode(
                    widget.state.selectedIndex == 0
                        ? ColorManager.bottomNavigationSelectionColor
                        : ColorManager.grey,
                    BlendMode.srcIn),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.images.bottomNvIcons.category,
                colorFilter: ColorFilter.mode(
                    widget.state.selectedIndex == 1
                        ? ColorManager.bottomNavigationSelectionColor
                        : ColorManager.grey,
                    BlendMode.srcIn),
              ),
              label: "Category",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.images.bottomNvIcons.cart,
                colorFilter: ColorFilter.mode(
                    widget.state.selectedIndex == 2
                        ? ColorManager.bottomNavigationSelectionColor
                        : ColorManager.grey,
                    BlendMode.srcIn),
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.images.bottomNvIcons.profile,
                colorFilter: ColorFilter.mode(
                    widget.state.selectedIndex == 3
                        ? ColorManager.bottomNavigationSelectionColor
                        : ColorManager.grey,
                    BlendMode.srcIn),
              ),
              label: "Profile",
            ),
          ]),
    );
  }
}
