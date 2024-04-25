import 'dart:math';

import 'package:assessment/credit_card/controller/credit_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditCardFronSide extends GetWidget<CreditCardController> {
  const CreditCardFronSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        width: 300,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Obx(() {
                return Text(
                  controller.cardNumber.value,
                  key: ValueKey<String>(controller.cardNumber.value),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: 'CourrierPrime'),
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Obx(() {
                  return _buildDetailsBlock(
                    label: 'CARDHOLDER',
                    value: controller.cardHolder.value,
                  );
                }),
                Obx(() {
                  // return _buildDetailsBlock(
                  //     label: 'VALID THRU',
                  //     value: '${controller.month}/${controller.year}');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'VALID THRU',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 9,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 200),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return SlideTransition(
                                child: child,
                                position: Tween<Offset>(
                                        begin: Offset(0.0, -0.5),
                                        end: Offset(0.0, 0.0))
                                    .animate(animation),
                              );
                            },
                            child: Text(
                              (controller.month.value == 0)
                                  ? "MM"
                                  : (controller.month < 10)
                                      ? '0${controller.month}'
                                      : '${controller.month}',
                              key:
                                  ValueKey<String>(controller.month.toString()),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            '/',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 200),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return SlideTransition(
                                child: child,
                                position: Tween<Offset>(
                                        begin: Offset(0.0, -0.5),
                                        end: Offset(0.0, 0.0))
                                    .animate(animation),
                              );
                            },
                            child: Text(
                              (controller.year.value == 0)
                                  ? "YYYY"
                                  : controller.year.toString(),
                              key: ValueKey<String>(controller.year.toString()),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/contact_less.png",
          height: 20,
          width: 18,
        ),
        Image.asset(
          "assets/images/mastercard.png",
          height: 50,
          width: 50,
        ),
      ],
    );
  }

  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.blueGrey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class CreditCardBackSide extends GetWidget<CreditCardController> {
  const CreditCardBackSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: SizedBox(
          height: 200,
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  "CVV",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 9,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Colors.white,
                height: 30,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                padding: EdgeInsets.all(8),
                alignment: Alignment.centerRight,
                child: Obx(() {
                  return Text(
                    '${controller.cvv.value.replaceAll(RegExp(r"."), "*")}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  );
                }),
              )
            ],
          ),
        ));
  }
}

class CustomFlipContainer extends StatefulWidget {
  const CustomFlipContainer({
    super.key,
    required this.frontContainer,
    required this.backContainer,
    required this.showFrontSide,
  });

  final Widget frontContainer;
  final Widget backContainer;
  final bool showFrontSide;

  @override
  State<CustomFlipContainer> createState() => _CustomFlipContainerState();
}

class _CustomFlipContainerState extends State<CustomFlipContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      transitionBuilder: (a, b) =>
          __transitionBuilder(a, b, widget.showFrontSide),
      layoutBuilder: (widget, list) =>
          Stack(children: [widget ?? Container(), ...list]),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeIn.flipped,
      child:
          widget.showFrontSide ? widget.frontContainer : widget.backContainer,
    );
  }

  Widget __transitionBuilder(
      Widget widget, Animation<double> animation, bool showFrontSide) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(showFrontSide) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= showFrontSide ? 1.0 : -1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
