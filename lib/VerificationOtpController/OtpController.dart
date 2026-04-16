import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_controller.dart';

class Otpcontroller extends GetxController {
  CountdownController countdowncontroller = CountdownController();
  TextEditingController textEditingController = TextEditingController();
  var messageOtpCode = "".obs;

  @override
  void onInit() { 
    super.onInit();
    SmsAutoFill().unregisterListener(); // Cleanup
    SmsAutoFill().listenForCode(); // Start listening for SMS OTP
    getAppSignature(); // Print hash to use in SMS
  }

  void getAppSignature() async {
    final signature = await SmsAutoFill().getAppSignature;
    print("App Signature: $signature"); // Use this in your SMS template
  }

  @override
  void onReady() {
    super.onReady();
    countdowncontroller.start();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    SmsAutoFill().unregisterListener();
    super.onClose();
  }
}
