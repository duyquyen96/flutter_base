import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprint/features/authentication/presentation/signIn.dart';
import 'package:sprint/features/authentication/presentation/verify_otp.dart';
import 'package:sprint/features/home/presentation/home.dart';
import 'package:sprint/features/home/presentation/list_notify.dart';
import 'package:sprint/features/home/presentation/list_product.dart';
import 'package:sprint/features/home/presentation/test.dart';
import 'package:sprint/features/shop/category_view.dart';

import '../../../res/app_styles.dart';
import '../../../res/app_values.dart';
import '../../../res/colors.dart';
import '../../../widgets/base_page.dart';
import '../../../widgets/base_text.dart';
import '../../../widgets/my_app_bar.dart';
import 'screen.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({Key? key}) : super(key: key);

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: BasePage(
          appBarBottom: MyAppBar.bottomEmpty(
            backgroundColor: AppColors.BLACK,
          ),
          child: DoubleBackToCloseApp(
            snackBar: SnackBar(
              content: AppText('tap_to_close'.tr,
                  style: AppStyle.DEFAULT_14.copyWith(color: Colors.white)),
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      SignIn(),
                      Home(stt: 3),
                      ListProduct(stt: 3),
                      // Category()
                      ListTest()
                      // ListNotify(),
                    ],
                  )),
                  _buildMenu()
                ],
              ),
            ),
          )),
    );
  }

  _buildMenu() {
    return Container(
        height: 70,
        width: Get.width,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(children: [
          itemMenu(image: 'assets/icons/m1.svg', index: 0, title: 'Screen 1'),
          itemMenu(image: 'assets/icons/m2.svg', index: 1, title: 'Screen 2'),
          itemMenu(image: 'assets/icons/m3.svg', index: 2, title: 'Screen 3'),
          itemMenu(image: 'assets/icons/m4.svg', index: 3, title: 'Screen 4'),
        ]));
  }

  itemMenu(
      {required String image,
      required int index,
      required String title,
      String? avatar}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _tabController?.index = index;
          page = index;
        });
      },
      child: Container(
        decoration: const BoxDecoration(),
        width: Get.width / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                page == index ? AppColors.primary : AppColors.gray,
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(
                image,
                width: 25.sp,
                height: 25.sp,
              ),
            ),
            AppValue.vSpaceTiny,
            AppText(
              title,
              style: AppStyle.DEFAULT_12
                  .copyWith(color: page == index ? AppColors.primary : null),
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
