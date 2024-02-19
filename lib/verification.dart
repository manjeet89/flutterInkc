import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:inkc/credential/login.dart';
import 'package:inkc/profile.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class VerificationOtp extends StatelessWidget {
  final String userid, number;
  VerificationOtp({required this.userid, required this.number});

//   @override
//   State<VerificationOtp> createState() =>
//       _VerificationOtpState(userid.toString(), number.toString());
// }

// // String mobileNumber = userid;

// class _VerificationOtpState extends State<VerificationOtp> {
  // String afterHide = mobileNumber.replaceRange(2, 8, '******');

  TextEditingController first = new TextEditingController();
  TextEditingController second = new TextEditingController();
  TextEditingController thired = new TextEditingController();
  TextEditingController fourth = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    child: Container(
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
                            color: Color.fromARGB(255, 221, 10, 10),
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
                          color: Color.fromARGB(232, 7, 7, 36),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Text(
                          '+91 ${number.replaceRange(2, 8, '******')} ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 10, 10, 10),
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
                              color: Color.fromARGB(255, 13, 97, 223),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.sp),
                    child: Form(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 68.sp,
                          width: 64.sp,
                          child: TextFormField(
                            controller: first,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            onSaved: (pin1) {},
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.sp)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.green),
                                ),
                                hintText: "0"),
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 68.sp,
                          width: 64.sp,
                          child: TextFormField(
                            controller: second,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            onSaved: (pin2) {},
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.sp)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.green),
                                ),
                                hintText: "0"),
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 68.sp,
                          width: 64.sp,
                          child: TextFormField(
                            controller: thired,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            onSaved: (pin3) {},
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.sp)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.green),
                                ),
                                hintText: "0"),
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 68.sp,
                          width: 64.sp,
                          child: TextFormField(
                            controller: fourth,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            onSaved: (pin4) {},
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.sp)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.green),
                                ),
                                hintText: "0"),
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 63, 23, 23),
                      minimumSize: const Size.fromHeight(40), // NEW
                    ),
                    onPressed: () async {
                      EasyLoading.showToast('Please Wait...');

                      final uri = "https://www.inkc.in/api/login/verification";

                      final responce = await http.post(
                        Uri.parse(uri),
                        body: {
                          "user_id": userid,
                          "user_otp": first.text +
                              second.text +
                              thired.text +
                              fourth.text,
                        },
                      );

                      var data = json.decode(responce.body);
                      if (data['code'] == 200) {
                        //   print(data['message']);

                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('SuccessFully user registered...')));
                        // print(data['data']['user_id']);

                        EasyLoading.dismiss();

                        // Get.to(MyApp());

                        Timer(
                            Duration(seconds: 2),
                            () => Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                                    builder: (_) => Login())));
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Oops...',
                          text: 'Sorry, Invalid OTP.',
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid Otp')));
                      }
                    },
                    child: Text(
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
}
