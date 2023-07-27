import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../res/app_styles.dart';
import 'base_text.dart';
import 'widget_handle.dart';

class PickImage extends StatefulWidget {
  const PickImage(
      {super.key, this.image, this.imageLink, required this.result});

  final XFile? image;
  final String? imageLink;
  final void Function(XFile? image, String? imageLink) result;

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  XFile? image;
  String? imageLink;
  late void Function(XFile? image, String? imageLink) result;
  @override
  void initState() {
    image = widget.image;
    imageLink = widget.imageLink;
    result = widget.result;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PickImage oldWidget) {
    if (oldWidget.image != widget.image ||
        oldWidget.imageLink != widget.imageLink ||
        oldWidget.result != widget.result) {
      image = widget.image;
      imageLink = widget.imageLink;
      result = widget.result;
    }
    super.didUpdateWidget(oldWidget);
  }

  results() {
    result(image, imageLink);
    print('select $image $imageLink');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.sp),
          child: AppText(
            'Ảnh',
            style: AppStyle.DEFAULT_16,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.sp),
          child: SizedBox(
            height: 100.sp,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.sp),
                    child: InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          this.image = image;
                          imageLink = null;
                          setState(() {});
                        }
                        results();
                      },
                      child: SvgPicture.asset(
                        'assets/icons/chonHinhAnh.svg',
                        width: 116.sp,
                        height: 100.sp,
                      ),
                    ),
                  ),
                  if (image != null)
                    Container(
                      margin: EdgeInsets.only(right: 16.sp),
                      width: 116.sp,
                      height: 100.sp,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp)),
                      child: Stack(children: [
                        Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                          width: 116.sp,
                          height: 100.sp,
                        ),
                        Positioned(
                          top: 0.sp,
                          right: 0.sp,
                          child: InkWell(
                            onTap: () {
                              image = null;
                              setState(() {});
                              results();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: SvgPicture.asset(
                                'assets/icons/close.svg',
                                width: 16.sp,
                                height: 16.sp,
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  if (imageLink != null)
                    Container(
                      margin: EdgeInsets.only(right: 16.sp),
                      width: 116.sp,
                      height: 100.sp,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp)),
                      child: Stack(children: [
                        WidgetNetworkCacheImage(
                          image: imageLink!,
                          borderRadius: 0,
                          fit: BoxFit.cover,
                          width: 116.sp,
                          height: 100.sp,
                        ),
                        Positioned(
                          top: 0.sp,
                          right: 0.sp,
                          child: InkWell(
                            onTap: () {
                              imageLink = null;
                              setState(() {});
                              results();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: SvgPicture.asset(
                                'assets/icons/close.svg',
                                width: 16.sp,
                                height: 16.sp,
                              ),
                            ),
                          ),
                        )
                      ]),
                    )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
