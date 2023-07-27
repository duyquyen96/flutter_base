import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint/common/utils/spacing.dart';

void showModal(Widget child, {bool isDismiss = false}) {
  showDialog(
      context: Get.context!,
      useSafeArea: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(children: [
              GestureDetector(
                onTap: () {
                  if (isDismiss) Get.back();
                },
                child: Container(
                  width: Spacing.width,
                  height: Spacing.height,
                  color: Colors.transparent,
                ),
              ),
              Column(
                children: [
                  const Spacer(),
                  Center(
                    child: child,
                  ),
                  const Spacer(),
                ],
              )
            ]),
          ),
        );
      });
}
