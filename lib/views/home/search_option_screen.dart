import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:escapenow/components/alert_date.dart';
import 'package:escapenow/components/custom_button.dart';

import 'package:escapenow/components/custom_field.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:escapenow/controllers/home/search_option_controller.dart';
import 'package:escapenow/controllers/home/search_results_controller.dart';
import 'package:escapenow/helpers/constants.dart';
import 'package:escapenow/helpers/enum_helper.dart';
import 'package:escapenow/views/home/search_results_screen.dart';

class SearchOptionScreen extends GetWidget<SearchOptionController> {
  const SearchOptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          text: "search_trips".tr,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        // leading: BuildArrowBackIcon(),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GetBuilder<SearchOptionController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: " ${"loc_trips".tr}",
                  color: k_fontGray,
                ),
                const SizedBox(height: 10),
                CustomField(
                  hint: "loc_trips".tr,
                  fillColor: k_fieldGray,
                  controller: controller.city,
                  prefixIcon: const Icon(LineIcons.search),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: " ${"start_date".tr}",
                            color: k_fontGray,
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDate(
                                      selectionMode:
                                          DateRangePickerSelectionMode.range,
                                      DateRangeContoller:
                                          controller.dateController,
                                      onPressed: () {
                                        controller.onSelectDate();
                                        controller.desplay();
                                      },
                                    );
                                  },
                                );
                              },
                              child: CustomField(
                                enabled: false,
                                hint: controller.checkIn.text,
                                fillColor: k_fieldGray,
                                prefixIcon: const Icon(LineIcons.calendar),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: " ${"return_date".tr}",
                            color: k_fontGray,
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDate(
                                      selectionMode:
                                          DateRangePickerSelectionMode.range,
                                      DateRangeContoller:
                                          controller.dateController,
                                      onPressed: () {
                                        controller.onSelectDate();
                                        controller.desplay();
                                      },
                                    );
                                  },
                                );
                              },
                              child: CustomField(
                                enabled: false,
                                hint: controller.checkOut.text,
                                fillColor: k_fieldGray,
                                prefixIcon: const Icon(LineIcons.calendar),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: _BuildItem(
                        title: " ${"adults".tr}",
                        count: controller.adult,
                        decreaseFunction: () =>
                            controller.decrease(CounterType.adult),
                        increaseFunction: () =>
                            controller.increase(CounterType.adult),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: CustomButton(
                        text: "Search".tr,
                        onPressed: () async {
                          Get.to(() => SearchResultsScreen(
                                city: controller.city.text,
                                checkIn: controller.checkInDateTime!,
                                checkOut: controller.checkOutDateTime!,
                              ));
                          Get.find<SearchResultsController>().searching(
                            city: controller.city.text,
                            checkIn: controller.checkInDateTime,
                            checkOut: controller.checkOutDateTime,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _BuildItem extends StatelessWidget {
  const _BuildItem({
    Key? key,
    this.increaseFunction,
    this.decreaseFunction,
    required this.title,
    required this.count,
  }) : super(key: key);
  final void Function()? increaseFunction;
  final void Function()? decreaseFunction;
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: k_fontGray,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: decreaseFunction,
              child: Container(
                width: 45,
                height: 49,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: k_fontGray,
                  ),
                ),
                child: const Icon(
                  Icons.remove,
                  color: k_primaryColor,
                  size: 20,
                ),
              ),
            ),
            CustomText(
              text: count.toString(),
              fontSize: 18,
            ),
            GestureDetector(
              onTap: increaseFunction,
              child: Container(
                width: 45,
                height: 49,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: k_fontGray,
                  ),
                ),
                child: const Icon(
                  LineIcons.plus,
                  color: k_primaryColor,
                  size: 20,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
