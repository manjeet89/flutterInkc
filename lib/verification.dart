import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:inkc/VerificationOtpController/OtpController.dart';
import 'package:inkc/credential/login.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:sms_autofill/sms_autofill.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class VerificationOtp extends StatefulWidget {
  final String userid, number;
  VerificationOtp({super.key, required this.userid, required this.number});

  @override
  State<VerificationOtp> createState() => _VerificationOtpState();
}

class _VerificationOtpState extends State<VerificationOtp> with CodeAutoFill {
  String? appSignature;
  String? otpCode;
// CountdownController countdowncontroller = CountdownController();
  TextEditingController textEditingController = TextEditingController();
  var messageOtpCode = "".obs;

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
      textEditingController.text = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final Otpcontroller controller = Get.put(Otpcontroller());

    return WillPopScope(
      onWillPop: () async {
        // Handle Android hardware back button press
        Navigator.pop(context);
        return false; // Prevent default behavior
      },
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 38.0, right: 18, left: 18),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 100.sp,
                      width: 100.sp,
                      child: Image.asset('assets/DogRemove.png'),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 2.sp, bottom: 8.sp),
                      child: Text(
                        'Verification code',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 221, 10, 10),
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.sp, bottom: 4.sp),
                    child: Text(
                      'We have to sent the code verification to',
                      style: TextStyle(
                          color: const Color.fromARGB(232, 7, 7, 36),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Text(
                          '+91 ${widget.number.replaceRange(2, 8, '******')} ',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 10, 10, 10),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Change phone number?',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 13, 97, 223),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
                      child: Text(
                        "This is the current app signature: $appSignature",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.sp, bottom: 10),
                    child: Obx(() => PinFieldAutoFill(
                          codeLength: 4,
                          controller: textEditingController,
                          currentCode: messageOtpCode.value,
                          onCodeChanged: (code) {
                            if (code != null && code.length == 4) {
                              FocusScope.of(context).unfocus(); // Close keyboard
                              messageOtpCode.value = code;
                              Submit(context);
                              // controller.countdowncontroller.pause();
                            }
                          },
                          onCodeSubmitted: (code) {
                            print("Code submitted: $code");
                          },
                          decoration: UnderlineDecoration(
                            textStyle: TextStyle(fontSize: 20, color: Colors.white),
                            colorBuilder: FixedColorBuilder(Colors.deepOrange),
                            bgColorBuilder:
                                FixedColorBuilder(const Color.fromARGB(255, 40, 67, 83)),
                          ),
                        )),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 63, 23, 23),
                      minimumSize: const Size.fromHeight(40), // NEW
                    ),
                    onPressed: () async {
                      Submit(context);
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Submit(BuildContext context) async {
    // final Otpcontroller controller = Get.put(Otpcontroller());

    EasyLoading.showToast('Please Wait...');
    print(textEditingController.value);

    const uri = "https://inkc.in/api/login/verification";

    final responce = await http.post(
      Uri.parse(uri),
      body: {
        "user_id": widget.userid,
        "user_otp": textEditingController.text.toString()
        // first.text + second.text + thired.text + fourth.text,
      },
    );

    var data = json.decode(responce.body);
    if (data['code'].toString() == "200") {
      //   print(data['message']);

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('SuccessFully user registered...')));
      // print(data['data']['user_id']);

      EasyLoading.dismiss();

      // Get.to(MyApp());

      Timer(
          const Duration(seconds: 2),
          () => Navigator.of(context, rootNavigator: true)
              .push(MaterialPageRoute(builder: (_) => const Login())));
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, Invalid OTP.',
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid Otp')));
    }
  }
}
