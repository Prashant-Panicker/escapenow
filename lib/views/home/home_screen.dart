import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:escapenow/components/build_image.dart';
import 'package:escapenow/components/custom_field.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:escapenow/controllers/home/home_controller.dart';
import 'package:escapenow/helpers/constants.dart';
import 'package:escapenow/views/home/search_option_screen.dart';
import 'package:escapenow/views/home/tour_details_screen.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.logut();
                            },
                            child: const Icon(Icons.exit_to_app),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: Get.width * 0.5,
                        child: CustomText(
                          text: "where_Do_you_want_go".tr,
                          maxLines: 3,
                          fontSize: 28,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(85),
                        child: GestureDetector(
                          onTap: () async =>
                              await Get.to(() => const SearchOptionScreen()),
                          child: CustomField(
                            enabled: false,
                            hint: "search_trip".tr,
                            fillColor: k_fieldGray,
                            radius: 85,
                            suffixIcon: Container(
                              margin: const EdgeInsets.all(10),
                              child: const CircleAvatar(
                                backgroundColor: k_primaryColor,
                                child:
                                    Icon(LineIcons.search, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: List.generate(
                            controller.places.length,
                            (index) {
                              return Expanded(
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    double fontSize = constraints.maxWidth /
                                        10.0; // Adjust the divisor as needed

                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color:
                                                controller.currentIndex == index
                                                    ? k_primaryColor
                                                    : Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.onChangePlace(
                                              controller.places[index], index);
                                        },
                                        child: Center(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: CustomText(
                                              text: controller.places[index],
                                              color: controller.currentIndex ==
                                                      index
                                                  ? k_primaryColor
                                                  : Colors.black,
                                              fontSize: fontSize,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 250,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.tours.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 20);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: GestureDetector(
                                onTap: () => Get.to(
                                  () => TourDetailsScreen(
                                    model: controller.tours[index],
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    BuildImage(
                                      image: controller.tours[index].image!,
                                      borderRadius: 25,
                                      width: 205,
                                      height: 250,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        width: Get.width,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black45,
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: controller
                                                      .tours[index].title!,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                CustomText(
                                                  text:
                                                      "${"Starting_at".tr} ${controller.tours[index].price!}",
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // SizedBox(height: 20),
                      // CustomText(
                      //   text: "Popular_Categories".tr,
                      //   fontWeight: FontWeight.bold,
                      //   fontSize: 17,
                      // ),
                      // SizedBox(height: 20),
                      // Container(
                      //   height: 100,
                      //   child: ListView.separated(
                      //     itemCount: controller.popularCategory.length,
                      //     scrollDirection: Axis.horizontal,
                      //     separatorBuilder: (BuildContext context, int index) {
                      //       return SizedBox(width: 40);
                      //     },
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Column(
                      //         children: [
                      //           ClipRRect(
                      //             borderRadius: BorderRadius.circular(30),
                      //             child: BuildImage(
                      //               image: controller
                      //                   .popularCategory[index].image!,
                      //               borderRadius: 30,
                      //               width: 60,
                      //               height: 60,
                      //             ),
                      //           ),
                      //           CustomText(
                      //               text: controller
                      //                   .popularCategory[index].name!),
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
