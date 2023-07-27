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

class ListNotify extends StatefulWidget {
  const ListNotify({Key? key}) : super(key: key);

  @override
  State<ListNotify> createState() => _ListNotifyState();
}

class _ListNotifyState extends State<ListNotify> {
  ProductController productController = ProductController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseHeader(title: 'Notify'),
          Expanded(
            child: Center(
              child: Shimmer.fromColors(
                baseColor: AppColors.skeleton1,
                highlightColor: AppColors.skeleton2,
                child: Container(
                    height: Spacing.height,
                    width: Spacing.width,
                    padding: EdgeInsets.symmetric(
                        horizontal: Spacing.paddingHorizontal),
                    child: Obx(
                      () => ListView.builder(
                        itemBuilder: (context, index) {
                          return ItemNotify();
                        },
                        itemCount: productController.list.length,
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemNotify extends StatelessWidget {
  const ItemNotify({
    super.key,
    this.hintText,
  });

  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: this.hintText == '1'
          ? Container(
              color: AppColors.red,
              child: Column(
                children: [
                  Image.network(
                      'https://lavenderstudio.com.vn/wp-content/uploads/2021/06/cach-chup-hinh-san-pham-quan-ao-dep-2.png'),
                  const Row(
                    children: [AppText('1sdf'), Spacer(), AppText('1sdf')],
                  )
                ],
              ),
            )
          : Container(
              child: Column(
                children: [
                  Shimmer.fromColors(
                      baseColor: AppColors.skeleton1,
                      highlightColor: AppColors.skeleton2,
                      child: Container(
                        width: Spacing.width,
                        height: 22.sp,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: AppColors.BLACK),
                      )),
                  SizedBox(
                    height: 4.sp,
                  ),
                  Shimmer.fromColors(
                      baseColor: AppColors.skeleton1,
                      highlightColor: AppColors.skeleton2,
                      child: Container(
                        width: Spacing.width,
                        height: 15.sp,
                        margin: EdgeInsets.only(right: 30.sp),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: AppColors.BLACK),
                      )),
                  SizedBox(
                    height: 20.sp,
                  )
                ],
              ),
            ),
    );
  }
}

final productItemWidth =
    (Spacing.width - Spacing.paddingHorizontal * 2 - 12.sp) / 2;
final productItemHeight =
    productItemWidth + 10.sp + 16.sp * 2 * 1.3 + 6.sp + 20.sp + 12.sp;
