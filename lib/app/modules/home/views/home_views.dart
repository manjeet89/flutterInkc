// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:inkc/VerificationOtpController/OtpController.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:timer_count_down/timer_count_down.dart';

// class HomeView extends GetView<HomeController> {
//   const HomeView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('OTP View'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 16, right: 16),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Obx(
//             () => PinFieldAutoFill(
//               textInputAction: TextInputAction.done,
//               controller: controller.otpEditingController,
//               decoration: UnderlineDecoration(
//                 textStyle: const TextStyle(fontSize: 16, color: Colors.blue),
//                 colorBuilder: const FixedColorBuilder(
//                   Colors.transparent,
//                 ),
//                 bgColorBuilder: FixedColorBuilder(
//                   Colors.grey.withOpacity(0.2),
//                 ),
//               ),
//               currentCode: controller.messageOtpCode.value,
//               onCodeSubmitted: (code) {},
//               onCodeChanged: (code) {
//                 controller.messageOtpCode.value = code!;
//                 controller.countdownController.pause();
//                 if (code.length == 6) {
//                   // To perform some operation
//                 }
//               },
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Countdown(
//             controller: controller.countdownController,
//             seconds: 15,
//             interval: const Duration(milliseconds: 1000),
//             build: (context, currentRemainingTime) {
//               if (currentRemainingTime == 0.0) {
//                 return GestureDetector(
//                   onTap: () {
//                     // write logic here to resend OTP
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.only(
//                         left: 14, right: 14, top: 14, bottom: 14),
//                     decoration: BoxDecoration(
//                         borderRadius: const BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                         border: Border.all(color: Colors.blue, width: 1),
//                         color: Colors.blue),
//                     width: context.width,
//                     child: const Text(
//                       "Resend OTP",
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.only(
//                       left: 14, right: 14, top: 14, bottom: 14),
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(10),
//                     ),
//                     border: Border.all(color: Colors.blue, width: 1),
//                   ),
//                   width: context.width,
//                   child: Text(
//                       "Wait |${currentRemainingTime.toString().length == 4 ? " ${currentRemainingTime.toString().substring(0, 2)}" : " ${currentRemainingTime.toString().substring(0, 1)}"}",
//                       style: const TextStyle(fontSize: 16)),
//                 );
//               }
//             },
//           ),
//         ]),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inkc/app/modules/home/controllers/home_controllers.dart';
import 'package:sms_autofill/sms_autofill.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _code = "";
  String signature = "{{ app signature }}";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const PhoneFieldHint(),
              const Spacer(),
              PinFieldAutoFill(
                decoration: UnderlineDecoration(
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  colorBuilder:
                      FixedColorBuilder(Colors.black.withOpacity(0.3)),
                ),
                currentCode: _code,
                onCodeSubmitted: (code) {},
                onCodeChanged: (code) {
                  if (code!.length == 6) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
              ),
              const Spacer(),
              TextFieldPinAutoFill(
                currentCode: _code,
              ),
              const Spacer(),
              ElevatedButton(
                child: const Text('Listen for sms code'),
                onPressed: () async {
                  await SmsAutoFill().listenForCode();
                },
              ),
              ElevatedButton(
                child: const Text('Set code to 123456'),
                onPressed: () async {
                  setState(() {
                    _code = '123456';
                  });
                },
              ),
              const SizedBox(height: 8.0),
              const Divider(height: 1.0),
              const SizedBox(height: 4.0),
              Text("App Signature : $signature"),
              const SizedBox(height: 4.0),
              ElevatedButton(
                child: const Text('Get app signature'),
                onPressed: () async {
                  signature = await SmsAutoFill().getAppSignature;
                  setState(() {});
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CodeAutoFillTestPage()));
                },
                child: const Text("Test CodeAutoFill mixin"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CodeAutoFillTestPage extends StatefulWidget {
  const CodeAutoFillTestPage({Key? key}) : super(key: key);

  @override
  State<CodeAutoFillTestPage> createState() => _CodeAutoFillTestPageState();
}

class _CodeAutoFillTestPageState extends State<CodeAutoFillTestPage>
    with CodeAutoFill {
  String? appSignature;
  String? otpCode;

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
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
    const textStyle = TextStyle(fontSize: 18);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Listening for code"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Text(
              "This is the current app signature: $appSignature",
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Builder(
              builder: (_) {
                if (otpCode == null) {
                  return const Text("Listening for code...", style: textStyle);
                }
                return Text("Code Received: $otpCode", style: textStyle);
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
