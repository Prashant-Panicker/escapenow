import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:escapenow/components/alert_date.dart';
import 'package:escapenow/components/build_image.dart';
import 'package:escapenow/components/custom_button.dart';
import 'package:escapenow/components/custom_field.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:get/get.dart';
import 'package:escapenow/controllers/profile/add_card_controller.dart';
import 'package:escapenow/helpers/constants.dart';
import 'package:escapenow/helpers/enum_helper.dart';
import 'package:escapenow/helpers/validator_helper.dart';

class AddCardScreen extends GetWidget<AddCardController> {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Add New Card".tr,
          fontSize: 20,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GetBuilder<AddCardController>(
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            width: Get.width,
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: 200,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: Get.width * 0.75,
                              height: 60,
                              decoration: BoxDecoration(
                                color: k_primaryColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            width: Get.width,
                            height: 180,
                            decoration: BoxDecoration(
                              color: k_primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const BuildImage(
                                      image: "assets/images/wallet.png",
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.contain,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                CustomText(
                                  text: controller.cardNumber,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontSize: 18,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: "Card Holder".tr,
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                          CustomText(
                                            text: controller.holderName,
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const BuildImage(
                                      image: "assets/images/master_card.png",
                                      width: 50,
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomText(
                      text: "Enter Informaton".tr,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 15),
                    CustomText(
                      text: "Card Number".tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 5),
                    CustomField(
                      hint: "Card Number".tr,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return ValidatorHelper.instance.validator(
                            value: value, type: FieldType.cardNumber);
                      },
                      onChanged: controller.onChangeCardNumberField,
                      suffixIcon: const BuildImage(
                        image: "assets/images/master_card_small.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomText(
                      text: "Card Holder".tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 5),
                    CustomField(
                      hint: "Enter card holder name".tr,
                      validator: (value) {
                        return ValidatorHelper.instance.validator(
                            value: value, type: FieldType.cardHolder);
                      },
                      onChanged: controller.onChangeCardHolderField,
                      suffixIcon: const BuildImage(
                        image: "assets/images/master_card_small.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomText(
                      text: "Expiration Date".tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 5),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDate(
                                selectionMode:
                                    DateRangePickerSelectionMode.single,
                                DateRangeContoller:
                                    controller.dateRangePickerController,
                                onPressed: () {
                                  controller.onSelectedDate();
                                },
                              );
                            },
                          );
                        },
                        child: CustomField(
                          hint: controller.expirationDateFormat,
                          enabled: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomText(
                      text: "CVC".tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 5),
                    CustomField(
                      validator: (value) {
                        return ValidatorHelper.instance
                            .validator(value: value, type: FieldType.CVC);
                      },
                      hint: "0".tr,
                      onChanged: controller.onChangeCVCField,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Switch.adaptive(
                          activeColor: k_primaryColor,
                          value: controller.isDefaultCard,
                          onChanged: controller.onChangeSwitch,
                        ),
                        CustomText(text: "Mark as default card".tr),
                      ],
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      text: "Save".tr,
                      onPressed: controller.isLaoding
                          ? null
                          : () {
                              controller.onSubmit();
                            },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
