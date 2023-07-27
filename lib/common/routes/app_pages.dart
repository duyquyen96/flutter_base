import 'package:get/get.dart';
import 'package:sprint/features/authentication/presentation/signIn.dart';
import 'package:sprint/features/authentication/presentation/verify_otp.dart';

import 'package:sprint/features/splash/splash.dart';

import '../../features/home/presentation/bottom_tab.dart';

import 'common_pages.dart';

part 'app_routes.dart';

class AppPages extends CommonPages {
  AppPages();

  @override
  List<GetPage> onConfig() {
    return [
      GetPage(name: Routes.bottomTab, page: () => const BottomTab()),
      GetPage(name: Routes.splash, page: () => const Splash()),
      GetPage(name: Routes.signIn, page: () => const SignIn()),
      GetPage(name: Routes.verifyOtp, page: () => const VerifyOtp()),
    ];
  }
}
