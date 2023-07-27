import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprint/common/utils/spacing.dart';
import 'package:sprint/features/authentication/controllers/login_controller.dart';
import 'package:sprint/widgets/base_button.dart';
import 'package:sprint/widgets/base_header.dart';
import 'package:sprint/widgets/base_input.dart';
import 'package:sprint/widgets/base_page.dart';

import '../../../res/colors.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  LoginController loginController = LoginController();

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
                      BaseInput(
                        textEditingController: username,
                        hintText: 'Email hoặc số điện thoại'.tr,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      BaseInput(
                        textEditingController: password,
                        hintText: 'Mật khẩu'.tr,
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      BaseButton(
                        title: 'Đăng nhập'.tr,
                        press: () => {loginController.signIn()},
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
