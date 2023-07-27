import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprint/common/utils/spacing.dart';
import 'package:sprint/res/app_styles.dart';
import 'package:sprint/res/colors.dart';

class BaseInput extends StatelessWidget {
  const BaseInput({
    super.key,
    required this.textEditingController,
    this.hintText,
    this.rightWidget,
    this.obscureText = false,
    this.keyboardType,
    this.height,
    this.fontSize,
    this.focusNode,
    this.onEditingComplete,
    this.onChanged,
    this.contentPadding,
  });

  final String? hintText;
  final TextEditingController textEditingController;
  final Widget? rightWidget;
  final bool obscureText;
  final TextInputType? keyboardType;
  final double? height, fontSize;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final void Function(String text)? onChanged;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Spacing.inputHeight,
      decoration: BoxDecoration(
          color: AppColors.grayF5,
          // border: Border.all(color: AppColors.gray777),
          borderRadius: BorderRadius.circular(10.sp)
          // borderRadius: BorderRadius.circular(Spacing.inputHeight / 2)
          ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onEditingComplete: onEditingComplete,
              onChanged: onChanged,
              focusNode: focusNode,
              keyboardType: keyboardType,
              obscureText: obscureText,
              controller: textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                isDense: true,
                hintStyle: AppStyle.DEFAULT_16.copyWith(
                    fontSize: fontSize ?? 16.sp,
                    color: AppColors.gray313131,
                    fontWeight: FontWeight.w300,
                    height: 1.3),
                contentPadding: contentPadding ??
                    EdgeInsets.only(
                        left: Spacing.paddingHorizontal,
                        right: rightWidget == null
                            ? Spacing.paddingHorizontal
                            : 0),
              ),
              style: AppStyle.DEFAULT_16.copyWith(
                  fontSize: fontSize ?? 16.sp,
                  fontWeight: FontWeight.w300,
                  height: 1.3),
            ),
          ),
          if (rightWidget != null) rightWidget!
        ],
      ),
    );
  }
}
