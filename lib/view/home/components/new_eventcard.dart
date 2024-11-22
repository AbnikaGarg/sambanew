import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sambanew/service/date_converter.dart';
import '../../../models/EventModel.dart';
import '../../../theme/apptheme.dart';
class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.events,
  });
  final Data events;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        border: Border.all(color: AppTheme.border, width: .8),
        borderRadius: BorderRadius.circular(22),
         boxShadow: [
          BoxShadow(
            color: Color(0x8C333335).withOpacity(0.1),
            offset: Offset(-1, -1),
            blurRadius: 12.0,
          ),
        ],
      ),
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   height: 120,
          //   width: 230,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(22),
          //           topRight: Radius.circular(22)),
          //       image: DecorationImage(
          //           fit: BoxFit.cover,
          //           image: AssetImage("assets/images/event4.png"))),
          // ),
          if (events.eventInfo!.eventBannerImage1 != null)
            CachedNetworkImage(
                imageUrl:
                    "${events.eventInfo!.eventBannerImagePath.toString()}${events.eventInfo!.eventBannerImage1.toString()}",
                imageBuilder: (context, imageProvider) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22)),
                    child: Image.network(
                      height: 120,
                      width: 240,
                      "${events.eventInfo!.eventBannerImagePath.toString()}${events.eventInfo!.eventBannerImage1.toString()}",
                      fit: BoxFit.cover,
                    ),
                  );
                },
                fadeInDuration: Duration(seconds: 1),
                placeholderFadeInDuration: Duration(seconds: 1),
                fadeInCurve: Curves.linear,
                fadeOutCurve: Curves.linear,
                fadeOutDuration: Duration(seconds: 1),

                // progressIndicatorBuilder: (context, url, progress) {
                //   return CircularProgressIndicator();
                // },

                placeholder: (
                  context,
                  url,
                ) =>
                    Shimmer.fromColors(
                      baseColor: Color.fromRGBO(63, 62, 62, 0.2),
                      highlightColor: Colors.black,
                      child: Container(
                          height: 120,
                          width: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(22),
                                topRight: Radius.circular(22)),
                            color: Colors.black54,
                          )),
                    ))
          else
            Container(
              height: 120,
              width: 230,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/event4.png"))),
            ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4,
                ),
                Text(
                    "${DateConverter.formatDate(DateTime.parse(events.eventInfo!.startDate.toString()))} at ${events.eventInfo!.startTime.toString()}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppTheme.primaryColor)),
                SizedBox(
                  height: 8,
                ),
                Text(events.eventInfo!.eventName.toString(),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 14)),
                SizedBox(
                  height: 8,
                ),
                Text(events.eventInfo!.venue.toString(),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Color(0XFF868686), fontSize: 12)),
                SizedBox(
                  height: 8,
                ),
                Text("by " + events.eventInfo!.vendorName.toString(),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 12)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppTheme.lightprimaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/ticket2.svg",
                              color: Get.theme.scaffoldBackgroundColor,
                              height: 16,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                "Tickets from ${events.eventInfo!.icon.toString()}${events.eventInfo!.ticketPriceOnward.toString()}",
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(fontSize: 10, color: AppTheme.darkTextColor)),
                          ],
                        ),
                        Container(
                          width: 68,
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x8C333335).withOpacity(0.1),
                                  offset: Offset(1, 1),
                                  blurRadius: 4.0,
                                  spreadRadius: 2),
                            ],
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Text(
                            "GETTICKETS".tr,
                            style: GoogleFonts.inter(
                                fontSize: 7,
                                color: AppTheme.whiteBackgroundColor,
                                fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
