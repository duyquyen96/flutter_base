import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'base_config.dart';

abstract class BaseApp extends StatefulWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  _MyBaseAppState createState() => _MyBaseAppState();

  BaseConfiguration onConfig();
}

class _MyBaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 890),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: widget.onConfig().title ?? '',
            translations: widget.onConfig().translations,
            locale: widget.onConfig().locale,
            supportedLocales: widget.onConfig().supportedLocales ?? [],
            initialRoute: widget.onConfig().initialRoute,
            getPages: widget.onConfig().getPages,
            initialBinding: widget.onConfig().initialBinding,
            home: widget.onConfig().home,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        });
  }
}
