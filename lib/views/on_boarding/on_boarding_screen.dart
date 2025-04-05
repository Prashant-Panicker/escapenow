import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:escapenow/components/custom_button.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:escapenow/helpers/catch_storage.dart';
import 'package:escapenow/helpers/constants.dart';
import 'package:escapenow/models/boarding_model.dart';
import 'package:get/get.dart';
import 'package:escapenow/views/auth/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController boardingController = PageController();
  int currentIndex = 0;

  final List<BoardingModel> items = [
    BoardingModel(
      title: "explore_destinations",
      subtitle: "explore_desc",
      image: "assets/images/mountain1.png",
    ),
    BoardingModel(
      title: "choose_destination",
      subtitle: "destination_desc",
      image: "assets/images/destination.png",
    ),
    BoardingModel(
      title: "fly_destination",
      subtitle: "fly_desc",
      image: "assets/images/travelling_earth.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics:
                const NeverScrollableScrollPhysics(), // Prevent outer scroll
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.2,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: boardingController,
                      itemCount: items.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.asset(
                              items[index].image,
                              width: constraints.maxWidth / 2,
                              height: constraints.maxHeight * 0.3,
                            ),
                            const SizedBox(height: 12),
                            CustomText(
                              text: items[index].title.tr,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: constraints.maxWidth / 1.5,
                              child: CustomText(
                                text: items[index].subtitle.tr,
                                fontSize: 16,
                                color: const Color(0xFFA5A7AC),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SmoothPageIndicator(
                    controller: boardingController,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: const ExpandingDotsEffect(
                      spacing: 8.0,
                      radius: 10,
                      dotWidth: 22.0,
                      dotHeight: 12.0,
                      paintStyle: PaintingStyle.fill,
                      strokeWidth: 1.5,
                      dotColor: Color(0xFFC4C4C4),
                      activeDotColor: k_primaryColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: "continue".tr,
                    onPressed: currentIndex == items.length - 1
                        ? () async {
                            await CatchStorage.save(k_onBoardingKey, true);
                            await Get.off(() => const LoginScreen());
                          }
                        : null,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
