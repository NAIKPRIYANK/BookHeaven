import 'package:book_heaven/gen/assets.gen.dart';
import 'package:book_heaven/presentation/resources/color_manager.dart';
import 'package:book_heaven/presentation/screens/home/bloc.dart';
import 'package:book_heaven/presentation/screens/home/event.dart';
import 'package:book_heaven/presentation/screens/home/state.dart';
import 'package:book_heaven/ui_components/appbar_com.dart';
import 'package:book_heaven/ui_components/author_list.dart';
import 'package:book_heaven/ui_components/offer_book_card.dart';
import 'package:book_heaven/ui_components/see_all_widget.dart';
import 'package:book_heaven/ui_components/top_book_info.dart';
import 'package:book_heaven/ui_components/vendor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(InitEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          switch (state.status) {
            case HomeStatus.initial:
              break;
            case HomeStatus.loading:
              break;
            case HomeStatus.loaded:
              break;
            case HomeStatus.error:
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

  Widget _buildPage(BuildContext context, HomeState state) {
    switch (state.status) {
      case HomeStatus.initial:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      case HomeStatus.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case HomeStatus.loaded:
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
  final HomeState state;

  const Page({super.key, required this.state});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(scWidth, 60),
          child: CustomAppBar(
            onLeadingPressed: () {
              // context.read<LoginBloc>().add(BackEvent(context: context));
            },
            leadingIcon: SvgPicture.asset(Assets.images.homeImages.icons.searchIcon),
            title: "Home",
            actions: [
              SvgPicture.asset(
                        fit: BoxFit.fill,
                        Assets.images.homeImages.icons.notificationIcon),
            ],
          )),

        backgroundColor: ColorManager.white,
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
          
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
          

                //show offer book
                BookOfferSlider(
                  books: widget.state.books ?? [],
                ),

                //show top of week book
                const SectionHeader(
                  title: "Top of the week",
                ),
                BookHorizontalList(
                  books: widget.state.bookInfo ?? [],
                ),
                const SectionHeader(
                  title: "Best Vendors",
                ),
                VendorHorizontalList(
                  vendors: widget.state.vendors ?? [],
                ),
                const SectionHeader(title: "Authors"),
                AuthorList(authors: widget.state.authors ?? []),
                
              ],
            ),
          ),
        ));

   

  }
}
