import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:escapenow/components/build_image.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:escapenow/helpers/constants.dart';
import 'package:escapenow/models/tour_model.dart';
import 'package:escapenow/views/home/tour_details_screen.dart';

class BuildSearchItem extends StatelessWidget {
  final TourModel model;
  const BuildSearchItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => TourDetailsScreen(model: model)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BuildImage(
              image: model.image!,
              height: 140,
              width: Get.width,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: model.title!, fontWeight: FontWeight.w600),
                CustomText(
                    text: "\$${model.price}", fontWeight: FontWeight.w600),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 65,
                    height: 25,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: k_primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
              CustomText(
                text: "per_person".tr,
                color: k_fontGray,
                fontSize: 14,
              ),
            ],
          )
        ],
      ),
    );
  }
}
