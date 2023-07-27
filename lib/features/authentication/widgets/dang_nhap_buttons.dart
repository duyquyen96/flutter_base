import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint/common/utils/spacing.dart';
import 'package:sprint/res/app_styles.dart';
import 'package:sprint/res/colors.dart';
import 'package:sprint/widgets/base_text.dart';

class DangNhapButtons extends StatelessWidget {
  const DangNhapButtons(
      {super.key,
      this.isDangNhap = true,
      this.dangNhapPress,
      this.dangKyPress});

  final void Function()? dangNhapPress, dangKyPress;
  final bool isDangNhap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.buttonHeight),
      child: Container(
        height: Spacing.buttonHeight,
        color: AppColors.gray,
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: InkWell(
              onTap: dangNhapPress,
              child: Container(
                decoration: !isDangNhap
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight:
                                Radius.circular(Spacing.buttonHeight / 2)),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.linear1,
                            AppColors.linear1,
                          ],
                        ),
                      ),
                child: Center(
                  child: AppText(
                    'Đăng nhập'.tr.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: AppStyle.DEFAULT_16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isDangNhap ? AppColors.WHITE : AppColors.BLACK,
                        height: 1.2),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: dangKyPress,
              child: Container(
                decoration: isDangNhap
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Spacing.buttonHeight / 2)),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.linear1,
                            AppColors.linear1,
                          ],
                        ),
                      ),
                child: Center(
                  child: AppText(
                    'Đăng ký'.tr.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: AppStyle.DEFAULT_16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isDangNhap ? AppColors.BLACK : AppColors.WHITE,
                        height: 1.2),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
