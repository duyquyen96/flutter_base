import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TestWebview extends StatefulWidget {
  const TestWebview({Key? key}) : super(key: key);

  @override
  State<TestWebview> createState() => _TestWebviewState();
}

class _TestWebviewState extends State<TestWebview> {
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
