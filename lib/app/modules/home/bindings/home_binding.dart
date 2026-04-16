import 'package:get/get.dart';
import 'package:inkc/VerificationOtpController/OtpController.dart';
import 'package:inkc/app/modules/home/controllers/home_controllers.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
