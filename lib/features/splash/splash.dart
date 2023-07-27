import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint/common/routes/app_pages.dart';
import 'package:sprint/common/utils/spacing.dart';
import 'package:sprint/res/app_styles.dart';
import 'package:sprint/res/colors.dart';

import 'package:sprint/widgets/base_text.dart';

bool isFake = true;
String tokenFirebase = '';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getFake();
      await getInfo();
    });
  }

  getFake() async {
    if (Platform.isAndroid) {
      isFake = false;
    } else {
      final dio = Dio();
      final response = await dio.get(
          'https://raw.githubusercontent.com/hoanghuy22233/ios_fake/main/sociallife_fake');
      if (response.data.toString().trim() == '1') {
        isFake = true;
      } else {
        isFake = false;
      }
    }
  }

  getInfo() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    tokenFirebase = await messaging.getToken() ?? '';
    print('tokenFirebase: $tokenFirebase');

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
    } else {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Get.offAllNamed(Routes.bottomTab);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: Spacing.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 4,
              ),
              Image.asset(
                'assets/images/appLogo.png',
                width: 115.sp,
                height: 115.sp,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.sp),
                child: AppText(
                  'Đông á'.tr,
                  style: AppStyle.DEFAULT_20.copyWith(
                      color: AppColors.WHITE, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.sp),
                child: AppText(
                  'Content'.tr.toUpperCase(),
                  style: AppStyle.DEFAULT_14.copyWith(color: AppColors.WHITE),
                ),
              ),
              const Spacer(
                flex: 6,
              )
            ],
          ),
        )
      ]),
    );
  }
}
