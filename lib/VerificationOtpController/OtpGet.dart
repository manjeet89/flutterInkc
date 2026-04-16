import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inkc/VerificationOtpController/OtpController.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:http/http.dart' as http;

class Otpget extends StatefulWidget {
  const Otpget({super.key});

  @override
  State<Otpget> createState() => _OtpgetState();
}

class _OtpgetState extends State<Otpget> {
  @override
  void initState() {
    super.initState();
    // SendMessage();
  }

  Future<void> SendMessage() async {
    const uri = "https://new-demo.inkcdogs.org/api/login/forgotpassword";
    print("Sending OTP...");
    final response = await http.post(
      Uri.parse(uri),
      body: {
        "user_phone_number": "9630296544",
        "user_password": "123456789",
        "confirm_password": "123456789"
      },
    );

    var data = json.decode(response.body);
    print(data);
    if (data['code'] == 200) {
      print("OTP Sent Successfully");
    } else {
      print("OTP Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final Otpcontroller controller = Get.put(Otpcontroller());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => PinFieldAutoFill(
                    codeLength: 4,
                    controller: controller.textEditingController,
                    currentCode: controller.messageOtpCode.value,
                    onCodeChanged: (code) {
                      if (code != null && code.length == 4) {
                        FocusScope.of(context).unfocus(); // Close keyboard
                        controller.messageOtpCode.value = code;
                        controller.countdowncontroller.pause();
                      }
                    },
                    onCodeSubmitted: (code) {
                      print("Code submitted: $code");
                    },
                    decoration: UnderlineDecoration(
                      textStyle: TextStyle(fontSize: 20, color: Colors.black),
                      colorBuilder: FixedColorBuilder(Colors.transparent),
                      bgColorBuilder: FixedColorBuilder(Colors.grey.shade200),
                    ),
                  )),
              const SizedBox(height: 20),
              Countdown(
                controller: controller.countdowncontroller,
                seconds: 15,
                interval: const Duration(seconds: 1),
                build: (context, currentRemainingTime) {
                  if (currentRemainingTime == 0.0) {
                    return GestureDetector(
                      onTap: () {
                        controller.countdowncontroller.restart();
                        SendMessage(); // Resend OTP
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(14),
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          border: Border.all(color: Colors.blue),
                        ),
                        child: const Text(
                          "Resend OTP",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(14),
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Text(
                        "Wait | ${currentRemainingTime.toInt()}s",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:permission_handler/permission_handler.dart';

// class Otpget extends StatefulWidget {
//   @override
//   _OtpgetState createState() => _OtpgetState();
// }

// class _OtpgetState extends State<Otpget> with CodeAutoFill {
//   String? otpCode;

//   @override
//   void initState() {
//     super.initState();
//     SendMessage();
//     _requestSMSPermission();
//     listenForCode(); // Start listening
//   }

//   Future<void> _requestSMSPermission() async {
//     await Permission.sms.request();
//   }

//   @override
//   void codeUpdated() {
//     setState(() {
//       otpCode = code;
//     });
//     print("Received OTP: $otpCode");
//   }

//   @override
//   void dispose() {
//     cancel(); // Stop listening
//     super.dispose();
//   }

//   Future<void> SendMessage() async {
//     const uri = "https://new-demo.inkcdogs.org/api/login/forgotpassword";
//     print("Sending OTP...");
//     final response = await http.post(
//       Uri.parse(uri),
//       body: {
//         "user_phone_number": "9630296544",
//         "user_password": "123456789",
//         "confirm_password": "123456789"
//       },
//     );

//     var data = json.decode(response.body);
//     // print(data);
//     if (data['code'] == 200) {
//       print("OTP Sent Successfully");
//     } else {
//       print("OTP Failed");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Enter OTP')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             PinFieldAutoFill(
//               codeLength: 4,
//               currentCode: otpCode,
//               onCodeChanged: (code) {
//                 if (code != null && code.length == 4) {
//                   print("Manually entered: $code");
//                 }
//               },
//             ),
//             SizedBox(height: 20),
//             Text("Waiting for OTP SMS..."),
//           ],
//         ),
//       ),
//     );
//   }
// }
