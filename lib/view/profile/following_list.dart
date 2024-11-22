import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sambanew/models/EventLikeModel.dart';

import '../../controller/homeController.dart';
import '../../models/EventModel.dart';
import '../../service/date_converter.dart';
import '../../theme/apptheme.dart';
import '../../util/config.dart';
import '../event/vendor_details.dart';

class FollowingList extends StatelessWidget {
  const FollowingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Get.theme.cardColor,
          centerTitle: true,
          title: Text(
            "Followings",
            style: Theme.of(context).textTheme.headlineMedium,
          )),
      body: GetBuilder<HomepageController>(builder: (controller) {
        return controller.isloadedVendors
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      if (controller.vndorFollwers.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: controller.vndorFollwers.length,
                          itemBuilder: (ctx, index) => InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                                    Get.toNamed("/vendorDeatils", arguments: {
                                      'vendorcode': controller
                                          .vndorFollwers[index].vendorCode
                                          .toString()
                                    });
                                  },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 6),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              "${controller.vndorFollwers[index].vendorLogoPath.toString()}${controller.vndorFollwers[index].vendorLogoImage.toString()}",
                                            )),
                                        borderRadius: BorderRadius.circular(12)),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.vndorFollwers[index].vendorName.toString()}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge!
                                                .copyWith(fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Organizer",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge!
                                                .copyWith(fontSize: 12),
                                          )
                                        ],
                                      )),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.bounceInOut,
                                    height: 36,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: controller.vndorFollwers[index]
                                                        .vendorfollowtag ==
                                                    0
                                                ? Colors.transparent
                                                : AppTheme.primaryColor,
                                        border: Border.all(
                                            width: 0.5,
                                            color: controller.vndorFollwers[index]
                                                        .vendorfollowtag ==
                                                    0
                                                ? Get.theme.canvasColor
                                                : AppTheme.primaryColor),
                                        //  boxShadow: [BoxShadow(offset: Offset(1, 1))],
                                        borderRadius: BorderRadius.circular(50)),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(50),
                                      onTap: () {
                                        controller.followVendor(
                                           controller.vndorFollwers[index].vendorId,
                                            controller.vndorFollwers[index]
                                                .vendorfollowtag);
                                      },
                                      child: Center(
                                          child: Text(
                                       controller.vndorFollwers[index].vendorfollowtag ==
                                                0
                                            ? "+ Follow"
                                            : "Following",
                                        style: TextStyle(
                                            color: AppTheme.whiteBackgroundColor,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      else
                        Center(
                          child: Container(
                            child: Text("no_records_found".tr),
                          ),
                        )
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator());
      }),
    );
  }
}
