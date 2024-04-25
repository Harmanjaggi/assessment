import 'package:assessment/credit_card/controller/credit_card_controller.dart';
import 'package:assessment/credit_card/widgets/credit_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreditCardPage extends StatelessWidget {
  const CreditCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: GetBuilder(
          init: CreditCardController(),
          builder: (controller) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 500,
                    height: 450,
                    margin: const EdgeInsets.only(bottom: 30),
                    padding: const EdgeInsets.fromLTRB(20, 124, 20, 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [BoxShadow()]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldTitle("Card Number"),
                        customTextFeild(
                          controller: controller.cardNumberController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                          ],
                        ),
                        const SizedBox(height: 20),
                        fieldTitle("Card Holder"),
                        customTextFeild(
                            controller: controller.cardHoldersControler),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  fieldTitle("Expiration Date"),
                                  customDropDown(
                                    selectedValue: controller.month,
                                    label: "Month",
                                    items: [for (int i = 1; i <= 12; i++) i],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: customDropDown(
                                selectedValue: controller.year,
                                label: "Year",
                                items: [for (int i = 2024; i <= 2100; i++) i],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  fieldTitle("CVV"),
                                  customTextFeild(
                                    controller: controller.cvvController,
                                    focusNode: controller.cvvFocusNode,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(3),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Submit'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 370),
                    child: Obx(() {
                      return CustomFlipContainer(
                        frontContainer: const CreditCardFronSide(),
                        backContainer: const CreditCardBackSide(),
                        showFrontSide: controller.showFrontSide.value,
                      );
                    }),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget customDropDown({
    required RxInt selectedValue,
    required String label,
    required List<int> items,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
          border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      )),
      child: Obx(() {
        return DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: selectedValue.value,
            hint: Text(label),
            isDense: true,
            isExpanded: true,
            items: [
              DropdownMenuItem(child: Text(label), value: 0, enabled: false),
              ...items.map((i) => DropdownMenuItem(value: i, child: Text("$i")))
            ],
            onChanged: (newValue) {
              if (newValue != null) {
                selectedValue.value = newValue;
              }
            },
          ),
        );
      }),
    );
  }

  Widget customTextFeild(
      {required TextEditingController controller,
      FocusNode? focusNode,
      List<TextInputFormatter>? inputFormatters}) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        contentPadding: EdgeInsets.all(16),
      ),
    );
  }

  Widget fieldTitle(String label) {
    return Text(label);
  }
}
