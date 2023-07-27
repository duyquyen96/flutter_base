import 'package:get/get.dart';
import 'package:sprint/common/utils/modal.dart';

import '../../widgets/message.dart';
import '../routes/app_pages.dart';

class BaseRes {
  int? status;
  String? message;

  BaseRes({
    this.status,
    this.message,
  });

  BaseRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

void responseHandler({
  required dynamic response,
  void Function()? success,
  void Function()? error,
  void Function()? successOk,
  void Function()? errorOk,
  bool errorShow = true,
  bool successShow = false,
  bool isSuccesCustom = false,
  bool isUnauthorized = false,
  String? messageSuccesCustom,
  String? messageErrorCustom,
  String? messageUnauthorizedCustom,
  bool? showLeftButton,
}) {
  if (response == 1) {
    showModal(Message(
      content: 'Vui lòng kiểm tra kết nối internet!'.tr,
      title: 'Thông báo'.tr,
      showLeftButton: false,
    ));
  } else if (response == 1) {
    showModal(Message(
      content: 'Có lỗi xảy ra, vui lòng thử lại sau!'.tr,
      title: 'Thông báo'.tr,
      showLeftButton: false,
    ));
  } else {
    final baseRes = BaseRes.fromJson(response);
    if (isSuccesCustom || baseRes.status == 200) {
      if (success is Function) success!();
      if (successShow) {
        showModal(Message(
          content: messageSuccesCustom ?? baseRes.message ?? '',
          title: 'Thông báo'.tr,
          rightPress: successOk,
          showLeftButton:
              showLeftButton ?? (successOk is Function ? true : false),
        ));
      }
    } else if (isUnauthorized || baseRes.status == 100) {
      showModal(Message(
        content: messageUnauthorizedCustom ?? baseRes.message ?? '',
        title: 'Thông báo'.tr,
        rightPress: () async {
          Get.back();
          // await resetUser();
          Get.offAllNamed(Routes.signIn);
        },
        showLeftButton: false,
      ));
    } else {
      if (error is Function) error!();
      if (errorShow) {
        showModal(Message(
          content: messageErrorCustom ?? baseRes.message ?? '',
          title: 'Thông báo'.tr,
          rightPress: errorOk,
          showLeftButton:
              showLeftButton ?? (errorOk is Function ? true : false),
        ));
      }
    }
  }
}
