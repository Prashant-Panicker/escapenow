import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:escapenow/components/build_search_item.dart';
import 'package:escapenow/components/custom_field.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:escapenow/controllers/home/search_results_controller.dart';
import 'package:escapenow/helpers/constants.dart';

// ignore: must_be_immutable
class SearchResultsScreen extends GetWidget<SearchResultsController> {
  SearchResultsScreen({
    required this.city,
    required this.checkIn,
    required this.checkOut,
    Key? key,
  }) : super(key: key);
  String? city;
  final DateTime checkIn;
  final DateTime checkOut;
  final String patternOfDateTime = "d MMM";

  String get textOfSearchBox {
    city ??= "";
    return "${city!} ${DateFormat(patternOfDateTime).format(checkIn)} , ${DateFormat(patternOfDateTime).format(checkOut)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          text: "Hotels".tr,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: CustomField(
                      enabled: true,
                      hint: textOfSearchBox,
                      fillColor: k_primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<SearchResultsController>(
              builder: ((controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.results.isEmpty) {
                  return Center(
                    child: CustomText(
                      text: "empty_result".tr,
                      fontSize: 30,
                    ),
                  );
                }

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    itemCount: controller.results.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 20);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return BuildSearchItem(model: controller.results[index]);
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
