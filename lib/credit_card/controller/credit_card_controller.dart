import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditCardController extends GetxController {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHoldersControler = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final RxString cardNumber = "".obs;
  final RxString cardHolder = "".obs;
  final RxString cvv = "".obs;
  final RxInt month = 0.obs;
  final RxInt year = 0.obs;
  final RxString cvvHolder = "".obs;

  final RxBool showFrontSide = true.obs;

  final FocusNode cvvFocusNode = FocusNode();

  @override
  void onInit() {
    cardNumberController.addListener(() {
      cardNumber.value = cardNumberController.text;
    });
    cardHoldersControler.addListener(() {
      cardHolder.value = cardHoldersControler.text;
    });
    cvvController.addListener(() {
      cvv.value = cvvController.text;
    });
    cvvFocusNode.addListener(() {
      if (cvvFocusNode.hasFocus) {
        showFrontSide.value = false;
      } else {
        showFrontSide.value = true;
      }
    });
    super.onInit();
  }
}
