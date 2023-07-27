import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/utils/spacing.dart';
import '../res/colors.dart';
import 'base_button.dart';

class BaseCButtons extends StatelessWidget {
  const BaseCButtons({
    Key? key,
    this.leftTitle,
    this.rightTitle,
    this.leftTitleColor = AppColors.BLACK,
    this.rightTitleColor = AppColors.WHITE,
    this.bgColor = AppColors.d9d9d9,
    this.leftBgColor,
    this.rightBgColor,
    this.leftPress,
    this.showLeftButton = true,
    this.rightPress,
    this.height,
  }) : super(key: key);

  final String? rightTitle, leftTitle;
  final Color leftTitleColor, rightTitleColor, bgColor;
  final List<Color>? rightBgColor, leftBgColor;
  final void Function()? leftPress;
  final void Function()? rightPress;
  final bool showLeftButton;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final height = this.height ?? Spacing.buttonHeight;
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        color: bgColor,
        child: Row(
          children: [
            if (showLeftButton)
              Expanded(
                  child: BaseButton(
                height: height,
                title: leftTitle ?? 'Hủy'.tr,
                isRightRadius: true,
                titleColor: leftTitleColor,
                bgColor:
                    leftBgColor ?? [Colors.transparent, Colors.transparent],
                press: leftPress,
                isLeftRadius: false,
              )),
            Expanded(
                child: BaseButton(
              height: height,
              title: rightTitle ?? 'Đồng ý'.tr,
              isRightRadius: false,
              isLeftRadius: true,
              titleColor: rightTitleColor,
              bgColor: rightBgColor ??
                  (showLeftButton
                      ? [AppColors.linear1, AppColors.linear1]
                      : [AppColors.linear1, AppColors.linear1]),
              press: rightPress,
            ))
          ],
        ),
      ),
    );
  }
}
