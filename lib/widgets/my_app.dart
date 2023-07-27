import 'package:flutter/material.dart';
import '/widgets/my_base_app.dart';

import '../../common/routes/app_pages.dart';
import '../../res/strings.dart';
import '../bindings/app_binding.dart';
import 'base_config.dart';

class MyApp extends BaseApp {
  const MyApp({Key? key}) : super(key: key);

  @override
  BaseConfiguration onConfig() {
    return BaseConfiguration(
      title: AppStrings.appName,
      locale: const Locale('vi', 'VN'),
      supportedLocales: [
        const Locale('vi', 'VN'),
        const Locale('en', 'US'),
      ],
      translations: AppStrings(),
      initialBinding: AppBinding(),
      initialRoute: Routes.initial,
      getPages: AppPages().routes,
      // home: SplashLoadingPage()
    );
  }
}
