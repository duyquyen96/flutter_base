import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprint/common/utils/spacing.dart';
import 'package:sprint/res/app_styles.dart';
import 'package:sprint/res/colors.dart';
import 'package:sprint/widgets/base_text.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.title,
    this.isRightRadius = false,
    this.isLeftRadius = false,
    this.press,
    this.bgColor,
    this.titleColor = AppColors.WHITE,
    this.height,
    this.textSize,
    this.isUpperCase = true,
  });

  final bool isRightRadius, isLeftRadius, isUpperCase;
  final String title;
  final void Function()? press;
  final List<Color>? bgColor;
  final Color titleColor;
  final double? height;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    final height = this.height ?? Spacing.buttonHeight;
    return InkWell(
      onTap: press,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: bgColor ??
                  (isLeftRadius
                      ? [
                          AppColors.primary,
                          AppColors.primary,
                        ]
                      : [
                          AppColors.primary,
                          AppColors.primary,
                        ]),
            )),
        child: Center(
          child: AppText(
            isUpperCase ? title.toUpperCase() : title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.DEFAULT_16.copyWith(
                fontWeight: FontWeight.w500,
                color: titleColor,
                height: 1.2,
                fontSize: textSize ?? 16.sp),
          ),
        ),
      ),
    );
  }
}

class CBottomButton extends StatelessWidget {
  const CBottomButton({
    super.key,
    required this.title,
    this.isRightRadius = false,
    this.isLeftRadius = false,
    this.press,
    this.bgColor,
    this.titleColor = AppColors.WHITE,
    this.height,
    this.isUpperCase = true,
  });

  final bool isRightRadius, isLeftRadius, isUpperCase;
  final String title;
  final void Function()? press;
  final List<Color>? bgColor;
  final Color titleColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: Spacing.paddingHorizontal,
            right: Spacing.paddingHorizontal,
            bottom: Spacing.bottom + 8.sp,
            top: 8.sp),
        child: BaseButton(
          title: title,
          bgColor: bgColor,
          height: height,
          isLeftRadius: isLeftRadius,
          isRightRadius: isRightRadius,
          isUpperCase: isUpperCase,
          press: press,
          titleColor: titleColor,
        ));
  }
}
