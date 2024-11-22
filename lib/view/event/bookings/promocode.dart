import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sambanew/controller/eventController.dart';
import 'package:sambanew/controller/ticketsController.dart';
import 'package:sambanew/models/PromoCode.dart';
import 'package:sambanew/theme/apptheme.dart';
import '../../../components/expandedText.dart';
import '../../../components/input_field.dart';
import '../../../service/date_converter.dart';
import 'components/event_header.dart';

class PromoCodePage extends StatefulWidget {
  PromoCodePage({super.key});

  @override
  State<PromoCodePage> createState() => _PromoCodePageState();
}

class _PromoCodePageState extends State<PromoCodePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Get.find<TicketController>().getPromo(
        Get.find<Eventcontroller>().eventData.first.eventInfo!.eventId);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;

    final events = Get.find<Eventcontroller>().eventData;
    return GetBuilder<TicketController>(builder: (controller) {
      return !controller.isLoadedPromos
          ? Scaffold(
              body: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(50)
                  ),
                 width: 80,
                  height: 80,
                  child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/preloader.gif',
                        ),
                      ),
                ),
              ),
            )
          : Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height + 20.h,
                    ),
                    HeaderEvent(
                      title: events.first.eventInfo!.eventName!,
                      ontap: () {
                        Get.back();
                      },
                      date:
                          "${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.startDate.toString()))} at ${events.first.eventInfo!.startTime.toString()} - ${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.endDate.toString()))} at ${events.first.eventInfo!.endTime.toString()}",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Got a promocode?",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              textEditingController: controller.promoController,
                                hintText: "Enter your promocode here..",
                                color: const Color(0xff585A60)),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppTheme.primaryColor),
                                borderRadius: BorderRadius.circular(12)),
                            child: InkWell(
                              onTap: () {
                                controller.applied(controller.promoController.text,events.first.eventInfo!.eventId);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Text("Apply"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if (controller.promoCodeList.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        primary: false,
                        itemCount: controller.promoCodeList.first.data!.length,
                        itemBuilder: (ctx, index) => Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: PromoCard(
                              promo:
                                  controller.promoCodeList.first.data![index],
                              apply: () {
                                controller.applied(
                                    controller.promoCodeList.first.data![index]
                                        .promoCode,
                                    controller.promoCodeList.first.data![index]
                                        .eventId);
                              }),
                        ),
                      ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            );
    });
  }
}

class PromoCard extends StatelessWidget {
  final VoidCallback apply;
  PromoCard({
    super.key,
    required this.promo,
    required this.apply,
  });
  final Data promo;

  @override
  Widget build(BuildContext context) {
    TextStyle smallText = Theme.of(context).textTheme.headlineSmall!;
    TextStyle headingText =
        Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13);
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
          border: Border.all(width: 0.26),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promo.promoCode.toString(),
                      style: headingText,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      promo.promoName.toString(),
                      style: smallText,
                    ),
                  ]),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: apply,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primaryColor),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    "Apply",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
