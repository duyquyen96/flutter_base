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

class ListProduct extends StatefulWidget {
  const ListProduct({Key? key, required this.stt}) : super(key: key);

  final int stt;

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  ProductController productController = ProductController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseHeader(title: 'Product'),
          Expanded(
            child: Container(
                height: Spacing.height,
                width: Spacing.width,
                color: AppColors.WHITE,
                padding:
                    EdgeInsets.symmetric(horizontal: Spacing.paddingHorizontal),
                child: Obx(
                  () => GridView.builder(
                    itemBuilder: (context, index) {
                      return ItemProduct();
                    },
                    itemCount: productController.list.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: productItemWidth,
                        mainAxisExtent: productItemHeight,
                        crossAxisSpacing: 12.sp,
                        mainAxisSpacing: 12.sp),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class ItemProduct extends StatelessWidget {
  const ItemProduct({
    super.key,
    this.hintText,
  });

  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: this.hintText != '1'
          ? Container(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                  color: AppColors.WHITE, boxShadow: [AppStyle.shadow5]),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://lavenderstudio.com.vn/wp-content/uploads/2021/06/cach-chup-hinh-san-pham-quan-ao-dep-2.png",
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  const Row(
                    children: [AppText('Váy bộ'), Spacer(), AppText("12")],
                  ),
                  const Spacer(),
                  Container(
                    height: 1,
                    color: AppColors.gray,
                  ),
                  BaseButton(
                    title: 'move to cart',
                    press: () {},
                    bgColor: const [AppColors.WHITE, AppColors.WHITE],
                    titleColor: AppColors.BLACK,
                    textSize: AppValue.FONT_SIZE_14,
                  ),
                ],
              ),
            )
          : Container(
              child: Shimmer.fromColors(
                  baseColor: AppColors.skeleton1,
                  highlightColor: AppColors.skeleton2,
                  child: Container(
                    width: Spacing.width,
                    height: 50.sp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.BLACK),
                  )),
            ),
    );
  }
}

final productItemWidth =
    (Spacing.width - Spacing.paddingHorizontal * 2 - 12.sp) / 2;
final productItemHeight =
    productItemWidth + 10.sp + 16.sp * 2 * 1.3 + 6.sp + 20.sp + 12.sp;
