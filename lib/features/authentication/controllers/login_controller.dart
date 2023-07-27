import 'dart:async';

import 'package:get/get.dart';

import '../../../config/network/http.dart';
import '../../../res/api_url.dart';

class LoginController extends GetxController {
  Rx<String?> token = Rx<String?>(null);
  Rx<bool> isDTCG = Rx<bool>(false);
  Rx<String> loginType = Rx<String>('normal');
  String code = '';

  void signIn() async {
    try {
      final body = {
        "jsonrpc": "2.0",
        "params": {"db": "v16_mobile_2", "login": "admin", "password": "admin"}
      };
      dynamic json = await http.post('http://192.168.1.85:8016${ApiUrl.LOGIN}',
          data: body, isLoading: true);
      channelDetail();
      if (json["statusCode"] != 200) {
      } else {}
    } catch (e) {
      print("error: $e");
    }
  }
}

channelDetail() async {
  try {
    final body = {
      "jsonrpc": "2.0",
      "params": {"channel_id": "1"}
    };
    dynamic json = await http.post('/mobile/messenger/channelinfo',
        data: body, isLoading: true);
    if (json["statusCode"] != 200) {
    } else {}
  } catch (e) {
    print("error: $e");
  }
}
