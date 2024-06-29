import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Loader {
  static load() {
    Get.dialog(
      Center(
        child: Container(
          height: 100,
          width: 100,
          child: Lottie.asset('assets/Animation - 1719313033980.json'),
          //const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
