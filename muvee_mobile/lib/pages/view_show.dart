import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/loading.dart';
import '../components/text_button.dart';
import '../configs/colors.dart';
import '../models/show.dart';
import '../services/towatch_service.dart';

class ViewShowPage extends StatefulWidget {
  const ViewShowPage({
    super.key,
    required this.show,
  });

  final Show show;

  @override
  State<ViewShowPage> createState() => _ViewShowPageState();
}

class _ViewShowPageState extends State<ViewShowPage> {
  late Show show;

  bool summaryExpanded = false;

  bool isAddingOrRemoving = false;

  @override
  void initState() {
    show = widget.show;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ToWatchService>(
      builder: (context, towatchService, child) {
        bool initiating = towatchService.toWatchIDs == null;
        if (initiating) return const Center(child: Loading());

        bool isInToWatch = towatchService.toWatchIDs!.contains(show.id);

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 28.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: 40.w,
                          child: show.imageURL == null
                              ? Container(
                                  color: Colors.white12,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                  ),
                                  child: Image.asset(
                                    'assets/images/noimage.png',
                                    color: Colors.white24,
                                  ),
                                )
                              : Image.network(
                                  show.imageURL.toString(),
                                  fit: BoxFit.scaleDown,
                                ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Container(
                            foregroundDecoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [
                                  0.96,
                                  1.0,
                                ],
                                colors: [
                                  Colors.transparent,
                                  Colors.black54,
                                ],
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    show.name.toString(),
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 1.5.h),
                                  infoWidget(
                                    label: 'Status',
                                    value: show.status.toString(),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  infoWidget(
                                    label: 'Show Type',
                                    value: show.type.toString(),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  infoWidget(
                                    label: 'Rating',
                                    value: '${show.rating} ★',
                                  ),
                                  SizedBox(height: 0.5.h),
                                  show.genres != null && show.genres!.isNotEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Genres: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 0.2.h),
                                            Wrap(
                                              spacing: 1.w,
                                              runSpacing: 0.5.h,
                                              children: [
                                                ...show.genres!
                                                    .map(
                                                      (genre) => Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 1.2.w,
                                                          vertical: 0.2.h,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              quaternaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.sp),
                                                        ),
                                                        child: Text(genre),
                                                      ),
                                                    )
                                                    .toList()
                                              ],
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                  SizedBox(height: 1.5.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  SizedBox(
                    width: 100.w,
                    child: isInToWatch
                        ? TextButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor: quaternaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.sp),
                                side: const BorderSide(
                                  color: quaternaryColor,
                                ),
                              ),
                            ),
                            icon: isAddingOrRemoving
                                ? SpinKitFadingCircle(
                                    size: 18.sp,
                                    color: Colors.white,
                                  )
                                : LineIcon(
                                    LineIcons.times,
                                    color: Colors.white,
                                  ),
                            onPressed: () async {
                              setState(() {
                                isAddingOrRemoving = true;
                              });

                              await towatchService.removeFromToWatch(
                                showID: show.id,
                              );

                              setState(() {
                                isAddingOrRemoving = false;
                              });
                            },
                            label: Text(
                              isAddingOrRemoving
                                  ? 'Removing'
                                  : 'Remove from To-Watch List',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : TextButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor: quaternaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.sp),
                                side: const BorderSide(
                                  color: quaternaryColor,
                                ),
                              ),
                            ),
                            icon: isAddingOrRemoving
                                ? SpinKitFadingCircle(
                                    size: 18.sp,
                                    color: Colors.white,
                                  )
                                : LineIcon(
                                    LineIcons.plus,
                                    color: Colors.white,
                                  ),
                            onPressed: () async {
                              setState(() {
                                isAddingOrRemoving = true;
                              });

                              await towatchService.addShowToToWatch(
                                showID: show.id,
                              );

                              setState(() {
                                isAddingOrRemoving = false;
                              });
                            },
                            label: Text(
                              isAddingOrRemoving
                                  ? 'Adding'
                                  : 'Add to To-Watch List',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MvTextButton(
                          label: 'Visit Website',
                          onPressed: () async {
                            String? url = show.websiteURL;

                            if (url != null) {
                              if (await canLaunchUrl(Uri.parse(url))) {
                                launchUrl(Uri.parse(url));
                              }
                            }
                          },
                          isOutlined: true,
                        ),
                      ),
                      SizedBox(width: 0.5.w),
                      IconButton(
                        onPressed: () {
                          Share.share(
                              'Check out this show! ${show.websiteURL}. Download Muvee now to explore vast shows directory and manage your to-watch list!');
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp),
                            side: const BorderSide(color: quaternaryColor),
                          ),
                        ),
                        icon: LineIcon(
                          LineIcons.share,
                          color: quaternaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  show.summary != null
                      ? Builder(builder: (context) {
                          String summary = show.summary!.replaceAll(
                            RegExp(r"<[^>]*>",
                                multiLine: true, caseSensitive: true),
                            '',
                          );
                          bool isBelow150 = summary.length < 150;

                          return Stack(
                            children: [
                              Text(
                                isBelow150
                                    ? summary
                                    : '${summary.substring(0, summaryExpanded ? null : 150)}${summaryExpanded ? '' : '...'}\n',
                                maxLines: summaryExpanded ? null : 4,
                                softWrap: true,
                              ),
                              isBelow150 == false
                                  ? Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            summaryExpanded = !summaryExpanded;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                          ),
                                          child: Text(
                                            summaryExpanded
                                                ? 'Less'
                                                : 'Read More...',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: quaternaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          );
                        })
                      : const SizedBox.shrink(),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row infoWidget({required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(value.toString()),
      ],
    );
  }
}
