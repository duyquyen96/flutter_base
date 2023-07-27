import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sprint/common/utils/spacing.dart';
import 'package:sprint/features/authentication/controllers/login_controller.dart';
import 'package:sprint/features/authentication/controllers/verify_otp_controller.dart';
import 'package:sprint/widgets/base_button.dart';
import 'package:sprint/widgets/base_header.dart';
import 'package:sprint/widgets/base_input.dart';
import 'package:sprint/widgets/base_page.dart';
import 'package:sprint/widgets/base_text.dart';

import '../../../res/colors.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  VerifyController verifyController = VerifyController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppColors.WHITE,
      child: Column(children: [
        const BaseHeader(title: 'title'),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100.sp,
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: Spacing.paddingHorizontal),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.sp,
                      ),
                      PinCodeTextField(
                        appContext: context,
                        keyboardType: TextInputType.number,
                        textStyle: const TextStyle(color: AppColors.gray313131),
                        length: 6,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeColor: AppColors.BLACK,
                            selectedColor: AppColors.red,
                            inactiveColor: AppColors.grayF5),
                        onChanged: (value) {
                          print(value);
                          setState(() {});
                        },
                        onCompleted: ((value) {}),
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      Obx(() => AppText(verifyController.start.string)),
                      BaseButton(
                        title: 'Đăng nhập'.tr,
                        press: () {
                          if (verifyController.start == 0) {
                            verifyController.start = RxInt(10);
                          }
                          print('1');
                          verifyController.startTimer();
                        },
                      )
                    ],
                  )),
            ],
          ),
        ))
      ]),
    ));
  }
}
