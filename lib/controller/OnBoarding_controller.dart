import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';

import '../model/OnBoarding_info.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      //go to home page
    } else
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo('assets/images/2.svg', 'Provides Data Security',
        'We provide security to your data any time  right from your mobile.'),
    OnboardingInfo('assets/images/3.svg', 'Daily Progress indicator',
        'We are maintain safety and We provide Daily progress indication.'),
    OnboardingInfo('assets/images/1.svg', 'Easy Onboard setup',
        'App is easy to setup to start right away.')
  ];
}