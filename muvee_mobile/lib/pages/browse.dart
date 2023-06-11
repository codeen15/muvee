import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/loading.dart';
import '../components/text_form_field.dart';
import '../configs/colors.dart';
import '../models/show.dart';
import '../services/show_service.dart';
import 'view_show.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  final TextEditingController _searchController = TextEditingController();

  final FocusNode _searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowService>(
      builder: (context, showService, child) {
        List<Show> shows = showService.shows;
        bool isSearching = showService.isSearching;
        bool isNotFound = showService.isNotFound;

        return Padding(
          padding: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
            top: 2.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Browse',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: quaternaryColor,
                ),
              ),
              SizedBox(height: 1.h),
              MvTextFormField(
                hintText: 'Search',
                controller: _searchController,
                focusNode: _searchFocus,
                onChanged: (text) {
                  if (text.isEmpty) {
                    FocusScope.of(context).unfocus();
                    showService.searchShow(query: text);
                  }
                },
                onFieldSubmitted: (text) {
                  FocusScope.of(context).unfocus();
                  showService.searchShow(query: text);
                },
                suffixIcon: IconButton(
                  icon: LineIcon(LineIcons.search),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    showService.searchShow(query: _searchController.text);
                  },
                ),
              ),
              SizedBox(height: 1.5.h),
              Expanded(
                child: isSearching
                    ? const Loading()
                    : isNotFound
                        ? Center(
                            child: SizedBox(
                              width: 50.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/notfound.png',
                                    color: Colors.white24,
                                    width: 15.w,
                                  ),
                                  SizedBox(height: 1.5.h),
                                  const Text(
                                    'Sorry, we can not found the shows related to your search',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : shows.isEmpty
                            ? Center(
                                child: SizedBox(
                                  width: 50.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/camera.png',
                                        color: Colors.white24,
                                        width: 15.w,
                                      ),
                                      SizedBox(height: 1.5.h),
                                      const Text(
                                        'Browse movies or shows to start adding to your list',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : GridView.builder(
                                itemCount: shows.length,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.only(bottom: 2.h),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 1.h,
                                  crossAxisSpacing: 3.w,
                                  mainAxisExtent: 30.8.h,
                                ),
                                itemBuilder: (context, index) {
                                  Show show = shows[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewShowPage(show: show),
                                        ),
                                      );
                                    },
                                    child: Material(
                                      elevation: 5,
                                      child: Container(
                                        height: 100.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: quaternaryColor,
                                              blurRadius: 0.5.sp,
                                              spreadRadius: 0.5.sp,
                                              blurStyle: BlurStyle.outer,
                                              offset: const Offset(1, 1),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            show.imageURL == null
                                                ? Expanded(
                                                    child: Container(
                                                      color: Colors.white12,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 15.w,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/noimage.png',
                                                        color: Colors.white24,
                                                      ),
                                                    ),
                                                  )
                                                : Image.network(
                                                    show.imageURL.toString(),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
              ),
            ],
          ),
        );
      },
    );
  }
}
