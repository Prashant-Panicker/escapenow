import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:escapenow/components/build_image.dart';
import 'package:escapenow/components/custom_button.dart';
import 'package:escapenow/components/custom_field.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:escapenow/controllers/profile/currency_converter_controller.dart';
import 'package:escapenow/helpers/constants.dart';

class CurrencyConverterScreen extends GetWidget<CurrencyConverterController> {
  const CurrencyConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Converter".tr,
          fontSize: 20,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GetBuilder<CurrencyConverterController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.hasError == true) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Error".tr,
                    fontSize: 25,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Refresh".tr,
                    onPressed: controller.onInit,
                    color: Colors.red,
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _BuildItem(
                        imagePath: "assets/images/USD.png",
                        text: "USD".tr,
                      ),
                      const BuildImage(
                        image: "assets/images/compair_arrows.png",
                        width: 19,
                        height: 19,
                      ),
                      _BuildItem(
                        imagePath: "assets/images/EUR.png",
                        text: "EUR".tr,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: k_primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "${controller.currencyModel!.conversionRates!.uSD} ${"USD".tr} = ${controller.currencyModel!.conversionRates!.eUR!.toStringAsFixed(3)} ${"EUR".tr}",
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: controller.formKey,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomField(
                            hint: "Enter amount".tr,
                            keyboardType: TextInputType.number,
                            controller: controller.amount,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter an amount".tr;
                              }
                              int? parseValue = int.tryParse(value.toString());
                              print(parseValue);
                              if (parseValue == null) {
                                return "Please enter a valid amount".tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: CustomButton(
                            text: "Convert".tr,
                            onPressed: () {
                              controller.convertAmount();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CustomText(text: "The result :".tr),
                      const SizedBox(width: 10),
                      CustomText(
                          text: "${controller.result.toStringAsFixed(2)} ${"EUR".tr}"),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(bottom: 15),
        width: Get.width,
        height: 63,
        child: CustomButton(
          text: "Continue".tr,
          onPressed: () {},
          radius: 0,
        ),
      ),
    );
  }
}

class _BuildItem extends StatelessWidget {
  const _BuildItem({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);
  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 135,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(3, 6),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: BuildImage(
                image: imagePath,
                width: 55,
                height: 55,
              ),
            ),
            const SizedBox(height: 10),
            CustomText(
              text: text,
              fontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
