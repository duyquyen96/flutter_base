import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Spacing {
  Spacing._();
  static final MediaQueryData mediaQueryData =
      MediaQueryData.fromView(WidgetsBinding.instance.window);
  static final EdgeInsets viewPadding = mediaQueryData.viewPadding;
  static final double paddingHorizontal = 16.sp;
  static final double headerHeight = 56.sp;
  static final double inputHeight = 48.sp;
  static final double buttonHeight = 48.sp;
  static final double bottom = viewPadding.bottom;
  static final double top = viewPadding.top;

  static final double realHeaderHeight = viewPadding.top + headerHeight;
  static final double width = mediaQueryData.size.width;
  static final double height = mediaQueryData.size.height;
}
