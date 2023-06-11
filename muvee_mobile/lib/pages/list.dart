import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/loading.dart';
import '../configs/colors.dart';
import '../models/show.dart';
import '../services/towatch_service.dart';
import 'view_show.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToWatchService>(
      builder: (context, towatchService, child) {
        List<int>? showIDs = towatchService.toWatchIDs;

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
                'To-Watch List',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: quaternaryColor,
                ),
              ),
              SizedBox(height: 1.h),
              Expanded(
                child: showIDs == null
                    ? const Center(
                        child: Loading(),
                      )
                    : GridView.builder(
                        itemCount: showIDs.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 1.h,
                          crossAxisSpacing: 3.w,
                          mainAxisExtent: 30.8.h,
                        ),
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future:
                                towatchService.getShowByID(id: showIDs[index]),
                            builder: (context, AsyncSnapshot<Show?> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Loading();
                              }

                              if (!snapshot.hasData) {
                                return const SizedBox.shrink();
                              } else {
                                Show show = snapshot.data!;
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
                              }
                            },
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
