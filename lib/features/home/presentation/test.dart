import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sprint/common/utils/spacing.dart';
import 'package:sprint/features/home/controllers/home_controller.dart';
import 'package:sprint/features/home/controllers/product_controller.dart';
import 'package:sprint/res/res.dart';
import 'package:sprint/widgets/base_button.dart';
import 'package:sprint/widgets/base_header.dart';

import '../../../res/app_styles.dart';
import '../../../widgets/base_page.dart';
import '../../../widgets/base_text.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ListTest extends StatefulWidget {
  const ListTest({Key? key}) : super(key: key);

  @override
  State<ListTest> createState() => _ListTestState();
}

class _ListTestState extends State<ListTest> {
  // generate dummy data to feed the second SliverGrid
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('KindaCode.com'),
          elevation: 0,
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.parse(
                  'http://127.0.0.1:5500/tvtmaaddons/index.html')), // Thay thế bằng URL của trang web của bạn
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true,
            ),
          ),
          onWebViewCreated: (controller) {
            _webViewController = controller;
            // Đăng ký kênh để lắng nghe từ JavaScript
            _webViewController.addJavaScriptHandler(
                handlerName: 'messageHandler',
                callback: (args) {
                  // Xử lý tin nhắn nhận được từ JavaScript
                  // Thông thường, bạn có thể chuyển args đến hàm hoặc trạng thái của Flutter
                  print('Received message from JavaScript: $args');
                });
          },
        ));
  }
}
