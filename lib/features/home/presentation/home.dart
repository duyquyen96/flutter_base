import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sprint/common/utils/spacing.dart';
import 'package:sprint/features/home/controllers/home_controller.dart';
import 'package:sprint/features/home/widgets/home_header.dart';
import 'package:sprint/res/res.dart';
import 'package:sprint/widgets/base_button.dart';
import 'package:sprint/widgets/base_text.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.stt}) : super(key: key);

  final int stt;

  @override
  State<Home> createState() => _ScreenState();
}

class _ScreenState extends State<Home> {
  HomeController homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: Spacing.height,
          child: Column(
            children: [
              HomeHeader(title: ''),
              _viewImages(context, slides),
              Expanded(
                  child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 16.sp),
                  itemCount: homeController.list.length,
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        child: Container(
                          width: Spacing.width,
                          height: 50,
                          color: index == 1 ? AppColors.BLACK : AppColors.gray,
                        ));
                  },
                ),
              )),
              const Row(
                children: [AppText('data'), Spacer(), AppText('View all')],
              ),
              BaseButton(
                title: 'add',
                press: () {
                  final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
                    url:
                        'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html', //vnpay url, default is https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
                    version: '2.0.1',
                    tmnCode: 'XXX', //vnpay tmn code, get from vnpay
                    txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
                    orderInfo:
                        'Pay 30.000 VND', //order info, default is Pay Order
                    amount: 30000,
                    returnUrl:
                        'https://abc.com/return', //https://sandbox.vnpayment.vn/apis/docs/huong-dan-tich-hop/#code-returnurl
                    ipAdress: '192.168.10.10',
                    vnpayHashKey: 'XXX', //vnpay hash key, get from vnpay
                    vnPayHashType: VNPayHashType
                        .HMACSHA512, //hash type. Default is HmacSHA512, you can chang it in: https://sandbox.vnpayment.vn/merchantv2
                  );
                  VNPAYFlutter.instance.show(
                    paymentUrl: paymentUrl,
                    onPaymentSuccess: (params) {
                      setState(() {});
                    },
                    onPaymentError: (params) {
                      setState(() {});
                    },
                  );
                },
              ),
            ],
          )),
    );
  }
}

Widget _viewImages(BuildContext context, List<dynamic> images) {
  return Stack(
    children: [
      CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            height: 340,
          ),
          items: images.map((e) {
            return Image.network(
              e?.toString() ?? imageError,
              fit: BoxFit.cover,
              width: Get.width,
            );
          }).toList()),
      Positioned(
        top: 50.h,
        left: 30.w,
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.BLACK.withOpacity(0.5),
            ),
            child: SvgPicture.asset('assets/icons/back.svg'),
          ),
        ),
      ),
      Positioned(
        top: 50.h,
        right: 30.w,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.BLACK.withOpacity(0.5),
            ),
            child: SvgPicture.asset(
              'assets/icons/group-15090.svg',
            ),
          ),
        ),
      )
    ],
  );
}

String imageError =
    'https://lavenderstudio.com.vn/wp-content/uploads/2021/06/cach-chup-hinh-san-pham-quan-ao-dep-2.png';

dynamic slides = [imageError, imageError, imageError];
