import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WebServiceStateController extends GetxController {
  RxDouble networkProgress = RxDouble(0.0);
  RxInt loading = RxInt(0);

  setNetworkProgress(num progress) {
    networkProgress.value = progress.toDouble();
  }

  pushLoading({Widget? childLoading}) {
    loading.value++;
    if (isLoading() && Get.isDialogOpen != true) {
      Get.dialog(Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: Center(child: Lottie.asset('assets/lotties/loading.json',width: Get.width,height: 200.sp,fit: BoxFit.contain)),
        ),
      ));
    }
  }

  pushTimeout({Widget? timeout}) {
    loading.value++;
    if (isLoading() && Get.isDialogOpen != true) {
      Get.dialog(Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: Center(child: timeout ?? const Text('Tải lại')),
        ),
      ));
    }
  }

  popLoading() {
    loading.value > 0 ? loading.value-- : loading.value = 0;
    if (!isLoading() && Get.isDialogOpen == true) {
      Get.back();
    }
  }

  bool isLoading() {
    return loading.value > 0;
  }
}
