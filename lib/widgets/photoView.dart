import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../res/colors.dart';


 
class DPhotoView extends StatefulWidget {
  DPhotoView({Key? key, required this.imgLinks, this.initIndex = 0,this.top=0})
      : super(key: key);
  List<String> imgLinks;
  int initIndex;
  double top;

  @override
  State<DPhotoView> createState() => _DPhotoViewState();
}

class _DPhotoViewState extends State<DPhotoView> {
  PageController pageController = PageController();


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      pageController.animateToPage(widget.initIndex,
          curve: Curves.ease, duration: const Duration(microseconds: 300));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.BLACK,
          child: Stack(children: [
            PhotoViewGallery.builder(
          scrollPhysics: const ClampingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(widget.imgLinks[index]),
              initialScale: PhotoViewComputedScale.contained * 1,
              heroAttributes: const PhotoViewHeroAttributes(tag: 'abc'),
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.contained * 3
            );
          },
          itemCount: widget.imgLinks.length,
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null ? 0 : 1,
              ),
            ),
          ),
          // backgroundDecoration: widget.backgroundDecoration,
          pageController: pageController,
          onPageChanged: (index) {
            // print(index);
          },
        ),
            Positioned(
              left: 15.sp,
              top: 20.sp+widget.top,
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  width: 30.sp,
                  height: 30.sp,
                  padding: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.sp),
                      color: AppColors.WHITE
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/iconBack.svg',
                    width: 20.sp,
                    height: 20.sp,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
      ])),
    );
  }
}
