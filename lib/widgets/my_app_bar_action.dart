import 'package:flutter/material.dart';
import '/res/app_styles.dart';

import 'base_text.dart';

class LhAppBarAction extends StatelessWidget {
  final Widget? child;
  final int? badge;
  final VoidCallback? onTap;
  final double? sizeFactor;

  const LhAppBarAction({
    Key? key,
    this.badge,
    this.child,
    this.onTap,
    this.sizeFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(alignment: Alignment.center, child: child),
        if (badge != null && badge! > 0)
          Positioned(
            top: 5,
            right: 5,
            child: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500.0),
                  color: Colors.red,
                ),
                child: AppText(
                  badge! > 99 ? '99+' : '$badge',
                  style: AppStyle.DEFAULT_12.copyWith(color: Colors.white),
                )),
          )
      ],
    );
  }

  factory LhAppBarAction.custom(
      {required Widget child, int? badge, VoidCallback? onTap}) {
    return LhAppBarAction(
      badge: badge,
      child: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              height: double.infinity,
              child: child),
          if (onTap != null)
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            )),
        ],
      ),
    );
  }

  factory LhAppBarAction.icon(
      {required Widget icon,
      int? badge,
      VoidCallback? onTap,
      double? iconFactor,
      double? sizeFactor}) {
    return LhAppBarAction(
      badge: badge,
      child: Stack(
        children: [
          AspectRatio(
              aspectRatio: sizeFactor ?? 0.75,
              child: FractionallySizedBox(
                  widthFactor: iconFactor ?? 0.6,
                  heightFactor: iconFactor ?? 0.6,
                  child: icon)),
          if (onTap != null)
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.zero,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(500.0),
                    onTap: onTap,
                  ),
                ),
              ),
            )),
        ],
      ),
    );
  }
}
