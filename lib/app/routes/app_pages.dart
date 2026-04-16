import 'package:get/get.dart';
import 'package:inkc/VerificationOtpController/OtpGet.dart';
import 'package:inkc/app/modules/home/views/home_views.dart';

import '../modules/home/bindings/home_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
